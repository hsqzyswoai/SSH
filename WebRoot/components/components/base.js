/**
 * 系统底层JS封装
 * 依赖jquery
 * @author lxg
 */
(function (window) {

    var $ = window.$;

    //控制台处理，避免低版本IE浏览器JS错误
    window.console = window.console || {
        log: function (str) {
        }, debug: function (str) {
        }, error: function (str) {
        }
    };
    window.console.debug = window.console.debug || function (str) {
    };

    /*===========================原型扩展 start==============================*/
    /**
     * 字符串替换全部
     */
    String.prototype.replaceAll = function (s1, s2) {
        return this.replace(new RegExp(s1, "gm"), s2);
    };

    /**
     * 对Date的扩展，将 Date 转化为指定格式的String
     * 月(M)、日(d)、12小时(h)、24小时(H)、分(m)、秒(s)、周(E)、季度(q) 可以用 1-2 个占位符
     * 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)
     * eg:
     * (new Date()).pattern("yyyy-MM-dd hh:mm:ss.S") ==> 2013-07-02 08:09:04.423
     * (new Date()).pattern("yyyy-MM-dd E HH:mm:ss") ==> 2013-03-10 二 20:09:04
     * (new Date()).pattern("yyyy-MM-dd EE hh:mm:ss") ==> 2013-03-10 周二 08:09:04
     * (new Date()).pattern("yyyy-MM-dd EEE hh:mm:ss") ==> 2013-03-10 星期二 08:09:04
     * (new Date()).pattern("yyyy-M-d h:m:s.S") ==> 2013-7-2 8:9:4.18
     */
    Date.prototype.pattern = function (fmt) {
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "h+": this.getHours() % 12 == 0 ? 12 : this.getHours() % 12, //小时
            "H+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        var week = {
            "0": "\u65e5",
            "1": "\u4e00",
            "2": "\u4e8c",
            "3": "\u4e09",
            "4": "\u56db",
            "5": "\u4e94",
            "6": "\u516d"
        };
        if (/(y+)/.test(fmt)) {
            fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        }
        if (/(E+)/.test(fmt)) {
            fmt = fmt.replace(RegExp.$1, ((RegExp.$1.length > 1) ? (RegExp.$1.length > 2 ? "\u661f\u671f" : "\u5468") : "") + week[this.getDay() + ""]);
        }
        for (var k in o) {
            if (new RegExp("(" + k + ")").test(fmt)) {
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
            }
        }
        return fmt;
    };

    /*===========================原型扩展 end==============================*/


    /*===========================Base Api start============================*/
    var Base = {};

    /**
     * 基于jQuery Ajax二次封装，统一处理失败，会话失效问题
     * @param options 主要参数如下：
     * type 请求类型【POST,GET】，默认POST
     * dataType 请求数据类型，默认json，如请求文本，xml格式数据需要调整
     * success 成功回调函数，参数（1、返回数据，2、请求返回状态，3、请求参数）
     * showException 是否提示后台成功返回的异常信息，默认true
     */
    Base.ajax = function (options) {
        //成功回调加入后台异常信息提示
        options.callback = options.success;
        delete options.success;
        
        var isShowWaitbar = options.isShowWaitbar || true;
        
        if (isShowWaitbar && KT.Wait) {
        	KT.Wait.show({});
        }
        var defaultOptions = {
            type: 'POST',
            dataType: 'json',
            success: function (data, textStatus) {
            	if (isShowWaitbar && KT.Wait) {
		        	KT.Wait.hide();
		        }
                //统一处理后台返回的异常信息
                if (options.showException != false && typeof(data) == "object" && data && data.SUCCESS == "false") {
                    Base.alert(data["MESSAGE"]);
                    return;
                }
                if ($.isFunction(options.callback)) {
                    options.callback(data, textStatus, options.data);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                if (textStatus == 'timeout') {
                    Base.alert("请求超时，请稍候重试！");
                    return;
                }
                //session超时，开迷你登录窗
                if (typeof(XMLHttpRequest.status) == 'number' && 9999 == XMLHttpRequest.status) {
                    //开窗登录
                    Base.openMinLoginWin(function () {
                        Base.ajax(options);
                    });
                    return;
                }
                Base.alert("服务器繁忙，请稍候重试！");
            }
        };
        $.ajax($.extend({}, defaultOptions, options));
    }


    /**
     * 检查SESSION是否有效
     */
    Base.checkSession = function () {
        var result = false;
        $.ajax({
            url: Base.getContextPath() + "/login/checkSession",
            type: 'POST',
            async: false,
            success: function (data, textStatus) {
                result = data;
            }
        });
        return result;
    }


    /**
     * 会话失败时打开迷你登陆窗
     */
    Base.openMinLoginWin = function (fn) {

        //在TOP页面上处理
        var TopWindow = Base.getTopWindow();

        //绑定登陆后回调事件
        if (!$.isFunction(TopWindow.afterMinLogin)) {

            /**
             * 成功登录后执行
             */
            TopWindow.afterMinLogin = function () {
                //隐藏窗口
                TopWindow.LOGIN_WIN.hide(function () {
                    TopWindow.LOGIN_WIN = null;
                    //执行过期前请求
                    for (var i = 0; i < TopWindow.FN_ARRAY.length; i++) {
                        TopWindow.FN_ARRAY[i].call(this);
                    }
                    TopWindow.FN_ARRAY = [];
                });
            }
        }
        //保存登陆后执行的方法
        if ($.isFunction(fn)) {
            if (!TopWindow.FN_ARRAY) {
                TopWindow.FN_ARRAY = [];
            }
            TopWindow.FN_ARRAY.push(fn);
        }
        //已经打开登陆窗，防止重复
        if (TopWindow.LOGIN_WIN != null) {
            return;
        }
        var url = Base.getContextPath() + '/minlogin1.jsp';
        TopWindow.LOGIN_WIN = Base.dialog({
            title: "会话过期，请重新登录",
            checkSession: false,//不检查SESSION
            width: 300,
            height: 245,
            url: url,
            modal: true,
            scrollbar: true,
            closeButtonEnable: false,
            confirmButtonEnable: false,
            closeable: false,
            draggable: true
        });
    }

    /**
     * 获取顶层窗体对象
     */
    Base.getTopWindow = function () {
        return window.top;
    };

    /**
     * 获取应用上下文路径
     */
    Base.getContextPath = function () {
        var ctx = window.ctx || window.path;
        if (typeof(ctx) == 'undefined') {
            ctx = window.document.location.pathname;
            ctx = ctx.substring(0, ctx.substr(1).indexOf('/') + 1);
        }
        return ctx;
    };
    
    /**
     * 原生window弹窗
     */
    Base.open = function (options) {
    	var defaultOpts = {
    		width : window.screen.availWidth,
    		height: window.screen.availHeight,
    		left : 0,
    		top : 50
    	};
    
    	var screenHeight = window.screen.availHeight;
		var screenWidth = window.screen.availWidth;
    	var height = options.height||screenHeight;
    	var width = options.width||screenWidth;
    	var left = options.left || 0;
    	var top = options.top || 50;
    	if(!options.left) {
			left = (screenWidth - width)/2;
    	}
    	var mesg = "height="+height+",width="+width+",top=" + top + ",left=" + left;
    	if(!options.other) {
			mesg+=options.other;
    	}
        options = options || {};
        var tmpUrl = options.url;
        return window.open(tmpUrl,"_blank", mesg);
    };
    


    /**
     * 弹窗组件
     * @param options 
     * {id:'主键', width: 120（宽）,height: 高, url: '页面地址', content: '内容（可以支持html）',
         confirmButtonText: '确定',confirmButtonEnable: true（是否显示确定按钮）,confirm:function(index){} 确定按钮是回调方法 这3个选项要引入layer.js 才能使用
     }
     */
    Base.dialog = function (options) {
    	if (typeof(layer) == 'undefined' || !layer.open) {	//兼容原来的旧弹窗
	        options = options || {};
	        var html = options.html || options.content;	//layer与 boxy的差异
	        if (options.url) {
	            var wid = options.width ? options.width + 'px' : 'auto';
	            var height = options.height ? options.height + 'px' : 'auto';
	            var id = options.id ? ' id="' + options.id + '" ' : "";
	            html = '<div ' + id + ' style="height: ' + height + ';width: ' + wid + ';overflow: auto;">' +
	                '<iframe style="height: 100%;width: 100%;overflow: auto;z-index:90;" frameborder="0"';
	            html += ' src="' + options.url + '"></iframe></div>';
	        }
	        return new Boxy(html, options);
      	}
      	options.content = options.content || options.html;	//layer与 boxy的差异
        
        var defaults = {
            id: null,
            title: '提示',
            content: '<p>内容</p>',
            url: null,
            urlType: 'iframe', //load,iframe
            width: 0,
            height: 0,
            padding: true,//内容边距
            closeable: true,
            modal: true,
            closeButtonText: '关闭',
            closeButtonEnable: true,
            confirmButtonText: '确定',
            confirmButtonEnable: true,
            modalOption: {},
            unloadOnHide: true,//隐藏时销毁
            footerEnable: true,//底部栏
            confirm: function () {
                return true;
            },
            show: function () {
            },
            shown: function () {
            },
            hide: function () {
            },
            hidden: function () {
            }
        };
        options = $.extend(defaults, options);

        var area;
        if (options.width > 0 && options.height == 0) {
            area = options.width + 'px';
        } else if (options.width > 0 && options.height > 0) {
            area = [options.width + 'px', options.height + 'px'];
        }
        
        //1页面、2iframe
        var type = 1;
        var index;
        if (options.urlType == 'iframe' && options.url) {
            options.content = options.url;
            type = 2;
            openMethod();
        } else if (options.urlType == 'load' && options.url) {
            $.get(options.url, function (str) {
                options.content = str;
                openMethod();
            });
        } else {
            openMethod();
        }
        function openMethod() {
        	var params = {
                type: type,
//                title: options.title,
                area: area
//                ,content: options.content
            };
            params = $.extend({},params ,options);
            
            var btns = [];
            if(options.confirmButtonEnable){
            	btns.push(options.confirmButtonText);
            	params = $.extend({},params,{yes:options.confirm});
            }
            if(options.closeButtonEnable){
            	btns.push(options.closeButtonText);
            	params = $.extend({},params,{no: function(index){
									 layer.close(index); //一般设定no回调，必须进行手工关闭
							    }});
            }
            if(btns.length>0){
            	params = $.extend({},params,{btn:btns});
            }
             index = layer.open(params);
        }
        
        return index;
    }


    /**
     * 提示框
     * @param message 内容
     * @param callback 确认回调函数
     * @param options
     * @returns {*}
     */
    Base.alert = function (message, callback, options) {
    	if (typeof(layer) != 'undefined' && layer.alert) {
	        layer.alert(message, function (index) {
	            var flag = true;
	            if ($.isFunction(callback)) {
	                flag = callback();
	            }
	            if (flag != false) {
	                layer.close(index);
	            }
	        });
	        
	        return;
    	}
    	
    	options = $.extend({title:'信息'}, options);
		return Boxy.ask(message, ['确认'], callback, options);
    }

    /**
     * 确认框
     * @param message 内容
     * @param after 确认回调函数
     * @param options
     * @returns {*}
     */
    Base.confirm = function (message, ok, cancel, options) {
    	options = $.extend({title:'确认'}, options);
    	
    	if (typeof(layer) != 'undefined' && layer.alert) {
	        layer.confirm(message, function (index) {
	            if ($.isFunction(ok)) {
	                ok();
	            }
	            layer.close(index);
	        }, function (index) {
	            if ($.isFunction(cancel)) {
	                cancel();
	            }
	            layer.close(index);
	        });
	        
	        return;
    	}
    	//兼容以前的boxy
    	return Boxy.ask(message, ['确认', '取消'], function (response) {
            if (response == '确认') ok();
            if (response == '取消') cancel();
        }, options);
    }
    
    /**
	 * 渲染模板中的占位符
	 * @param template
	 * @param json
	 */
	Base.renderTemplate = function(template, json) {
//	    for (var key in json) {
//	        if (typeof(json[key]) == "string" || typeof(json[key]) == "number") {
//	            template = template.replaceAll("{" + key + "}", json[key]);
//	        }else if(!json[key]) {
//	            template = template.replaceAll("{" + key + "}", '');
//	        }
//	    }
	    
		return template.replace(/([{]{1}\w+[}]{1})/g, function(tmpWord){
			var tmpKey = tmpWord.substring(1,tmpWord.length -1);
			var tmpVal = json[tmpKey];
			if (typeof(tmpVal) == "string" || typeof(tmpVal) == "number") {
				return tmpVal;
	        }
			return '';
		});
	    
	    //return template;
	};
	
	/*
	**如果对象未定义，或者为空，或者是空字符串，返回真，否则返回假
	*/
	Base.IsEmpty = window.IsEmpty = window.IsEmpty || function(obj){
		if(typeof(obj)=="undefined"||obj==null||(typeof(obj)!="object"&&(obj+"").replace(/ /g,"")=="")){//||obj.length==0
			return true;
		}
		return false;
	};
	
	/**
	 * 判断是否是function
	 */
	Base.isFunction = $.isFunction;
	
	/**
	 * 字符串转date
	 * 将 2014-10-1 12:30:15 字符串转成Date类型 TODO 待完善
	 * 兼容  2014/10/1 12:30:15 
	 */
	Base.strToDate = function (str) {// 
		if (str && str.indexOf('-') >= 0) {
			str = str.replace(/-/g,"/");
			return new Date(str);
		}
		return null;
	};
	
	/**
	 * 去（前后）空格
	 */
	Base.trim = function (str) {
		return $.trim(str);
	};
	
	/**
	 * 渲染模板中的占位符
	 * @param template
	 * @param json
	 */
	Base.JSON = {
		decode: function(str) {
			if (typeof(str)!="string") {
				return str;
			}
			
			if (typeof(JSON)!='undefined' && JSON.parse) {
				return JSON.parse(str);
			} else {
				try{
					return eval('('+str+')');
				}catch(e){
					return str;
				}
			}
		},
		toJSON: function(o) {
			if (JSON && JSON.stringify) {
				var tmp = JSON.stringify(o);
				if($.browser.msie && $.browser.version<=8){
					eval("tmp = '" + JSON.stringify(o) +"';");
				}
				return tmp;
			} else {
		        if(typeof(JSON)=='object'&&JSON.stringify)return JSON.stringify(o);
		        var type=typeof(o);
		        if(o===null)return"null";
		        if(type=="undefined")return undefined;
		        if(type=="number"||type=="boolean")return o+"";
		        if(type=="string")return $.quoteString(o);
		        if(type=='object'){
		            if(typeof o.toJSON=="function")return $.toJSON(o.toJSON());
		            if(o.constructor===Date){
		                var month=o.getUTCMonth()+1;
		                if(month<10)month='0'+month;
		                var day=o.getUTCDate();
		                if(day<10)day='0'+day;
		                var year=o.getUTCFullYear();
		                var hours=o.getUTCHours();
		                if(hours<10)hours='0'+hours;
		                var minutes=o.getUTCMinutes();
		                if(minutes<10)minutes='0'+minutes;
		                var seconds=o.getUTCSeconds();
		                if(seconds<10)seconds='0'+seconds;
		                var milli=o.getUTCMilliseconds();
		                if(milli<100)milli='0'+milli;
		                if(milli<10)milli='0'+milli;
		                return'"'+year+'-'+month+'-'+day+'T'+hours+':'+minutes+':'+seconds+'.'+milli+'Z"';
		            }
		            //if(o.constructor===Array){
		            if(o.constructor.toString().indexOf("Array")>0){
		                var ret=[];
		                for(var i=0;i<o.length;i++)
		                    ret.push($.toJSON(o[i])||"null");
		                return"["+ret.join(",")+"]";
		            }
		            var pairs=[];
		            for(var k in o){
		                var name;
		                var type=typeof k;
		                if(type=="number")name='"'+k+'"';
		                else if(type=="string")name=$.quoteString(k);
		                else continue;
		                if(typeof o[k]=="function")continue;
		                var val=$.toJSON(o[k]);
		                pairs.push(name+":"+val);
		            }
		            return"{"+pairs.join(", ")+"}";
		        }
			}
		}
	};

    /*===========================Base Api end============================*/

    /*=================================Boxy弹窗组件 start=========================*/
    function Boxy(element, options) {

        this.boxy = $(Boxy.WRAPPER);
        $.data(this.boxy[0], 'boxy', this);

        this.visible = false;
        this.options = $.extend({}, Boxy.DEFAULTS, options || {});

        if (this.options.modal) {
            this.options = $.extend(this.options, {center: true, draggable: true});
        }

        // options.actuator == DOM element that opened this boxy
        // association will be automatically deleted when this boxy is remove()d
        if (this.options.actuator) {
            $.data(this.options.actuator, 'active.boxy', this);
        }

        this.setContent(element || "<div></div>");
        this._setupTitleBar();
        var topWin = Base.getTopWindow();
        this.boxy.css('display', 'none').appendTo(topWin.document.body);
        this.toTop();

        if (this.options.fixed) {
            if ($.browser.msie && $.browser.version < 7) {
                this.options.fixed = false; // IE6 doesn't support fixed positioning
            } else {
                this.boxy.addClass('fixed');
            }
        }

        if (this.options.center && Boxy._u(this.options.x, this.options.y)) {
            this.center();
        } else {
            this.moveTo(
                Boxy._u(this.options.x) ? this.options.x : Boxy.DEFAULT_X,
                Boxy._u(this.options.y) ? this.options.y : Boxy.DEFAULT_Y
            );
        }
        if (this.options.show) this.show();
    };
    Boxy.EF = function () {
    };
    $.extend(Boxy, {
        WRAPPER: "<table cellspacing='0' cellpadding='0' border='0' class='boxy-wrapper'>" +
            "<tr><td class='top'></td></tr>" +
            "<tr></td><td class='boxy-inner'></td></tr>" +
            "<tr></td><td class='bottom'></td></tr>" +
            "</table>",
        DEFAULTS: {
            onTop: true,       //设置是否在TOP页面上显示
            title: null,           // titlebar text. titlebar will not be visible if not set.
            closeable: true,           // display close link in titlebar?
            draggable: true,           // can this dialog be dragged?
            clone: false,          // clone content prior to insertion into dialog?
            actuator: null,           // element which opened this dialog
            center: true,           // center dialog in viewport?
            show: true,           // show dialog immediately?
            modal: false,          // make dialog modal?
            fixed: true,           // use fixed positioning, if supported? absolute positioning used otherwise
            closeText: '×',      // text to use for default close link
            unloadOnHide: false,          // should this dialog be removed from the DOM after being hidden?
            clickToFront: false,          // bring dialog to foreground on any click (not just titlebar)?
            location: "center",//top,center,
            behaviours: Boxy.EF,        // function used to apply behaviours to all content embedded in dialog.
            afterDrop: Boxy.EF,        // callback fired after dialog is dropped. executes in context of Boxy instance.
            afterShow: Boxy.EF,        // callback fired after dialog becomes visible. executes in context of Boxy instance.
            afterHide: Boxy.EF,        // callback fired after dialog is hidden. executed in context of Boxy instance.
            beforeUnload: Boxy.EF         // callback fired after dialog is unloaded. executed in context of Boxy instance.
        },
        DEFAULT_X: 50,
        DEFAULT_Y: 50,
        zIndex: 13370,
        dragConfigured: false,
        resizeConfigured: false,
        dragging: null,

        //获取弹窗对象
        get: function (ele) {
            var p = $(ele).parents('.boxy-wrapper');
            return p.length ? $.data(p[0], 'boxy') : null;
        },
        linkedTo: function (ele) {
            return $.data(ele, 'active.boxy');
        },
        //对话框
        ask: function (question, answers, callback, options) {
            options = $.extend({modal: true, closeable: false, location: "center"},
                    options || {},
                {show: true, unloadOnHide: true});
            var body = $('<div></div>').append($('<div class="question"></div>').html(question));
            var map = {}, answerStrings = [];
            if (answers instanceof Array) {
                for (var i = 0; i < answers.length; i++) {
                    map[answers[i]] = answers[i];
                    answerStrings.push(answers[i]);
                }
            } else {
                for (var k in answers) {
                    map[answers[k]] = k;
                    answerStrings.push(answers[k]);
                }
            }
            var buttons = $('<form class="answers"></form>');
            buttons.html($.map(answerStrings, function (v) {
                var btn_index;
                if (v === "确认") {
                    btn_index = 1;
                } else if (v === "取消") {
                    btn_index = 2;
                } else {
                    btn_index = 3;
                }
                return "<input class='boxy-btn" + btn_index + "' type='button' value='" + v + "' />";
            }).join(' '));
            $('input[type=button]', buttons).click(function () {
                var clicked = this;
                Boxy.get(this).hide(function () {
                    if (callback) callback(map[clicked.value]);
                });
            });
            body.append(buttons);
            new Boxy(body, options);
        },
        isModalVisible: function () {
            return $('.boxy-modal-blackout').length > 0;
        },
        _u: function () {
            for (var i = 0; i < arguments.length; i++)
                if (typeof arguments[i] != 'undefined') return false;
            return true;
        },
        _handleResize: function (evt) {
            var d = $(document);
            $('.boxy-modal-blackout').css('display', 'none').css({
                width: d.width(), height: d.height()
            }).css('display', 'block');
        },

        _handleDrag: function (evt) {
            var d;
            if (d = Boxy.dragging) {
                d[0].boxy.css({left: evt.pageX - d[1], top: evt.pageY - d[2]});
            }
        },

        _nextZ: function () {
            return Boxy.zIndex++;
        },

        _viewport: function () {
            var topWin = Base.getTopWindow();
            var d = topWin.document.documentElement, b = topWin.document.body, w = topWin;
            return $.extend(
                $.browser.msie ?
                { left: b.scrollLeft || d.scrollLeft, top: b.scrollTop || d.scrollTop } :
                { left: w.pageXOffset, top: w.pageYOffset },
                !Boxy._u(w.innerWidth) ?
                { width: w.innerWidth, height: w.innerHeight } :
                    (!Boxy._u(d) && !Boxy._u(d.clientWidth) && d.clientWidth != 0 ?
                    { width: d.clientWidth, height: d.clientHeight } :
                    { width: b.clientWidth, height: b.clientHeight }));
        }

    });
    Boxy.prototype = {
        estimateSize: function () {
            this.boxy.css({visibility: 'hidden', display: 'block'});
            var dims = this.getSize();
            this.boxy.css('display', 'none').css('visibility', 'visible');
            return dims;
        },
        getSize: function () {
            return [this.boxy.width(), this.boxy.height()];
        },
        getContentSize: function () {
            var c = this.getContent();
            return [c.width(), c.height()];
        },
        getPosition: function () {
            var b = this.boxy[0];
            return [b.offsetLeft, b.offsetTop];
        },

        // Returns the center point of this dialog as [x,y]
        getCenter: function () {
            var p = this.getPosition();
            var s = this.getSize();
            return [Math.floor(p[0] + s[0] / 2), Math.floor(p[1] + s[1] / 2)];
        },

        getInner: function () {
            return $('.boxy-inner', this.boxy);
        },
        getContent: function () {
            return $('.boxy-content', this.boxy);
        },
        setContent: function (newContent) {
            newContent = $(newContent).addClass('boxy-content');
            if (this.options.clone) newContent = newContent.clone(true);
            this.getContent().remove();
            this.getInner().append(newContent);
            this._setupDefaultBehaviours(newContent);
            this.options.behaviours.call(this, newContent);
            return this;
        },
        moveTo: function (x, y) {
            this.moveToX(x).moveToY(y);
            return this;
        },
        moveToX: function (x) {
            if (typeof x == 'number') this.boxy.css({left: x});
            else this.centerX();
            return this;
        },
        moveToY: function (y) {
            if (typeof y == 'number') this.boxy.css({top: y});
            else this.centerY();
            return this;
        },
        centerAt: function (x, y) {
            var s = this[this.visible ? 'getSize' : 'estimateSize']();
            if (typeof x == 'number') this.moveToX(x - s[0] / 2);
            if (typeof y == 'number') this.moveToY(y - s[1] / 2);
            return this;
        },
        centerAtX: function (x) {
            return this.centerAt(x, null);
        },
        centerAtY: function (y) {
            return this.centerAt(null, y);
        },
        center: function (axis) {
            var v = Boxy._viewport();
            var o = this.options.fixed ? [0, 0] : [v.left, v.top];
            if (!axis || axis == 'x') this.centerAt(o[0] + v.width / 2, null);
            if (!axis || axis == 'y') this.centerAt(null, o[1] + v.height / 2);
            return this;
        },
        centerX: function () {
            return this.center('x');
        },
        centerY: function () {
            return this.center('y');
        },
        resize: function (width, height, after) {
            if (!this.visible) return;
            var bounds = this._getBoundsForResize(width, height);
            this.boxy.css({left: bounds[0], top: bounds[1]});
            this.getContent().css({width: bounds[2], height: bounds[3]});
            if (after) after(this);
            return this;
        },
        tween: function (width, height, after) {
            if (!this.visible) return;
            var bounds = this._getBoundsForResize(width, height);
            var self = this;
            this.boxy.stop().animate({left: bounds[0], top: bounds[1]});
            this.getContent().stop().animate({width: bounds[2], height: bounds[3]}, function () {
                if (after) after(self);
            });
            return this;
        },
        isVisible: function () {
            return this.visible;
        },
        show: function () {
            var topWin = Base.getTopWindow();
            if (this.visible) return;
            if (this.options.modal) {
                var self = this;
                if (!Boxy.resizeConfigured) {
                    Boxy.resizeConfigured = true;
                    $(window).resize(function () {
                        Boxy._handleResize();
                    });
                }
                this.modalBlackout = $('<div class="boxy-modal-blackout"></div>')
                    .css({zIndex: Boxy._nextZ(),
                        opacity: 0.4,
                        width: $(topWin.document).width(),
                        height: $(topWin.document).height()})
                    .appendTo(topWin.document.body);
                this.toTop();
                if (this.options.closeable) {
                    $(topWin.document.body).bind('keypress.boxy', function (evt) {
                        var key = evt.which || evt.keyCode;
                        if (key == 27) {
                            self.hide();
                            $(topWin.document.body).unbind('keypress.boxy');
                        }
                    });
                }
            }
            var that = this;

            var centerTop = this.boxy.css("top");
            //显示位置
            var location = that.options.location;
            if (location == "top") {
                centerTop = 0;
            }
            this.boxy.stop().css({top: -this.boxy.width()}).show().animate({top: centerTop}, function () {
                that.visible = true;
                if ($.isFunction(that.options.afterShow)) {
                    that.options.afterShow(that);
                }
            });
            return this;
        },
        hide: function (after) {
            var topWin = Base.getTopWindow();
            if (!this.visible) return;
            var self = this;
            if (this.options.modal) {
                $(topWin.document.body).unbind('keypress.boxy');
                this.modalBlackout.animate({opacity: 0}, function () {
                    $(this).remove();
                });
            }
            this.boxy.stop().animate({opacity: 0}, 300, function () {
                self.boxy.css({display: 'none'});
                self.visible = false;
                self._fire('afterHide');
                if (after) after(self);
                if (self.options.unloadOnHide) self.unload();
            });
            return this;
        },
        toggle: function () {
            this[this.visible ? 'hide' : 'show']();
            return this;
        },
        hideAndUnload: function (after) {
            this.options.unloadOnHide = true;
            this.hide(after);
            return this;
        },
        unload: function () {
            this._fire('beforeUnload');
            this.boxy.remove();
            if (this.options.actuator) {
                $.data(this.options.actuator, 'active.boxy', false);
            }
        },
        toTop: function () {
            this.boxy.css({zIndex: Boxy._nextZ()});
            return this;
        },
        getTitle: function () {
            return $('> .title-bar h2', this.getInner()).html();
        },
        setTitle: function (t) {
            $('> .title-bar h2', this.getInner()).html(t);
            return this;
        },
        _getBoundsForResize: function (width, height) {
            var csize = this.getContentSize();
            var delta = [width - csize[0], height - csize[1]];
            var p = this.getPosition();
            return [Math.max(p[0] - delta[0] / 2, 0),
                Math.max(p[1] - delta[1] / 2, 0), width, height];
        },
        _setupTitleBar: function () {
            if (this.options.title) {
                var self = this;
                var tb = $("<div class='title-bar'></div>").html("<h2>" + this.options.title + "</h2>");
                if (this.options.closeable) {
                    tb.append($("<a href='javascript:void(0)' title='关闭' class='close'></a>").html(this.options.closeText));
                }
                if (this.options.draggable) {
                    tb[0].onselectstart = function () {
                        return false;
                    }
                    tb[0].unselectable = 'on';
                    tb[0].style.MozUserSelect = 'none';
                    if (!Boxy.dragConfigured) {
                        $(document).mousemove(Boxy._handleDrag);
                        Boxy.dragConfigured = true;
                    }
                    tb.mousedown(function (evt) {
                        self.toTop();
                        Boxy.dragging = [self, evt.pageX - self.boxy[0].offsetLeft, evt.pageY - self.boxy[0].offsetTop];
                        $(this).addClass('dragging');
                    }).mouseup(function () {
                        $(this).removeClass('dragging');
                        Boxy.dragging = null;
                        self._fire('afterDrop');
                    });
                }
                this.getInner().prepend(tb);
                this._setupDefaultBehaviours(tb);
            }
        },
        _setupDefaultBehaviours: function (root) {
            var self = this;
            if (this.options.clickToFront) {
                root.click(function () {
                    self.toTop();
                });
            }
            $('.close', root).click(function () {
                self.hide();
                return false;
            }).mousedown(function (evt) {
                evt.stopPropagation();
            });
        },
        _fire: function (event) {
            this.options[event].call(this);
        }
    };
    /*=================================Boxy弹窗组件 end=========================*/

    window.KT = Base;

})(window);