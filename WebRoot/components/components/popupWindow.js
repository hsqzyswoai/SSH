 /**����ѡ�ؼ�
  $("#XX").popupWindow({
		onClick:function, //���"..."������ť�¼�, �˺���Ҫ�󷴻�ֵΪ:{id:"",text:""}
		onClean:function, //���"X"��հ�ť�¼�(�Ǳ���)
	});
  **/
(function($) { 

	$.fn.popupWindow= function(method, options) {
		if(typeof(method)=='object'){
			create(method, this); //{onClick:function, onClean:function}
		}else if(method=='options'){
			return $(this).data();
		}else if(method=='getValue'){
			return getValue(this); //���ؽ����{id:"",text:""} 
		}else if(method=='setValue'){
			setValue(this, options);//options��ʽ�� {id:"",text:""}
		}
	};	
	
	/**����* */
	function create(opts, obj){
		 var inp = $(obj);
		 var id = inp.attr("id");
	     var divId = 'popup_'+id;
	     var newId = id+'_text';
	     if(inp.parent().attr("id")==divId){return;} //˵���Ѿ���������,�����ٹ���
	     opts.newId = newId;
	     inp.data(opts);//���¶��������
	     
	     inp.hide(); //���ؾɵ�
	     var html = [];
	     
	     if(inp.next().attr('id')==newId){inp.next().remove();}
	     else if(inp.prev().attr('id')==newId){inp.prev().remove();}
	     
	     if(inp.next().hasClass("specie")){//�����ظ�����
	    	 inp.next().remove();
	     }
	     
	     html.push('<div class="specie" id="'+divId+'">');
	     html.push('<input readonly class="deInput" style="width:100%" type="text" id="'+newId+'" name="'+newId+'"/>');
	     //html.push(inp.prop("outerHTML").replace("<input", "<input readonly "));
		 html.push('<div class="specieSelect"></div><div class="inputClear" style="display:none;"></div></div>');
		 inp.after(html.join(''));  //�����µ�	  
		 
		 var div = $("#"+divId);
		 div.find(".specieSelect").click(function(){ //����¼�
		 		if(inp.attr("disabled") || $("#"+newId).attr("disabled")){return false;}
		        var rs = getValue(inp);
		 		rs = opts.onClick.call(this, rs);
		 		
		 		setValue(inp, rs);
		 });   
		 
		 div.hover(
				 function(){if(inp.val() && !(inp.attr("disabled") || $("#"+newId).attr("disabled") )){div.find(".inputClear").show();}}, 
				 function(){div.find(".inputClear").hide();}
				 ); 
		 div.find(".inputClear").click(function(){ //����¼�
		 		//if(inp.attr("disabled") || $("#"+newId).attr("disabled")){return false;}
		 		var rs = getValue(inp);
		 		
		 		setValue(inp, {id:"",text:""});
		 		if(opts.onClean && rs.id){opts.onClean.call(this,rs);}
		 }); 
	}
	
	/**ȡֵ*/
	function getValue(obj){
		var inp = $(obj);
		var newId = inp.attr("id")+"_text";
		return {
				id:inp.val(),
				text:$("#"+newId).val()
		};
	}
	
	/**��ֵ*/
	function setValue(obj, data){
		if(data){
			var inp = $(obj);
			var newId = inp.attr("id")+"_text";
			
			inp.val(data.id);
			$("#"+newId).val(data.text);
		}
	}
	
})(jQuery);

