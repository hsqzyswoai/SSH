/**�½�����ѡ��ؼ�
 * 1.��ʼ����
	 * 	a):��ѡ��ť
		   $("#XX").radio("loadData",{   //loadData �ɲ���
				type : 1 // 1:ƽ�̵�ѡ��̬��2��ƽ�̶�ѡ��̬��3:���أ�������̬ʱ��Ҫ�����ѡ������datas�ĳ���ֻ��Ϊ2
				datas:[{id:"",text:"",color:""}], //ѡ������,color��ʾ������ɫ��Ĭ��blue��������̬ʱ�Ż�
				id:datas��������ʽֵ�ֶ���, Ĭ��ȡ"id"�ֶ� ������datas����һ��
				text:datas��������ʾ�ı��ֶ���,Ĭ��ȡ"text"�ֶ� ������datas����һ��
				onChange:function(obj){}, //��ѡֵ�����仯�¼�,����{id:"",text:""}
				addDefault: true; �Ƿ����Ĭ��ѡ��defaultItem
				defaultItem: //�Զ���Ĭ��ѡ�Ĭ�ϡ�ȫ�����ֶ���������datas����һ��
				width:200, //div�Ŀ�ȣ�������̬���200px��Ĭ��δ���ÿ�ȡ�
				height:40, //div�ĸ߶ȣ�Ĭ��Ϊ24��   
				fontSize��24  //�����С Ĭ��24
				defaultSelect:index, //��ʼ��ʱѡ�еڼ���ѡ�� ��Ĭ��0,
				minItemWidth:80,  //ÿ��ѡ�����С��ȣ�Ĭ��50��ƽ�̣�
				maxItemWidth : 140, ÿ��ѡ�������ȣ�Ĭ��150 ��ƽ�̣�
				itemMargin:5  //ѡ���ļ�࣬Ĭ��4 ��ƽ�̣�
		  });
 * 2.�������ã�
 *   	$("#XX").radio("setValue", {id:"1"}); ��{index : 2}  //����ѡ���� 
   		var v = $("#XX").radio("getValue"); //��ȡֵ  Ϊ��ѡ��ʱ���������飬��ѡ�Ϳ���ʱ����json
   		var opts = $("#XX").radio("options"); //��ȡ���Զ���
   		$("#XX").radio("setItems",{id:1,text:"A"}); //����ֵ 
 */

