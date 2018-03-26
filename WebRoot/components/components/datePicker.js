/**
*ʱ��ؼ�
$("#XX").datePicker({});
*/
(function($) { 
	$.fn.datePicker= function(opt,options) {
		if(typeof opt != 'object'){
			if(opt == 'loadData'){
				var opts = $(this).data(); //�õ�ԭʼ����
				opts.datas=options; //Ҫ���ֵ�����
				loadData(opts,this);
			}
		}else{
			loadData(opt, this);
		}
	};
	
	
	/**��ʼ��*/
	function loadData(opts, obj){
		var inp = $(obj);
		if(inp.parent().hasClass("specie")){return;}
		var inpHtml = inp.prop("outerHTML").replace('class="Wdate"','class="deInput"').replace(/<input/i, '<input readonly style="width:100%;" ');
		var id=inp.attr('id');
		
		var click = inp.attr("onclick"); //��WdatePicker ( {dateFmt:'MM-dd',minDate:'#F{$dp.$D(\'DEMPLOYDATE\')}'})
		if(click){
			click = click.replace("{", "{el:'"+id+"',"); //�ѵ�һ��{���滻����һ�����ƾͺ�
		}
		inp.data(opts);
		
		//����
		var html = [];
		html.push('<div class="specie">');
		html.push(inpHtml);		      
		html.push('<a>&nbsp;</a>');		      
		html.push('</div>');
		inp.after(html.join(''));
		
		inp.remove();
		
		$("#"+id).next().attr('onclick',click);
	}
})(jQuery);
