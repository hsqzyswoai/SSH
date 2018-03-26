/*****************************************************************************************************
以下是配置相关代码
*/
window.onresize=setWH;
window.onload = onloadFn;

/** onload事件方法 */
function onloadFn() {
	createToolBar(); //构建工具栏
	createList(); //人员列表
	$("#mainCenter").bind("resize",setWH); //layout 布局块大小改变，内部表格要自适应
	initLoadData(true); //初始人员数据
	setWH(); //初始自适应
	commonUtil.setFastKey({eId:"form1", fn:function(){initLoadData(true)}}); //绑定Enter快捷键
}

//构建工具栏
function createToolBar(){
	//工具栏数据
	var toolJson = {
			renderTo : 'toolbar',
			align : 'left',
			items :
					[
						 { type : 'button',text : '查询',
							handler : function(){ 
								initLoadData(true);
							}
						},'-',
						{type : 'button',text : '新建',
							  handler : function(){
								 addEditEmployee(0);
							  }
						},'-',
						{type : 'button',text : '修改',
							  handler : function(){
								addEditEmployee(1);
							  }
						},'-',
						{type : 'button',text : '删除',
							  handler : function(){
								deleteEmployee();
							  }
						}
					]
	};
	//工具栏
	var toolbar = new Toolbar(toolJson);
	toolbar.render();
}

//设置列表高度
function setWH(){	
	var h = $(window).height();
	var w = $(window).width();
	$("#employeeList").datagrid("resize",{height:h-100,width:w});
}

//新增修改人员窗口配置
var addOrEditDiv = {
	title:"新增人员",
	width:500,
	height:275,
	zIndex: 9000,
	draggable:true, //拖动
	resizable:false, //改变大小
	modal: true, //后台页面可编辑
	closed: false, //是否关闭？
	minimizable: false,//最小化按钮
	maximizable: false,//最大化按钮
	closable: true, //关闭按钮
	collapsible: true, //收缩按钮 
	refresh:true//多次打开是否刷新页面
}

//列表属性
var cols = [
	[
	{field:'cEmployeeName',title:'人员名称',width:100,displayTip:true,sortable:true},
	{field:'sSex',title:'人员性别',width:100,align:'center'},
	{field:'cDeptName',title:'所属部门',width:100},
	{field:'cDutyName',title:'所属职务',width:100},
	{field:'iLengthOfService',title:'人员工龄', align:'right',width:70},
	{field:'dEmployDate',title:'入职日期',width:150},
	{field:'cTel',title:'联系电话',width:100},
	{field:'remark',title:'人员备注',width:230}/*,
	{field:'ck2',title:"不允许编辑", align:'center', formatter:function(value,rowData,rowIndex){
		return "<input type='checkbox' onclick=\"ck22(this,"+rowIndex+",'ck2')\" "+(value=="0"?"ckecked":"")+"'>";	
	},width:80},
	{field:'ck3', align:'center', title:"不允许查看",formatter:function(value,rowData,rowIndex){
		return "<input type='checkbox' onclick=\"ck22(this,"+rowIndex+",'ck3')\" "+(value=="0"?"ckecked":"")+"'>";	
	},width:80}*/
	]
];

//构建列表
function createList(){
	$('#employeeList').datagrid({
		idField:"iEmployeeId",	
		frozenColumns:[[{field:'ck',checkbox:true}]],//冻结列，且此列为复选框
		columns:cols,//普通列配置
		pagination:true,
		nowrap:true,
	});
	//先获取列表对象  
	var p = $('#employeeList').datagrid('getPager');      
	//设置分页控件  
	$(p).pagination({
		 total:0,//设置总记录数，默认0
		 pageSize: 5,//每页显示的记录条数，不设置默认为10 
		 pageNumber:0,//当前页，默认0
		 showPageList:false,
		 showRefresh:false,
		 //描述        
		 beforePageText: '第',//页数文本框前显示的汉字           
		 afterPageText: '页    共 {pages} 页',           
		 displayMsg: '当前显示第 {from} - {to} 条记录   共 {total} 条记录', 
		 onSelectPage:function(pageNo,limit){//点击上、下一页时，触发事件
		 	initLoadData();//alert("点击上、下页事件：\n下一页："+pageNo+"\n每页行显示行数:"+limit);
		 }
	 }); 
}

