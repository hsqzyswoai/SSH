/**��ҳ���ؼ�*/
(function($) { 
	
	var defaults = {
	        pageNumber: 1,//��ǰҳ
	        pageSize:30,//ÿҳ��ʾ����
	        total:0,//�ܼ�¼��
	        position:"right",//���÷�ҳ��λ�ã�left,right,center
	        midRange: 3,//�м���������ҳ�� Ĭ��3ҳ����Сֵ3
	        onSelectPage: function(pageNo,pageSize){} //�����ҳ��ť�ص��¼�
	      };

	$.fn.pagination= function(method, options) {
		if(typeof(method)=='object'){
			var opts = $(this).data();
			opts = opts ? opts : {};
			var data = {};
			$.extend(data, defaults, opts, method);
			create(data, this);
			
		}else if(method=="options"){
			var options = $(this).data();
			return options;
		}
		
		//����
		function create(opts, obj){
			opts = getTotalPages(opts);
			
			opts.pageNumber=opts.pageNumber<1?1:opts.pageNumber;
			opts.midRange = opts.midRange<3 ? 3 : opts.midRange;
			
			if(data.oldMidRange){
				opts.midRange = data.oldMidRange;
			}else{
				data.oldMidRange = (opts.midRange?opts.midRange: defaults.midRange); //����������м�ҳ��
			}
			
			var centerRange = opts.maxPageNum-2;
			var range = centerRange>opts.midRange ? opts.midRange : centerRange;
			opts.midRange = range;
			
			var a = [];
			if(opts.total&&opts.total>0){
				a.push('<a class="jp-previous"></a>');
				a.push('<a>1</a>');
				a.push('<a class="jp-ellipsis jp-ellipsis-hidden">...</a>');
				
				a.push('<span class="jp_pagination_center">');
				for(var i=range; i>0; i--){
					a.push('<a>&nbsp;</a>');
				}
				a.push('</span>');
				
				a.push('<a class="jp-ellipsis '+ ( 1+opts.midRange<opts.maxPageNum ? "" : "jp-ellipsis-hidden") +'">...</a>');
				if(opts.maxPageNum>1){a.push('<a>'+opts.maxPageNum+'</a>');}
				a.push('<a class="jp-next"></a>');
			}
			
			var html = '<div class="holder">'+a.join('')+'</div><div class="totalList">��'+opts.total+'����¼</div>';
			$(obj).html(html);
			$(obj).data(opts); //��ԭʼ����
			
			resetPaginationCenter(opts.pageNumber, obj);
			
			$(obj).find("a").click(function(){onSelectPage(this, obj);});
			$(obj).width("100%");
			var pageWid=$(obj).width();	
			var holderWid=$('.holder', obj).width();	
			var totalListWid=$('.totalList', obj).width();
			
			/**�Զ����ҳ��λ�� 2017.01.13*/
			if(opts.position=="center"){
				//���÷�ҳ������
				$('.holder', obj).css({marginRight:(pageWid-holderWid-totalListWid)/2});
			}else if(opts.position=="left"){
				//���÷�ҳ������
				$('.holder', obj).css({marginRight:pageWid-holderWid-totalListWid-20});
			}
			
		}	
		
		//����ҳ��
		function getTotalPages(options){
			options.maxPageNum = options.total%options.pageSize==0 ? options.total/options.pageSize : Math.floor(options.total/options.pageSize +1);
			return options;
		}
		
		//���ҳ��
		function onSelectPage(e, divObj){
			
			var a = $(e); 
			if(a.hasClass("jp-ellipsis")){return;}
			
			var options = divObj.data();
			var oldPageNo = options.pageNumber;
			
			var currenPage;
			if(a.hasClass("jp-previous")){
				currenPage = (divObj.find(".jp-current").text())*1-1;
				currenPage = currenPage<1 ? 1:currenPage;
			}else if(a.hasClass("jp-next")){
				currenPage = (divObj.find(".jp-current").text())*1+1;
				currenPage = currenPage>opts.maxPageNum ? opts.maxPageNum:currenPage;
			}else{
				currenPage = a.text();
			}
			
			if(oldPageNo == currenPage){return;}
			
			resetPaginationCenter(currenPage, divObj)
			options.pageNumber = currenPage;
			divObj.data(options);
			
			if(options.onSelectPage){
				options.onSelectPage(currenPage, options.pageSize);
			}
		}
		
		//�����м�����
		function resetPaginationCenter(currenPage, divObj){
			
			divObj.find("a").removeClass("jp-current");
			var opts = divObj.data();
			var maxPageNum = opts.maxPageNum;
			var allA = divObj.find("a");
			if(currenPage==1){
				$(allA[1]).addClass("jp-current");
			}else if(maxPageNum == currenPage){
				$(allA[allA.length-2]).addClass("jp-current");
			}
			
			//return;
			var midRange = opts.midRange;
			var lim = Math.floor(midRange/2); //�������
			var p = currenPage*1-lim;  
			var l = currenPage*1+lim+1;
			
			var ellipsis = divObj.find(".jp-ellipsis");
			var centerA = divObj.find(".jp_pagination_center a"); 
			
			var boo = maxPageNum-2==opts.midRange || opts.oldMidRange!=opts.midRange;
			
			if(p-1<=1 || boo ){$(ellipsis[0]).addClass("jp-ellipsis-hidden");}else{$(ellipsis[0]).removeClass("jp-ellipsis-hidden");}
			if(l-(opts.midRange%2==0?1:0)>=maxPageNum || boo){$(ellipsis[1]).addClass("jp-ellipsis-hidden");}else{$(ellipsis[1]).removeClass("jp-ellipsis-hidden");}
			
			p = p<=1 ? 2 : p;
			p = (p+midRange> maxPageNum) ? maxPageNum-midRange : p;
			for(var i=0;i<midRange;i++){
				var temp = p+i;
				$(centerA[i]).text(temp);
				if(temp == currenPage){$(centerA[i]).addClass("jp-current");}
			}
		}
		
		function setPagewidth(obj){
			var pageWid=$(obj).width();
			var holderWid=$(obj).find(".holder").width();
			var totalListWid=$('.totalList', obj).width();
			$('.holder', obj).css({marginLeft:(pageWid-holderWid-totalListWid)/2});
		};
	
	};	

})(jQuery);