 /**��Ϣ��div����*/
(function($) { 

	//��Ϣ��ʾ��ȷ����ʾ��
	$.messager={};
	$.messager.defaults={};
	$.messager.confirm= function(title, msg, fun, opts) {
		KT.confirm(msg, function(){fun(true);}, function(){fun(false);}); 
	};	
	$.messager.alert=function(title, msg, icon, fn, opts){
		KT.alert(msg,fn);
	};
    
    //div����
	$.fn.window= function(method, options) {
		if(typeof(method)=='object'){
			create(this, method);
		}else if(method=='close'){
			var data = $(this).data();
			layer.close(data.index); 
		}
	};	
	
	function create(obj, opts){
		var content = (opts.url) ? null : $(obj).prop("outerHTML");
		var id= $(obj).attr("id");
		if(content){ $(obj).remove(); }
		
		var options = { 
					  closeButtonEnable: false,
		              confirmButtonEnable: false,	
				      title: opts.title, //���� 
				      width: opts.width,   //��� 
				      height: opts.height,   //�߶� 
				      content: content, //'���ݣ�����֧��html��',   //���url����ֵû������������ 
				      url : opts.url 
				   }; 
		
		var index = KT.dialog(options); 
		$("#"+id).data({index:index});
	}
})(jQuery);

