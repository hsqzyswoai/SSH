/**
*表格控件
*/
(function($) { 
	$.fn.datagrid= function(opt,options) {
		if(typeof opt != 'object'){
			if(opt == 'loadData'){
				var opts = $(this).data(); //得到原始定义
				opts.datas=options; //要呈现的数据
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
				var opts = $(this).data(); //得到原始定义
				var datas = getRows(this);
				datas.splice(options.index,0,options.row); //要呈现的数据
				loadData(opts,this);
				checkRecord(this,{id:ids,check:true})
				selectRow(this,options.index);
			}else if(opt=='updateRow'){
				var ids = getSelectIds(this);
				var opts = $(this).data(); //得到原始定义
				var datas = getRows(this);
				$.extend(datas[options.index], options.row); 
				loadData(opts,this);
				checkRecord(this,{id:ids,check:true});
				selectRow(this,options.index);
			}else if(opt=='appendRow'){
				var ids = getSelectIds(this);
				var opts = $(this).data(); //得到原始定义
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
				var opts = $(this).data(); //得到原始定义
				var datas = getRows(this);
				datas.splice(options,1); //要呈现的数据
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
		
	    div.data(options); //绑定原始定义数据
		var columns = options.columns; //列定义
		var checkbox=isShowCheckBox(options); //是否允许多选
		var datas = options.datas; //数据
		
		var tby = div.find('tbody');
		var h = tby.get(0)? $(tby).height():(options.height||div.height());
		h= (h<=0 || options.height=="auto") ? "auto" : h+"px";
		var w = tby.get(0)? $(tby).width():div.width();
				
		//生成列表html代码
		var html = "";
		//拼接表头
		html += '<table class="attachTable">';
		html += '<thead style="overflow:hidden;float:left;" ><tr>';
		for(var i=0;i<columns.length;i++){
			var oneWidth = 10;
			//添加checkBox
			if(checkbox){
				html+='<th style="width:10px"><div class="formStyle"><input type="checkbox" name="chbox"></div></th>';
				oneWidth+=48;
			}
			//定义宽度 2017.01.13
			
			for(var j=0;j<columns[i].length;j++){
				var col =columns[i][j];
				if(col.hidden && col.hidden.toString().toLowerCase()=="true"){continue;} 
				 
				var initialWidth =col.width?col.width:200; 
				var width= initialWidth+'px';
				
				oneWidth+=parseFloat(initialWidth+20);
				//样式
				var style = ' style="width:' +width;
				var align=col.align?col.align:'left';
				style+=';text-align:'+align +'"';
				var seq = ' iSeqX="'+i +'" iSeqY="'+j+'" ';
				html += '<th class="tda" '+ style + seq +'><div style="width:'+width+';">'+col.title+'</div></th>';
			}
		}
		html+='</tr></thead><tbody style="overflow:auto;float:left;height:'+h+';width:'+w+'px;">';
		//拼接数据行
		if(datas){
			for(var i=0;i<datas.length;i++){
				//定义宽度 2017.01.13
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
					
					/**添加宽度自适应 2017.01.13
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
		
		
		
		//鼠标hover行事件
		div.find("tbody tr").hover(
			function(){$(this).addClass("trhover");},
			function(){$(this).removeClass("trhover");}
		);
		
		//点击行
		div.find("tbody tr").bind("click",function(){
			div.find("tbody tr").removeClass("trSelect");
			$(this).addClass("trSelect");
			
			if(options.onClickRow){ //单击事件
				var index=div.find(".trSelect").attr("index");
				index=parseInt(index);
				var data=getRowByIndex(div,index);	
				options.onClickRow.call(this,index,data);
			}
		});
		
		//双击行
		div.find("tbody tr").bind("dblclick",function(){
			if(options.onDblClickRow){
				//获取被选中的行
				var index=div.find(".trSelect").attr("index");
				index=parseInt(index);
				var data=getRowByIndex(div,index);	
				options.onDblClickRow.call(this,index,data);
			}
		});
		
		//tbody 与 thead 滚动条绑定
		div.find('tbody').unbind('scroll').scroll(function(){
			div.find('thead').scrollLeft($(this).scrollLeft());
			//alert(div.find('thead').scrollLeft());
		});
		
		//设置表头永远在可视区
//		div.attr("stop",0);
//		var timeout = false; 
//		div.unbind("scroll").bind("scroll",function(){
//			var d = this;
//			if(d.scrollTop==div.attr("stop")){return;}//只考虑纵向滚动
//			$(d).find("thead").css("display","none");
//			if (timeout){clearTimeout(timeout);} //如此处理能避免很强烈的跳动感
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
		
		//重新加载复选框样式
		if(checkbox){ 
			div.find('.formStyle input').jqTransCheckBox(); 
		} 
		
		//点击全选框
		getCheckBox(div.find("thead")).click(function(){
			if(optCheckClass($(this), 3)){
				optCheckClass(getCheckBox(div), 1);
				if(options.onSelectAll){options.onSelectAll.call(this,datas);} //事件回调
			}else{
				optCheckClass(getCheckBox(div), 2);
				if(options.onUnselectAll){options.onUnselectAll.call(this,datas);} //事件回调
			}
		});
		
		//点击行选复选框
		getCheckBox(div.find("tbody")).click(function(){
			
			setTitleCheckSate(div);
			
			var index = $(this).closest("tr").attr("index");
			var row = datas[index];
			if(optCheckClass($(this), 3)){
				if(options.onSelect){options.onSelect.call(this, index, row);} //事件回调
			}else{
				if(options.onUnselect){options.onUnselect.call(this, index, row);} //事件回调
			}
		});
		
		//分页栏初始化
		if(options.pagination && !$(obj).next().hasClass('pagination')){
			div.after("<div id='pagination' class='pagination'><div>");
			//$(div.next()).pagination({pageSize:5,pageNumber:1,total:0});
		}
		
		//自适应
		//reSize(options,$(obj));
		setTheadWidth(options, obj);
		
		tableResizeColumn($(div).find(".attachTable"));
		
		setLastColumnWidth(div);
	}
	
	/**得到分页栏*/
	function getPager(obj){
		return $(obj).next();
	}
	
	/**重置宽高*/
	function reSize(options, obj){
		var wh ={
				width:options.width ? options.width : $(obj).parent().width() || '100%',
				height:options.height ? ( $(obj).data().pagination ? options.height -30 : options.height) : $(obj).parent().height() || '100%'  //有分页栏要再减去分页栏的高度
		};
		$(obj).css(wh);
		
		//重置表格适应,实现表头固定
		$(obj).find('tbody').height(wh.height-$(obj).find('thead').height());
		$(obj).find('tbody').width(wh.width);
		
		setTheadWidth(options, obj);
		
		setLastColumnWidth(obj);
	}
	
	/**设置表头宽度*/
	function setTheadWidth(options, obj){
		//var trHeight = $(obj).find('tbody tr:eq(0)').height() || 0;
		var trCount = $(obj).find('tbody tr').length;
		var w = $(obj).find('tbody').width();
		
		$(obj).find('thead').width(w);
	}
	
	/**判断是否为空*/
	function IsEmpty(obj){
		return !obj ? true : false;		
	}
	
	/**得行选行*/
	function getSelected(div){
		var index=$(div).find(".trSelect").attr("index");
		index=parseInt(index);
		return getRowByIndex(div,index);
	}
	
	/**得勾选行*/
	function getSelections(div){
		var arr=[];
		$(div).find("tbody .jqTransformChecked").each(function(){
			var index=$(this).next().attr("index");
			index=parseInt(index);
			arr.push(getRowByIndex(div,index));
		});
		return arr;
	}
	
	/**得到所有勾选行的id*/
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
	
	/**根据行号得行数据*/
	function getRowByIndex(div,index){
		return $(div).data().datas[index];
	}
	
	/**根据行号设置1行选中*/
	function selectRow(div, index){
		var tr = $(div).find("tbody tr[index='"+index+"']");
		select(div, tr);
	}
	
	/**根据id值设置1行选中*/
	function selectRecord(div, idValue){
		var tr = $(div).find("tbody tr[dataId='"+idValue+"']");
		select(div, tr);
	}
	
	/**设置1行选中*/
	function select(div, tr){
		$(div).find("tbody tr").removeClass("trSelect");
		$(tr).addClass("trSelect");
	}
	
	/**根据id值设置1行勾选与否*/
	function checkRecord(div, options){
		if(!options.id){return;}
		var ids = options.id.split(",");
		for(var i=0; i<ids.length; i++){
			var tr = $(div).find("tbody tr[dataId='"+ids[i]+"']");
			check(tr, options.check);
		}
	}
	
	/**根据行号设置1行选中与否*/
	function checkRow(div, options){
		if(!options.index){return;}
		var indexs = options.index.split(",");
		for(var i=0; i<indexs.length; i++){
			var tr = $(div).find("tbody tr[index='"+indexs[i]+"']");
			check(tr, options.check);
		}
	}
	
	/**设置勾选*/
	function check(obj, isCheck){
		if(obj.length==0){return;}
		var optType = isCheck ? 1 : 2;
		optCheckClass( getCheckBox(obj), optType);
		
		setTitleCheckSate($(obj).closest("div"));
	}
	
	/**判断一行是否为勾选状态*/
	function isChecked(div, options){ // {index:indexValue}|{id:idValue} 
		var tr = options.id==undefined ? 
					 	  $(div).find("tbody tr[index='"+options.index+"']")
						: $(div).find("tbody tr[dataId='"+options.id+"']");
						
		return optCheckClass( getCheckBox(tr), 3);
	}
	
	/**根据数据ID得行数据*/
	function getRowById(div, id){
		div = $(div);
		var tr = div.find("tr[dataId='"+id+"']");
		var index = tr.attr("index");
		return div.data().datas[index];
	}
	
	/**根据行数据得ID*/
	function getRowIndex(div, options){
		var id = typeof(options)=='object' ?  options[$(div).data().idField] : options;
		
		var index = $(div).find("tbody tr[dataId='"+id+"']").attr("index");
		
		return index ? index*1 : -1; 
	}
	
	/**判断是否需要复选框*/
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
	
	/**得到所有数据行*/
	function getRows(div){
		var datas = $(div).data().datas;
		if(!datas){datas=[];  $(div).data().datas = datas;} 
		return datas;
	}
	
	/**得到某对象内的样式复选框*/
    function getCheckBox(obj){
    	return obj.find(".jqTransformCheckbox");
    }
    
    /**对某对象内的样式复选框进行操作, 1,勾选，2，取消勾选，3，是否有*/
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
	
	/**根据所有行的选中状态设置全选框的状态*/
	function setTitleCheckSate(obj){
			var div = $(obj);
			var datas = div.data().datas;
			
			var size=div.find("tbody .jqTransformChecked").length;
			var titleCheck = getCheckBox(div.find("thead"));
			
			optCheckClass(titleCheck, size==datas.length?1:2);
	}
	
	/**将可编辑单元格的数据设置到数据对象内去*/
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
	
	/**拖动重置列宽*/
	function tableResizeColumn(table){
		var cols = $(table).find("thead tr th");
		var tTD; //用来存储当前更改宽度的Table Cell,避免快速移动鼠标的问题
		cols.bind("mousedown",function () {
				tTD = this;//记录单元格
				window.datagrid_tTD=tTD;
				if (event.offsetX > tTD.offsetWidth - 10) {
					tTD.mouseDown = true;
					tTD.oldX = event.x;
					tTD.oldWidth = tTD.offsetWidth;
				}
			}
		);	
		cols.bind("mouseup", function () {
				//结束宽度调整
				if (tTD == undefined){ tTD = this;}
				tTD.mouseDown = false;
				tTD.style.cursor = 'default';
			}
		 );
		$(window).bind("mouseup", function () {
				//结束宽度调整
				if (window.datagrid_tTD){ 
					var tTD = window.datagrid_tTD;
					tTD.mouseDown = false;
					tTD.style.cursor = 'default';
				}
			}
		 );
		cols.bind("mousemove", function () {
				//取出暂存的Table Cell
				if (tTD == undefined) {tTD = this;}
				if(tTD.cellIndex==0 && $(tTD).find(".jqTransformCheckbox").length>0){return;}
				
				//更改鼠标样式
				var cs =  (event.offsetX > this.offsetWidth - 10) ? 'col-resize' : 'default';
				this.style.cursor = cs;
				
				
				//调整宽度
				if (tTD.mouseDown != null && tTD.mouseDown == true) {
					//调整列宽
					tTD.style.cursor = 'col-resize';
					if (tTD.oldWidth + (event.x - tTD.oldX)>0){
						var w =  tTD.oldWidth + (event.x - tTD.oldX)-20;
						$(tTD).width(w);
						$(tTD).find("div").eq(0).width(w);
					}
					
					//调整该列中的每个Cell
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
	
	/**自适应最后一列宽度：如果所有列宽比不过容器宽度，则将最后一列宽度补足，做到界面满铺*/
	function setLastColumnWidth(div){
		//容器宽度
		var content_w = $(div).width(); 
		//列表宽度
		var tby = $(div).find('tbody');
		var table_w = tby.get(0)? $($(tby).find("tr")[0]).width():div.width();
		
		if(content_w>table_w){
			//最后一列宽度
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
