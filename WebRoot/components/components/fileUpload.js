 /**����ѡ�ؼ�*/
(function($) { 

	$.fn.fileUpload= function(method, options) {
		if(typeof(method)=='object'){
			create(method, this); //{onClick:function, onClean:function}
		}else if(method=='options'){
			return $(this).data();
		}else if(method=='getValue'){
			return getValue(this); //{id:"",text:""} 
		}else if(method=='setValue'){
			setValue(this, options);//{id:"",text:""}
		}
	};	
	
	/**����*/
	function create(opts, obj){
		var inp = $(obj);
		if(inp.parent().hasClass("specie")){return;}
		
		initAttr(inp, opts);
		var inpHtml = inp.prop("outerHTML").replace(/<input/i, '<input class="deInput" readonly style="width:100%;" ');
		var id=inp.attr('id');
	    var divId = 'fileUpload_'+id;
        
	    var html = [];
	    html.push('<div class="specie" id="'+divId+'">');
	    html.push(inpHtml);
		html.push('<div class="specieFileUpload"></div><div class="inputClear" style="right:24px;display:none;"></div></div>');
		
		inp.after(html.join(''));
		inp.remove();  
		
		$("#"+id).hover(
				function(){ if( $("#"+id).val() ){$(".specieFileUpload").next().show(1);}}, 
				function(){ if( !$("#"+id).val() ){$(".specieFileUpload").next().hide();}}
			);
		
		var fastDFS_path = getFullPath();
		var iTableId = IsEmpty(opts.iTableId)?"":opts.iTableId;
		var sTableName = IsEmpty(opts.sTableName)?"":opts.sTableName;
		var isToLocal = IsEmpty(opts.isToLocal)?"":opts.isToLocal;
		var isSaveToDB = IsEmpty(opts.isSaveToDB)?"1":opts.isSaveToDB;
		var directory = IsEmpty(opts.directory)?"":opts.directory;
		directory = encodeURIComponent(directory); //���룬\Ϊת���
		var limitReg = IsEmpty(opts.limitReg)?"":opts.limitReg;
		var maxUpSize = IsEmpty(opts.maxUpSize)?"":opts.maxUpSize;
		var ifm = document.createElement("iframe");
		$(ifm).attr({
		   width:26,height:26,frameborder:0,title:'�ϴ��ļ�',scrolling:"no",
		   src:fastDFS_path+'/admin/commonModule/fastdfs/singleUpload.jsp?cssFlag=1&eId='
		   	+opts.eId+"&sTableName="+sTableName+"&fileSize="+maxUpSize+"&extension="
		   	+limitReg+"&isToLocal="+isToLocal+"&directory="+directory
		 });
		$(".specieFileUpload").append(ifm);
		
		inp = $("#"+id);
		$(inp).unbind("click");
		inp.data(opts);
		 
		if(!IsEmpty(opts.iTableId)){
			$(window).data("fileUploadTableId_"+opts.eId, opts.iTableId);//��ģ��������������
		}
		if (!IsEmpty(opts.afterUpload)) {
			$(window).data("afterUpload_"+opts.eId,opts.afterUpload);//���ϴ��ص�������������
		}
		if (!IsEmpty(opts.afterClean)) {
			$(window).data("afterClean_"+opts.eId,opts.afterClean);//����ջص�������������
		}
		 
		var div = $("#"+divId);
	    div.find(".inputClear").click(function(){ //����¼�
		 		commonUtil.jqFileUpload_cleanFile(opts.eId); 
		}); 
		
	}
	
	
	//�����ػ��ļ��ϴ��ؼ�
 	//��json����ֵ������input��������
	function initAttr(obj,options){
		if(obj){
	       $(obj).attr({
	       	    iTableId :IsEmpty(options.iTableId1)?"":options.iTableId1,
				sTableName:IsEmpty(options.sTableName)?"":options.sTableName,
				isToLocal: IsEmpty(options.isToLocal)?"":options.isToLocal,
				isSaveToDB: IsEmpty(options.isSaveToDB)?"1":options.isSaveToDB,
				directory :encodeURIComponent(IsEmpty(options.directory)?"":options.directory),  //���룬\Ϊת���
				limitReg : IsEmpty(options.limitReg)?"":options.limitReg,
				displayName: IsEmpty(options.displayName)?"1":options.displayName,
				maxUpSize:IsEmpty(options.maxUpSize)?"":options.maxUpSize
	       });
		}
	}
	
	/**ȡֵ*/
	function getValue(obj){
		
	}
	
	/**��ֵ*/
	function setValue(obj, data){
		
	}
	
})(jQuery);

