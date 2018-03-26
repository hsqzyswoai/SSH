/*
var items = [
			{type:"button",text:"�б�ȫ���ֶ�",bodyStyle:"chargeback",useable:"T",
				handler:function(){Catt_Export_Direct(option);}
			}, 
			{type:"button",text:"����ɸѡ�ֶ�",bodyStyle:"gongdang",useable:"T",
				handler:function(){Catt_Export_FilterColums(option);}
			},
            {type:"button",text:"���������ڵ���",bodyStyle:"chargeback",useable:"T",
				handler:function(){Catt_Export_InOut_Colums(option);}
			}
		];
		
for(var i=0;i<items.length;i++){
	var tempMenu=document.createElement("div");
	$(tempMenu).text(items[i].text);//tempMenu.innerText=items[i].text;
	tempMenu.iconCls=items[i].bodyStyle;
	$(tempMenu).bind("click",items[i].handler);
	div.appendChild(tempMenu);
}
document.body.appendChild(div);

var ev = option.ev;
if(ev==null){ 
   try{ev = event;}catch(e){}
}
var point = getMousePoint(ev);
//�����˵���λ����
$("#optMenu_"+option.formId).menu({});
$("#optMenu_"+option.formId).menu("show", { left:point.x,  top:point.y  });
*/


/**�����˵�*/
(function($) {
		$.fn.menu = function(opt,options){
			if(typeof opt != 'object'){
				if(opt == 'loadData'){
				
				}else if(opt=='show'){
					var div = $(this);
					var point = whenOutScrmee({x:options.left,y:options.top},div);
					div.css(point);
					div.slideDown();
				}
			}else{
				loadData(this, opt);
			}
		};
		
		//����
		function loadData(obj, opt){
			var div = $(obj);
			div.addClass("piXiala piXiala1")
			div.mouseleave(function(){
				div.slideUp();
			})
		}
		
})(jQuery);

//��ȡ��������
function getMousePoint(ev,obj) {
	// ����������Ӵ��е�λ��
	var point = { x:0, y:0 };
       if(ev!=null){
           // ��������֧�� pageYOffset, ͨ�� pageXOffset �� pageYOffset ��ȡҳ����Ӵ�֮��ľ���
           if(typeof window.pageYOffset != 'undefined') {
               point.x = window.pageXOffset;
               point.y = window.pageYOffset;
           }
           // ��������֧�� compatMode, ����ָ���� DOCTYPE, ͨ�� documentElement ��ȡ����������Ϊҳ����Ӵ���ľ���
           // IE ��, ��ҳ��ָ�� DOCTYPE, compatMode ��ֵ�� CSS1Compat, ���� compatMode ��ֵ�� BackCompat
           else if(typeof document.compatMode != 'undefined' && document.compatMode != 'BackCompat') {
               point.x = document.documentElement.scrollLeft;
               point.y = document.documentElement.scrollTop;
           }
           // ��������֧�� document.body, ����ͨ�� document.body ����ȡ�����߶�
           else if(typeof document.body != 'undefined') {
               point.x = document.body.scrollLeft;
               point.y = document.body.scrollTop;
           }
           // ����������Ӵ��е�λ��
           point.x += ev.clientX;
           point.y += ev.clientY;
       }
	// ����������Ӵ��е�λ��
	return point;
}

/**������Ļʱ�Ĵ���*/
function whenOutScrmee(point,obj){
	  if(obj){
    	   var w = $(obj).width();
    	   var h = $(obj).children().length*40;
    	   var w1 = $(window).width();
    	   var h1 = $(window).height();
    	   
    	   if(point.x+w>w1){
    		   point.x = point.x - ((point.x+w)-w1); 
    		   }
    	   if(point.y+h>h1){
    		   point.y = point.y - ((point.y+h)-h1); 
    	   }
       }
	  return  {left:point.x,top:point.y};
}

/**
 * ��ʼ��������ť
 * pId  ���������б�Ķ�������ID
 * listContainerId ��ť�б���������������ID
 * btnList ��ť�б� [{text:'��ť1'}]
 * fn �ص����� function fn(btnText){}
 */
function initDropdownList(pId, listContainerId, btnList, width, fn){
	var mtimeout = null;
	
	var btnListId = pId+'_ddl';
	
	//��Ӱ�ťdom
	var html = '<div class="piXiala" id="'+btnListId+'" style="width:'+width+'px;">';
	html += '<div class="piArrow"></div><dl>';
	var len = btnList.length; 
	for(var i = 0; i < len; i++){
		var obj = btnList[i];
		html += '<dt style="border-bottom:none;"><h3>'+obj.text+'</h3></dt>';
	}
	html += '</dl></div>';
	$("#"+listContainerId).append(html);
	
	$("#"+pId).off('hover').hover(function(){
		try{clearTimeout(mtimeout);}catch(e){}
		var offset = $("#"+pId).offset();
		var h = $("#"+pId).outerHeight();
		$('#'+btnListId).css({left:offset.left, top:offset.top + h}).slideDown();
	});
	
	$("#"+pId).off('mouseleave').mouseleave(function(){
		try{clearTimeout(mtimeout);}catch(e){}
		mtimeout = setTimeout(function(){
			$('#'+btnListId).slideUp();
		}, 100);
	});
	
	$('#'+btnListId).hover(function(){
		try{clearTimeout(mtimeout);}catch(e){}
	});
	
	$('#'+btnListId).mouseleave(function(){
		//$("#"+btnListId).slideUp();
		try{clearTimeout(mtimeout);}catch(e){}
		mtimeout = setTimeout(function(){
			$('#'+btnListId).slideUp();
		}, 100);
	});
	
	//ע�ᰴť����¼�
	$('#'+btnListId+" dt").click(function(){
		var text = $(this).text();
		fn.call(this, text);
	});
	
}
