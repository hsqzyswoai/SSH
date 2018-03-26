package com.catt.view.action.hsq;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.catt.model.service.hsq.OsProjectService;
import com.catt.view.action.BaseAction;

import util.JackJson;
import util.RequestUtil;
import util.StringUtil;

@SuppressWarnings("serial")
@Component("osProjectAction")
@Scope("prototype")
public class OsProjectAction extends BaseAction{
	@Autowired
	private OsProjectService osProjectService;
	
	private final String encoding = "GBK";
	
	@Override
	public Object getModel() {
		// TODO Auto-generated method stub
		return null;
	}
	/**以下4个方法用于实现增删改查功能**************************/

	/**
	 * 获取列表信息
	 */
	public String getEmployeeList() throws Exception{
		Map<String, String> map=RequestUtil.getMapByRequest(this.getRequest());
		//ExprotRegister.searchOrExport(this.getRequest(), this.getResponse(), demoService, "getEmployeeList", mp);			
		List list = osProjectService.getOsProjectList(map);
		String json = JackJson.getBasetJsonData(list); 
		RequestUtil.responseOut(encoding, json, this.getResponse());
		
		return null;
	}
	
	/**
	 * 新增、修改信息
	 */
	public String addEditEmployee() throws Exception{
		int num = 0;
		Map map=RequestUtil.getMapByRequest(this.getRequest());
		
		if(StringUtil.checkObj(map.get("iProjectId"))){//数据对象已经有ID：修改
			num = osProjectService.editOsProject(map);
		}else{//新增
			map.put("dCreateDate",new Date());
			num = osProjectService.addOsProject(map);
		}
		RequestUtil.responseOut(encoding, num+"", this.getResponse());
		return null;
	}
	
	/**
	 * 删除信息
	 */
	public String deleteEmployee() throws Exception{
		Map<String, String> map=RequestUtil.getMapByRequest(this.getRequest());
		int num = osProjectService.deleteOsProject(map.get("iProjectId"));
		RequestUtil.responseOut(encoding, num+"", this.getResponse());
		return null;
	}

}
