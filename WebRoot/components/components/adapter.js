/**�ؼ�����*/
commonUtil.initJquerySelect = function(option){};
commonUtil.initPopupWindow = function(option){};
commonUtil.initDigit = function(option){};
//���ɵ��ļ��ϴ��ؼ�
commonUtil.initFileUpload=function(params){
 	try{//�˲��ֽ�������ͨ�õ���
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
 	
 	$("#"+params.eId).fileUpload(params); //��ʼ���ļ��ϴ���
 };


$(function(){
//������
//������ѡ��
//����ѡ

//��ֵ��
$(".orderTable .Digit").each(function(){
	$(this).number({});
});
//ʱ���
$(".orderTable .Wdate").each(function(){
	$(this).datePicker({});
});

 //layout���
$(".easyui-layout").each(function(){
	$(this).layout({});
});

 //panel���
$(".easyui-panel").each(function(){
	$(this).panel({collapsible:true});
}); 

});