(function($){
	$.fn.radio = function(opt, options){
		if(typeof opt != "object"){
			if(opt == "loadData"){
				var opts = $(this).data();
				opts.data = options.datas; //�õ����������data
				loadData(opts, this);
			}else if(opt == "setValue"){
				setValue(this, options); //����ѡ����
			}else if(opt == "getValue"){
				return getValue(this);   //�õ�ѡ��ֵ
			}else if(opt == "options"){
				return this.data();			//�õ����ʱ��options
			}else if(opt == "setItems"){ //����ѡ��
				var opts = $(this).data();
				opts.datas = options;  //�õ����������data
				setItems(this, opts);
			}
		}else{
			//��ʼ��
			loadData(opt,this);
		}
	};
	
	/**��ʼ������*/
	function loadData(opts, obj){
		var inp = $(obj);
		var id = inp.attr("id");
		inp.next().remove();
		//inpΪ������ʱ
		if(inp.is("select")){ 
			inp.after('<input type="hidden" id="'+id+'" value="" />'); 
			inp.remove();
			inp = $("#" + id);
		}
		//ԭʼ������Ĭ����������
		opts = $.extend({},$.fn.radio.defaults,opts);
		
		//���Ĭ��ѡ��
		addDefaultItem(inp,opts);
		inp.data(opts);
		var type = opts.type;
		if(type == "3" && opts.datas.length == 2){  //������ʽ
			setSwitch(inp,opts);
		}else {                      //ƽ�� ��ʽ
			var html = [];
			html.push("<div class='selectOrder'></div>");
			inp.hide();
			inp.after(html.join(''));
			setPItems(inp, opts);
		}
		//�󶨵���¼�
		if(type == "2"){
			multiClickEvent(inp);
		}else{
			radioClickEvent(inp);
		}
		//Ĭ��ѡ��ѡ��
		var index = opts.defaultSelect+"";
		setValue(inp, {"index" : index});
		//����div�߿�
		setHeiWid(inp);
		//����ѡ��ĳ��ȼ�����
		setItemWidMargin(inp);
	}
	
	/**���Ĭ��ѡ��*/
	function addDefaultItem(inp,opts){
		if(opts.addDefault && opts.defaultItem && opts.type != '3'){  //�û��Զ���
			opts.datas.unshift(opts.defaultItem); 
		}else if(opts.addDefault && opts.type != '3'){ //Ĭ��ѡ��
			var defaultItem = {};
			var id = opts.id;
			var text = opts.text; 
			defaultItem[id] = "";    
			defaultItem[text] = "ȫ��";
			opts.datas.unshift(defaultItem);
		}
	}
	
	/**���õ�ѡѡ��*/
	function setPItems(inp,opts){
		var id = opts.id;
		var text = opts.text;
		var div = inp.next();
		var type = opts.type;
		var datas = opts.datas;
		var html = [];
		for(var i = 0; i<datas.length; i++){
			html.push("<p style='text-align:left;overflow:hidden;text-overflow:ellipsis'  title='"+datas[i][text]+"'>");
			if(type == "1"){  //ƽ�̵�ѡ
				html.push("<span class='jqTransformRadioWrapper'>");
				html.push("<a href='javascript:void(0)' class='notSwitch jqTransformRadio' index='"+i+"'></a>");
				html.push("<input type='radio' value='"+datas[i][id]+"' checked=false class='jqTransformHidden'/>");
			}else{  //ƽ�̶�ѡ
				html.push("<span class='jqTransformCheckboxWrapper' style='display:block;float:left;margin:0px 4px;margin-top:5px;'>");
				html.push("<a href='javascript:void(0)' class='notSwitch jqTransformCheckbox' index='"+i+"'></a>");
				html.push("<input type='checkbox' name='chbox' value='"+datas[i][id]+"' checked=false class='jqTransformHidden'/>");
			}
			html.push("</span>");
			html.push(datas[i][text]);
			html.push("</p>");
		}
		div.html(html.join(''));
		//div.find(":radio").jqTransRadio(); //���ص�ѡ����ʽ
	}
	
	/**�󶨵���¼�*/
	function radioClickEvent(inp){
		var liEle= getLiObj(inp);
		var pEle = getPObj(inp);
		var element = pEle.length > 0 ? pEle : liEle; //���ֿ�����̬
		element.unbind().bind("click", function(){
			var childEle = pEle.length > 0 ? $(this).find("a") : $(this);
			if(childEle.hasClass("jqTransformChecked") || childEle.hasClass("selected")) return;
			var id = pEle.length>0 ? childEle.next().val() : childEle.val();
			setValue(inp, {"id" : id});
			//�ص�����onChange
			if(inp.data().onChange){
				inp.data().onChange.call(childEle, getValue(inp));
			}
		});
	}
	
	/**��ѡ��󶨵���¼�**/
	function multiClickEvent(inp){
		var jElement = getPObj(inp);
		jElement.unbind().bind("click",function(){
			var jaEle = $(this).find("a");
			var i = jaEle.attr("index");
			if(inp.data().addDefault && i==0){
				multiSelectAll(inp);
				return;
			}else{
				if(jaEle.hasClass("jqTransformChecked")){
					jaEle.removeClass("jqTransformChecked");
					jaEle.attr("checked",false);
					jElement.eq(0).find("a").removeClass("jqTransformChecked");
					jElement.eq(0).find("a").attr("checked", false);
				}else{
					jaEle.addClass("jqTransformChecked");
					jaEle.attr("checked", true);
					isSelectAll(inp, inp.data());
					var id = jaEle.next().val();
					var text = $(this).text();
					if(inp.data().onChange){
						inp.data().onChange.call(jaEle,{"id" : id ,"text" : text});
					}
				}
			}
			var idArr = [];
			inp.next().find(".jqTransformChecked").each(function(i){
				var v = $(this).next().val();
				if(v){
					idArr.push(v);
				}
			});
			inp.val(idArr.join(","));
		});
	}
	
	/**��ѡ��ȫѡ�¼�**/
	function multiSelectAll(inp){
		var aEle = getPObj(inp).find("a");
		if(aEle.eq(0).hasClass("jqTransformChecked")){
			aEle.removeClass("jqTransformChecked");
			aEle.attr("checked", false);
		}else{
			aEle.addClass("jqTransformChecked");
			aEle.attr("checked", true);
		}
		inp.val(' ');
	}
	
	/**�ж϶�ѡ���Ƿ�Ҫ��ѡȫѡ**/
	function isSelectAll(inp,opts){
		if(!opts.addDefault) return;
		if(inp.next().find(".jqTransformChecked").length == opts.datas.length-1){
			var aEle = getPObj(inp).find("a");
			aEle.eq(0).addClass("jqTransformChecked");
			aEle.eq(0).attr("checked",true);
		}
	}
	
	/**������̬*/
	function setSwitch(target,opts){
		target.next().remove();
		var idAttr = target.attr("id");
		var id = target.data().id;
		var text = target.data().text;
		var html = [];
		html.push('<ul class="yesNo" id="'+idAttr+'_on_off" >');
		var color1 = opts.datas[0].color || "#45b6d7";
		html.push('<li class="selected" value="'+opts.datas[0][id]+'"style="background:'+color1+';color:#fff">'+opts.datas[0][text]+'</li>');
		html.push('<li value="'+opts.datas[1][id]+'" class="">'+opts.datas[1][text]+'</li>');
		html.push('</ul>');
		target.after(html.join(""));
		target.hide();
	}
	
	/**����ѡ����*/
	function setValue(inp, options){
		if(inp.data().type == "2"){  //��ѡ��ʱ
			setMultiVal(inp, options);
			return;
		}
		var aElement = getPObj(inp).find("a");
		var liElement = getLiObj(inp);
		var i = options.index;  //�±�
		var id = options.id;  //idֵ
		if(i != null && aElement.length>0){  //ѡ���±�
			setRadioClass(inp,i);
		}else if(i != null && liElement.length > 0){  //�����±�
			setLiStyle(inp,i);
		}else if(id != null && aElement.length>0){  //ѡ��id
			aElement.each(function(i){
				if($(this).next().val() == id){
					setRadioClass(inp,i);
				} 
			});
		}else if(id != null && liElement.length>0){ //����id
			liElement.each(function(i){
				if($(this).val() == id){
					setLiStyle(inp,i);
				} 
			});
		}
		//��������inp��value��ֵ
		var $next = inp.next();
		var value = aElement.length>0 ? $next.find(".jqTransformChecked").next().val() : $next.find(".selected").val();
		inp.val(value);
	}
	
	/**��ѡ������valueֵ**/
	function setMultiVal(inp, options){
		var obj = getPObj(inp).find("a");
		obj.removeClass("jqTransformChecked");
		obj.next().attr("checked",false);
		var ids = options.id;
		var indexs = options.index;
		if(ids != null){
			ids += "";  //idΪ����ʱת���ַ�������
			var idArr = ids.split(",");
			for(var i=0; i<idArr.length; i++){
				inp.next().find(".jqTransformCheckbox").each(function(j){
					if(idArr[i] == $(this).next().val()){
						$(this).addClass("jqTransformChecked");
						$(this).attr("checked", true);
					}
				});
			}
			inp.val(ids);
		}else if(indexs != null){
			indexs += ""; //indexsΪ����ʱת���ַ�������
			var indArr = indexs.split(",");
			var v = [];
			for(var i=0;i<indArr.length;i++){
				inp.next().find(".jqTransformCheckbox").each(function(j){
					if(indArr[i] == $(this).next().val()){
						obj.eq(j).addClass("jqTransformChecked");
						obj.eq(j).next().attr("checked","checked");
						v.push($(this).next().val());
					}
				});
			}
			inp.val(v.join(","));
		}else{
			return;
		}
	}
	
	/**���õ�ѡ��class��attr**/
	function setRadioClass(inp,index){
		var aElement = getPObj(inp).find("a");
		aElement.removeClass("jqTransformChecked");
		aElement.next().attr("checked", false);
		aElement.eq(index).addClass("jqTransformChecked");
		aElement.eq(index).next().attr("checked","checked");
	}
	
	/**li��ʽ�仯*/
	function setLiStyle(inp,index){
		var liElement = getLiObj(inp);
		liElement.removeClass("selected").css("background", "none").css("color","#b4b4b4");
		var color = inp.data().datas[index].color || "#45b6d7";
		liElement.eq(index).addClass("selected").css("background", color ).css("color","#fff");
	}
	
	/**�õ�ѡ��ֵ**/
	function getValue(inp){
		var v = null;
		var aEle = inp.next().find(".jqTransformChecked"); 
		if(inp.data().type == "2"){
			var valueArr = [];
			aEle.each(function(){
				valueArr.push({
					"id" : $(this).next().val(),
					"text" : $(this).parents("p").text()
				});
			});
			return valueArr;
		}else{
			var ulEle = inp.next().find(".selected");
			var json = {};
			var text = aEle.length > 0 ? aEle.parents("p").text() : ulEle.text();
			var id = aEle.length > 0 ? aEle.next().val() : ulEle.val();
			json = {id: id, text : text};
			return json;
		}
	}
	
	/***����ѡ��**/
	function setItems(inp, opts){
		var aEle = getPObj(inp).find("a");
		var liEle = getLiObj(inp);
		addDefaultItem(inp, inp.data()); //���Ĭ��ѡ��
		var datas = opts.datas;
		if(liEle.length>0){
			setSwitch(inp, opts);
		}else if(aEle.length>0){
			setPItems(inp, opts);
		}
		var index = inp.data().defaultSelect;
		index = index >datas.length ? 0 : index;
		if(inp.data().type == "2"){
			multiClickEvent(inp);
			setMultiVal(inp,{"index" : index});
		}else{
			radioClickEvent(inp);
			setValue(inp,{"index" : index});  
		}
		//����div�߿�
		setHeiWid(inp);
	}
	
	/**����div�߿������С*/
	function setHeiWid(inp){
		var hei = inp.data().height;
		if(hei){
			inp.next().height(hei);
			inp.next().find("li").css("line-height", hei+"px");
		}
		var wid = inp.data().width;
		if(wid){
			inp.next().width(wid);
		}
		var fontSize = inp.data().fontSize + "px";
		if(fontSize){
			inp.next().css("font-size",fontSize );
		}
	}
	
	/**����ѡ��Ŀ�ȣ����**/
	function setItemWidMargin(inp){
		var jp = inp.next().find("p");
		var minItemWidth = inp.data().minItemWidth;
		if(minItemWidth){
			jp.css("min-width" , minItemWidth);
		}
		if(inp.data().width!='auto'){
			var maxItemWidth = inp.data().maxItemWidth;
			if(maxItemWidth){
				jp.css("max-width" , maxItemWidth);
			}
		}
		var itemMargin = inp.data().itemMargin;
		if(itemMargin){
			jp.css("margin-right", itemMargin+"px");
		}
	}
	
	/**��ȡ��\��ѡ�����ĸ�Ԫ��p**/
	function getPObj(inp){
		return inp.next().find("p");
	}	
	
	/**��ȡli����*/
	function getLiObj(inp){
		return inp.next().find("li");
	}
	
	/***Ĭ������**/
	$.fn.radio.defaults = {
		type:"1",
		datas : [],
		id : "id",
		text:"text",
		defaultSelect : 0,
		itemMargin : 3,
		minItemWidth:50,
		maxItemWidth : 160,
		onChange:function(json){}
	};
})(jQuery);