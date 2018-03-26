 /**��ֵ��ؼ�*/
(function($) { 
    /**
      ������ֻ��������
      ����ʾ���ֵ����Сֵ������������
       $("#XX").number({
	      max:���ֵ
	      min:��Сֵ
	      dataType: "digit"������������������
	      decimals: С��λ ��:2
       });
    */
	$.fn.number= function(method, options) {
		if(typeof(method)=='object'){
			create(method, this); //{onClick:function, onClean:function}
		}else if(method=='options'){
			return $(this).data();
		}
	};	
	
	/**����*/
	function create(opts, obj){
		 var inp = $(obj);
		 inp.attr(opts); //���µ�����ֵΪ׼
		 check(inp.get(0));
	     
	     inp.unbind("keypress").bind("keypress",function(){
	     	check(this);
	     });
	     inp.unbind("keyup").bind("keyup",function(){
	     	check(this);
	     });
	     inp.unbind("blur").bind("blur",function(){
	     	check(this);
	     });
	}
	
	function check(obj){
			var attrs = getAttrs(obj);
			var reg;
			var reg2;
			if(attrs.dataType=="digit"){
				reg = "/^[\\+\\-]?\\d*?$/";
				reg2 = "/^(?:[\\+\\-]?\\d+)?$/";
			}else{
			    if(attrs.decimals){
			    	reg = "/^[\\+\\-]?\\d*?\\.?\\d{0,"+attrs.decimals+"}?$/";
			    	reg2 = "/^(?:[\\+\\-]?\\d+(?:\\.\\d{0,"+attrs.decimals+"})?)?$/";
			    }else{
			    	reg = "/^[\\+\\-]?\\d*?\\.?\\d{0,8}?$/";
			    	reg2 = "/^(?:[\\+\\-]?\\d+(?:\\.\\d{0,8})?)?$/";
			    }
			}
			
			var val = obj.value;

			if(!eval(reg).test(val) ){
				obj.value=obj.t_value&&eval(reg).test(obj.t_value) ?obj.t_value:"";
			}if((attrs.max && val && attrs.max*1 < val*1 )){ //������//�������ֵ
				//obj.value=obj.t_value?obj.t_value:"";
				obj.style.color="red"; obj.title="���𳬹����ֵ"+attrs.max; $(obj).mouseover();
			}else if((attrs.min && val && attrs.min*1 > val*1 )){ //������ �� ������Сֵ
	     		//obj.value=obj.t_value?obj.t_value:attrs.min;
				obj.style.color="red"; obj.title="���������Сֵ"+attrs.min; $(obj).mouseover();
	     	}else{
	     		obj.t_value=val;
	     		obj.style.color="black";
	     		obj.title="";
	     	}	
	     	
	     	if(eval(reg2).test(val)){
	     		obj.o_value=val;
			}

			/*if(!obj.value.match(/^[\+\-]?\d*?\.?\d*?$/))  //{0,2}
	     		obj.value=obj.t_value;
	     	else 
	     		obj.t_value=obj.value;
	     	
	     	if(obj.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))
	     		obj.o_value=obj.value;*/
	}
	
	//�õ���ֵ�����������
	function getAttrs(obj){
		var attrsKeys = "max,min,dataType,decimals".split(",");
		var attrs = {};
		var inp = $(obj);
		
		for(var i=0; i<attrsKeys.length; i++){
			attrs[attrsKeys[i]] = inp.attr(attrsKeys[i]) ? inp.attr(attrsKeys[i]) : "";
		}
		return attrs;
	}
	
})(jQuery);

