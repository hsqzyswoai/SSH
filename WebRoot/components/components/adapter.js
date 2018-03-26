/**控件适配*/
commonUtil.initJquerySelect = function(option){};
commonUtil.initPopupWindow = function(option){};
commonUtil.initDigit = function(option){};
//生成单文件上传控件
commonUtil.initFileUpload=function(params){
 	try{//此部分仅适用于通用导入
	 	var ul = $(".btn_hover");
	 	ul.addClass("business");
	 	ul.css({width:"auto"});
	 	ul.find("li").last().css({borderRight:'0px'});
	 	
	 	var tb = $('.formbasic');
	 	tb.attr("height",30);
	 	tb.css("height",30);
	 	tb.addClass("orderTable");
	 	tb.find("td").last().css({padding:0,paddingRight:20});
 	}catch(e){}
 	
 	$("#"+params.eId).fileUpload(params); //初始化文件上传框
 };


$(function(){
//下拉框
//下拉多选框
//弹窗选

//数值框
$(".orderTable .Digit").each(function(){
	$(this).number({});
});
//时间框
$(".orderTable .Wdate").each(function(){
	$(this).datePicker({});
});

 //layout插件
$(".easyui-layout").each(function(){
	$(this).layout({});
});

 //panel插件
$(".easyui-panel").each(function(){
	$(this).panel({collapsible:true});
}); 

});