/*****************************************************************************************************
以下是过程相关代码
*/

/**加载数据*/
function initLoadData(flg,pkId) {
	if(document.getElementById("endTime").value != null && document.getElementById("endTime").value != ""){
		if(document.getElementById("creatTime").value > document.getElementById("endTime").value){
			simpleAlert("开始时间不能大于结束时间!");
			return false;
		}
	}
	
	var p = $('#employeeList').datagrid('getPager');      
	var options=$(p).pagination("options");
	var pageNo=flg?1:options.pageNumber
	var limit=options.pageSize;
	var url = path + "/demo/demo!getEmployeeList.action?pageNo="+pageNo+"&limit="+limit;
	AjaxRequest.doRequest("form1", url, null, function(backData){
		var jsonData = decode(backData);
		$('#employeeList').datagrid('loadData',jsonData);
		if(pkId)$('#employeeList').datagrid('selectRecord',pkId);//如果之前有选中行,则继续选中,适用于编辑后选中编辑行
		//查询后重置总记录数与当前页码(以下这段代码最好整个项目级封装一下)
		if(jsonData[0] != null){
			$(p).pagination({total:jsonData[0].totalCount,pageNumber:pageNo});
		}else {
			$(p).pagination({total:0,pageNumber:1});//分页
		}
	});
}

/** 打开新增修改人员窗口 */
function openAddOrEditWin(uri, jsonDiv){
	jsonDiv.url=uri;
	jsonDiv.id="addOrEdit"
	jsonDiv.checkLogin=false;//跳过登录验证
	showJqueryWindow(jsonDiv);//showJqueryWindow方在js/common.js中
}

/** 新增、修改人员 */
function addEditEmployee(flag) {
	var uri = path+"/demo/dbam/jquery/addOrEditFlex.jsp";
	if(flag == 0){
		//修改弹出窗体配置文件的标题
		uri=uri+"?flag=0";
		addOrEditDiv.title = "新增人员";
	}else{
		//得要修改的行,getDelOrUpdItems()在js/common.js中
		var obj={listType:"jquery",optType:"update",listId:"employeeList",keyCol:"iEmployeeId"};
		var iEmployeeId=getDelOrUpdItems(obj);
		if(iEmployeeId=="notOnly"){simpleAlert("修改操作，只能勾选单行！");return;}
		if(!iEmployeeId){simpleAlert("请选中要修改的行!");return;}
	    
	    uri = uri+"?flag=1&iEmployeeId=" + iEmployeeId;
		addOrEditDiv.title = "修改人员";
    }
	openAddOrEditWin(uri, addOrEditDiv);
}

/** 删除人员 */
function deleteEmployee() {
	//得要删除的行,getDelOrUpdItems()在js/common.js中
	var obj={listType:"jquery",optType:"delete",listId:"employeeList",keyCol:"iEmployeeId"};
	var iEmployeeId=getDelOrUpdItems(obj);
	if(!iEmployeeId){simpleAlert("请勾选要删除的行!");return}
	
    //二次确认否要删除
	simpleAlert({msg:"确定要删除吗？", type:2, icon:"question", fn:function(){
		//执行删除方法
	    AjaxRequest.doRequest(null, path+'/demo/demo!deleteEmployee.action', {iEmployeeId: iEmployeeId}, function(flag) {
	    	 if(flag == '0' || flag == 0) {
				 simpleAlert('操作失败！');
			 }else {
				 simpleAlert({msg:'操作完成！',fn:function(){
				 	 initLoadData();
				 }});
			 }
	    });
    }});
}