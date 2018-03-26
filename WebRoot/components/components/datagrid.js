/**
*���ؼ�
*/
(function($) { 
	$.fn.datagrid= function(opt,options) {
		if(typeof opt != 'object'){
			if(opt == 'loadData'){
				var opts = $(this).data(); //�õ�ԭʼ����
				opts.datas=options; //Ҫ���ֵ�����
				loadData(opts,this);
			}else if(opt=='options'){
				 return $(this).data();
			}else if(opt=='getSelected'){
				return getSelected(this);				
			}else if(opt=='getSelections'){
				return getSelections($(this));				
			}else if(opt=='getRowIndex'){
				 return getRowIndex(this, options);
			}else if(opt=='getRowByIndex'){
				return getRowByIndex(this,options)
			}else if(opt=='getRowById'){
				return getRowById(this, options);
			}else if(opt=='getRows'){
				 return getRows(this);
			}else if(opt=='selectRecord'){
				 selectRecord(this, options);
			}else if(opt=='selectRow'){
				 selectRow(this, options);
			}else if(opt=='checkRecord'){
				 checkRecord(this, options);
			}else if(opt=='checkRow'){
				 checkRow(this, options);
			}else if(opt=='isChecked'){
				 return isChecked(this, options);
			}else if(opt=='reSize'||opt=='resize'){
				 reSize(options, this);		
			}else if(opt=='getPager'){
				 return getPager(this);
			}else if(opt=='insertRow'){
				var ids = getSelectIds(this);
				var opts = $(this).data(); //�õ�ԭʼ����
				var datas = getRows(this);
				datas.splice(options.index,0,options.row); //Ҫ���ֵ�����
				loadData(opts,this);
				checkRecord(this,{id:ids,check:true})
				selectRow(this,options.index);
			}else if(opt=='updateRow'){
				var ids = getSelectIds(this);
				var opts = $(this).data(); //�õ�ԭʼ����
				var datas = getRows(this);
				$.extend(datas[options.index], options.row); 
				loadData(opts,this);
				checkRecord(this,{id:ids,check:true});
				selectRow(this,options.index);
			}else if(opt=='appendRow'){
				var ids = getSelectIds(this);
				var opts = $(this).data(); //�õ�ԭʼ����
				var datas = getRows(this);
				//datas.push(options);
				//datas = $.merge(datas,options);
				datas = datas.concat(options);
				opts.datas=datas;
				loadData(opts,this);
				checkRecord(this,{id:ids,check:true});
				selectRow(this,datas.length-1);
			}else if(opt=='deleteRow'){
				var ids = getSelectIds(this);
				var opts = $(this).data(); //�õ�ԭʼ����
				var datas = getRows(this);
				datas.splice(options,1); //Ҫ���ֵ�����
				loadData(opts,this);
				checkRecord(this,{id:ids,check:true});
				//selectRow(this,options.index);
			}else if(opt=='getColumnFields'){
				
			}else if(opt=='hideColumn'){
				
			}else if(opt=='showColumn'){
				
			}else if(opt=='getColumnOption'){
				
			}
		}else{
			loadData(opt, this);
		}
	};
	

	function loadData(options, obj){
		var div = $(obj); 
		
	    div.data(options); //��ԭʼ��������
		var columns = options.columns; //�ж���
		var checkbox=isShowCheckBox(options); //�Ƿ������ѡ
		var datas = options.datas; //����
		
		var tby = div.find('tbody');
		var h = tby.get(0)? $(tby).height():(options.height||div.height());
		h= (h<=0 || options.height=="auto") ? "auto" : h+"px";
		var w = tby.get(0)? $(tby).width():div.width();
				
		//�����б�html����
		var html = "";
		//ƴ�ӱ�ͷ
		html += '<table class="attachTable">';
		html += '<thead style="overflow:hidden;float:left;" ><tr>';
		for(var i=0;i<columns.length;i++){
			var oneWidth = 10;
			//���checkBox
			if(checkbox){
				html+='<th style="width:10px"><div class="formStyle"><input type="checkbox" name="chbox"></div></th>';
				oneWidth+=48;
			}
			//������ 2017.01.13
			
			for(var j=0;j<columns[i].length;j++){
				var col =columns[i][j];
				if(col.hidden && col.hidden.toString().toLowerCase()=="true"){continue;} 
				 
				var initialWidth =col.width?col.width:200; 
				var width= initialWidth+'px';
				
				oneWidth+=parseFloat(initialWidth+20);
				//��ʽ
				var style = ' style="width:' +width;
				var align=col.align?col.align:'left';
				style+=';text-align:'+align +'"';
				var seq = ' iSeqX="'+i +'" iSeqY="'+j+'" ';
				html += '<th class="tda" '+ style + seq +'><div style="width:'+width+';">'+col.title+'</div></th>';
			}
		}
		html+='</tr></thead><tbody style="overflow:auto;float:left;height:'+h+';width:'+w+'px;">';
		//ƴ��������
		if(datas){
			for(var i=0;i<datas.length;i++){
				//������ 2017.01.13
				var oneWidth = 10;
				
				html += '<tr class="formStyle" index="'+i+'"  dataId="'+datas[i][options.idField]+'">';
				if(checkbox){
					html+='<td width="10px"><div class="formStyle"><input index="'+i+'" type="checkbox" name="chbox"  '
							+ (datas[i].disabled?"disabled":"")  +'  ></div></td>';
					oneWidth+=48;
				}
				
				for(var j=0;j<columns[0].length;j++){
					var col =columns[0][j];
					if(col.hidden && col.hidden.toString().toLowerCase()=="true"){continue;}
					
					var initialWidth =col.width?col.width:200; 
					var width= initialWidth+'px';
					//var width=col.width?col.width+"px":'200px';
					
					/**��ӿ������Ӧ 2017.01.13
					if(j==(columns[0].length-1)){
						width = (w - oneWidth)>initialWidth?(w - oneWidth - 30):initialWidth;
						width += 'px';
				    }*/
					oneWidth+=parseFloat(initialWidth+20);
					
					html += '<td style="width:'+width +' ';
					if(col.cls){ html += 'class="'+col.cls+'" '; }
					var align=col.align?col.align:"left";
					html+=";text-align:"+align;
					html += '">';
					
					html += '<div contenteditable="'+col.contenteditable+'"  onblur="resetEditValueToDatas(this)" field="'+col.field
							+'" style="display:block;overflow: hidden;white-space:nowrap;text-overflow:ellipsis;width:'+width;
					if(align=='center'){
						html+=';margin-left:auto;margin-right:auto;';
					}else if(align=='right'){
						html+=';margin-left:auto;';
					}
					
					html+='"';
					var dataValue = datas[i][col.field]?datas[i][col.field]:'';
					if(col.formatter){dataValue=col.formatter(dataValue,datas[i],i);}
					
					if(col.displayTip != false && !col.formatter){
						html += 'title="'+dataValue+'" ';
					}
					html += '>';
					html += dataValue;
					html += '</div>';
        			html += '</td>';
        			
				}
	        	html += '</tr>';
			}
    	}
		html += '</tbody></table>';
		div.html(html);
		
		
		
		//���hover���¼�
		div.find("tbody tr").hover(
			function(){$(this).addClass("trhover");},
			function(){$(this).removeClass("trhover");}
		);
		
		//�����
		div.find("tbody tr").bind("click",function(){
			div.find("tbody tr").removeClass("trSelect");
			$(this).addClass("trSelect");
			
			if(options.onClickRow){ //�����¼�
				var index=div.find(".trSelect").attr("index");
				index=parseInt(index);
				var data=getRowByIndex(div,index);	
				options.onClickRow.call(this,index,data);
			}
		});
		
		//˫����
		div.find("tbody tr").bind("dblclick",function(){
			if(options.onDblClickRow){
				//��ȡ��ѡ�е���
				var index=div.find(".trSelect").attr("index");
				index=parseInt(index);
				var data=getRowByIndex(div,index);	
				options.onDblClickRow.call(this,index,data);
			}
		});
		
		//tbody �� thead ��������
		div.find('tbody').unbind('scroll').scroll(function(){
			div.find('thead').scrollLeft($(this).scrollLeft());
			//alert(div.find('thead').scrollLeft());
		});
		
		//���ñ�ͷ��Զ�ڿ�����
//		div.attr("stop",0);
//		var timeout = false; 
//		div.unbind("scroll").bind("scroll",function(){
//			var d = this;
//			if(d.scrollTop==div.attr("stop")){return;}//ֻ�����������
//			$(d).find("thead").css("display","none");
//			if (timeout){clearTimeout(timeout);} //��˴����ܱ����ǿ�ҵ�������
//			timeout = setTimeout(function(){ 
//				var t = d.scrollTop;
//				$(d).find("thead").css({"top":t});
//				$(d).find("thead").slideDown(300);
//				//$(d).find("thead").css({"display":"block"});
//				div.attr("stop",t);
//				if(t<20){$(d).find("thead").css("position","inherit");}
//				else{$(d).find("thead").css("position","absolute"); }
//			},5); 
//		});
		
		//���¼��ظ�ѡ����ʽ
		if(checkbox){ 
			div.find('.formStyle input').jqTransCheckBox(); 
		} 
		
		//���ȫѡ��
		getCheckBox(div.find("thead")).click(function(){
			if(optCheckClass($(this), 3)){
				optCheckClass(getCheckBox(div), 1);
				if(options.onSelectAll){options.onSelectAll.call(this,datas);} //�¼��ص�
			}else{
				optCheckClass(getCheckBox(div), 2);
				if(options.onUnselectAll){options.onUnselectAll.call(this,datas);} //�¼��ص�
			}
		});
		
		//�����ѡ��ѡ��
		getCheckBox(div.find("tbody")).click(function(){
			
			setTitleCheckSate(div);
			
			var index = $(this).closest("tr").attr("index");
			var row = datas[index];
			if(optCheckClass($(this), 3)){
				if(options.onSelect){options.onSelect.call(this, index, row);} //�¼��ص�
			}else{
				if(options.onUnselect){options.onUnselect.call(this, index, row);} //�¼��ص�
			}
		});
		
		//��ҳ����ʼ��
		if(options.pagination && !$(obj).next().hasClass('pagination')){
			div.after("<div id='pagination' class='pagination'><div>");
			//$(div.next()).pagination({pageSize:5,pageNumber:1,total:0});
		}
		
		//����Ӧ
		//reSize(options,$(obj));
		setTheadWidth(options, obj);
		
		tableResizeColumn($(div).find(".attachTable"));
		
		setLastColumnWidth(div);
	}
	
	/**�õ���ҳ��*/
	function getPager(obj){
		return $(obj).next();
	}
	
	/**���ÿ��*/
	function reSize(options, obj){
		var wh ={
				width:options.width ? options.width : $(obj).parent().width() || '100%',
				height:options.height ? ( $(obj).data().pagination ? options.height -30 : options.height) : $(obj).parent().height() || '100%'  //�з�ҳ��Ҫ�ټ�ȥ��ҳ���ĸ߶�
		};
		$(obj).css(wh);
		
		//���ñ����Ӧ,ʵ�ֱ�ͷ�̶�
		$(obj).find('tbody').height(wh.height-$(obj).find('thead').height());
		$(obj).find('tbody').width(wh.width);
		
		setTheadWidth(options, obj);
		
		setLastColumnWidth(obj);
	}
	
	/**���ñ�ͷ���*/
	function setTheadWidth(options, obj){
		//var trHeight = $(obj).find('tbody tr:eq(0)').height() || 0;
		var trCount = $(obj).find('tbody tr').length;
		var w = $(obj).find('tbody').width();
		
		$(obj).find('thead').width(w);
	}
	
	/**�ж��Ƿ�Ϊ��*/
	function IsEmpty(obj){
		return !obj ? true : false;		
	}
	
	/**����ѡ��*/
	function getSelected(div){
		var index=$(div).find(".trSelect").attr("index");
		index=parseInt(index);
		return getRowByIndex(div,index);
	}
	
	/**�ù�ѡ��*/
	function getSelections(div){
		var arr=[];
		$(div).find("tbody .jqTransformChecked").each(function(){
			var index=$(this).next().attr("index");
			index=parseInt(index);
			arr.push(getRowByIndex(div,index));
		});
		return arr;
	}
	
	/**�õ����й�ѡ�е�id*/
	function getSelectIds(div){
		var ids = "";
		var idField = $(div).data().idField;
		$(div).find("tbody .jqTransformChecked").each(function(){
			var index=$(this).next().attr("index");
			index=parseInt(index);
			var id= getRowByIndex(div,index)[idField];
			ids+=(id+",");
		});
		if(ids){ids=ids.substring(0,ids.length-1);}
		return ids;
	}
	
	/**�����кŵ�������*/
	function getRowByIndex(div,index){
		return $(div).data().datas[index];
	}
	
	/**�����к�����1��ѡ��*/
	function selectRow(div, index){
		var tr = $(div).find("tbody tr[index='"+index+"']");
		select(div, tr);
	}
	
	/**����idֵ����1��ѡ��*/
	function selectRecord(div, idValue){
		var tr = $(div).find("tbody tr[dataId='"+idValue+"']");
		select(div, tr);
	}
	
	/**����1��ѡ��*/
	function select(div, tr){
		$(div).find("tbody tr").removeClass("trSelect");
		$(tr).addClass("trSelect");
	}
	
	/**����idֵ����1�й�ѡ���*/
	function checkRecord(div, options){
		if(!options.id){return;}
		var ids = options.id.split(",");
		for(var i=0; i<ids.length; i++){
			var tr = $(div).find("tbody tr[dataId='"+ids[i]+"']");
			check(tr, options.check);
		}
	}
	
	/**�����к�����1��ѡ�����*/
	function checkRow(div, options){
		if(!options.index){return;}
		var indexs = options.index.split(",");
		for(var i=0; i<indexs.length; i++){
			var tr = $(div).find("tbody tr[index='"+indexs[i]+"']");
			check(tr, options.check);
		}
	}
	
	/**���ù�ѡ*/
	function check(obj, isCheck){
		if(obj.length==0){return;}
		var optType = isCheck ? 1 : 2;
		optCheckClass( getCheckBox(obj), optType);
		
		setTitleCheckSate($(obj).closest("div"));
	}
	
	/**�ж�һ���Ƿ�Ϊ��ѡ״̬*/
	function isChecked(div, options){ // {index:indexValue}|{id:idValue} 
		var tr = options.id==undefined ? 
					 	  $(div).find("tbody tr[index='"+options.index+"']")
						: $(div).find("tbody tr[dataId='"+options.id+"']");
						
		return optCheckClass( getCheckBox(tr), 3);
	}
	
	/**��������ID��������*/
	function getRowById(div, id){
		div = $(div);
		var tr = div.find("tr[dataId='"+id+"']");
		var index = tr.attr("index");
		return div.data().datas[index];
	}
	
	/**���������ݵ�ID*/
	function getRowIndex(div, options){
		var id = typeof(options)=='object' ?  options[$(div).data().idField] : options;
		
		var index = $(div).find("tbody tr[dataId='"+id+"']").attr("index");
		
		return index ? index*1 : -1; 
	}
	
	/**�ж��Ƿ���Ҫ��ѡ��*/
	function isShowCheckBox(options){
	   var checkbox=options.checkbox;
	   var cols = options.frozenColumns;
	   var boo =false;
	   if(cols && cols[0]){
		   for(var i=0; i<cols[0].length; i++){
				if(cols[0][i].checkbox){
					boo = true; break;
				}
		   }
	   }
	   return checkbox=="1" || boo;
	}
	
	/**�õ�����������*/
	function getRows(div){
		var datas = $(div).data().datas;
		if(!datas){datas=[];  $(div).data().datas = datas;} 
		return datas;
	}
	
	/**�õ�ĳ�����ڵ���ʽ��ѡ��*/
    function getCheckBox(obj){
    	return obj.find(".jqTransformCheckbox");
    }
    
    /**��ĳ�����ڵ���ʽ��ѡ����в���, 1,��ѡ��2��ȡ����ѡ��3���Ƿ���*/
    function optCheckClass(obj, optType){
    	if(optType==1){
    		obj.addClass("jqTransformChecked");
    		$(obj).each(function(){$(this).next().attr("checked",true);});
    	}else if(optType==2){
    		obj.removeClass("jqTransformChecked");
    		$(obj).each(function(){$(this).next().attr("checked",false);});
    	}else if(optType==3){
    		return obj.hasClass("jqTransformChecked");
    	}
    }
	
	/**���������е�ѡ��״̬����ȫѡ���״̬*/
	function setTitleCheckSate(obj){
			var div = $(obj);
			var datas = div.data().datas;
			
			var size=div.find("tbody .jqTransformChecked").length;
			var titleCheck = getCheckBox(div.find("thead"));
			
			optCheckClass(titleCheck, size==datas.length?1:2);
	}
	
	/**���ɱ༭��Ԫ����������õ����ݶ�����ȥ*/
	window.resetEditValueToDatas=function(obj){
		var cDiv = $(obj);
		var text = cDiv.text();
		var field = cDiv.attr("field");
		var tr = cDiv.closest("tr");
		var index = $(tr).attr("index");//="'+i+'"  dataId="'+datas[i][options.idField]+'"
		
		var div = $(tr).closest("div");
		var datas = $(div).data().datas;
		datas[index][field]=text;
		$(div).data().datas = datas;  //alert(field+"=="+index+"=="+datas.length);
	}
	
	/**�϶������п�*/
	function tableResizeColumn(table){
		var cols = $(table).find("thead tr th");
		var tTD; //�����洢��ǰ���Ŀ�ȵ�Table Cell,��������ƶ���������
		cols.bind("mousedown",function () {
				tTD = this;//��¼��Ԫ��
				window.datagrid_tTD=tTD;
				if (event.offsetX > tTD.offsetWidth - 10) {
					tTD.mouseDown = true;
					tTD.oldX = event.x;
					tTD.oldWidth = tTD.offsetWidth;
				}
			}
		);	
		cols.bind("mouseup", function () {
				//������ȵ���
				if (tTD == undefined){ tTD = this;}
				tTD.mouseDown = false;
				tTD.style.cursor = 'default';
			}
		 );
		$(window).bind("mouseup", function () {
				//������ȵ���
				if (window.datagrid_tTD){ 
					var tTD = window.datagrid_tTD;
					tTD.mouseDown = false;
					tTD.style.cursor = 'default';
				}
			}
		 );
		cols.bind("mousemove", function () {
				//ȡ���ݴ��Table Cell
				if (tTD == undefined) {tTD = this;}
				if(tTD.cellIndex==0 && $(tTD).find(".jqTransformCheckbox").length>0){return;}
				
				//���������ʽ
				var cs =  (event.offsetX > this.offsetWidth - 10) ? 'col-resize' : 'default';
				this.style.cursor = cs;
				
				
				//�������
				if (tTD.mouseDown != null && tTD.mouseDown == true) {
					//�����п�
					tTD.style.cursor = 'col-resize';
					if (tTD.oldWidth + (event.x - tTD.oldX)>0){
						var w =  tTD.oldWidth + (event.x - tTD.oldX)-20;
						$(tTD).width(w);
						$(tTD).find("div").eq(0).width(w);
					}
					
					//���������е�ÿ��Cell
					var rows = $(table).find("tbody tr");
					for (j = 0; j < rows.length; j++) {
						var td = $($(rows[j]).find("td")[tTD.cellIndex]);
						var w = $(tTD).width();
						td.width(w);
						td.find("div").eq(0).width(w);
					}
				}
			}
		);
	}
	
	/**����Ӧ���һ�п�ȣ���������п�Ȳ���������ȣ������һ�п�Ȳ��㣬������������*/
	function setLastColumnWidth(div){
		//�������
		var content_w = $(div).width(); 
		//�б���
		var tby = $(div).find('tbody');
		var table_w = tby.get(0)? $($(tby).find("tr")[0]).width():div.width();
		
		if(content_w>table_w){
			//���һ�п��
			var tds = $(tby).find("tr").eq(0).find("td");
			var lastCol_w = $(tds[tds.length-1]).width();
			
			lastCol_w = content_w-(table_w - lastCol_w);
			
			$(div).find("table tr").each(function(){  
				$(this).children("th:last").css({"width" : lastCol_w+"px" });  
				$(this).children("td:last").css({"width" : lastCol_w+"px" }); 
			});
		}
	}
	
})(jQuery);
