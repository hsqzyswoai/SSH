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
	/**����4����������ʵ����ɾ�Ĳ鹦��**************************/

	/**
	 * ��ȡ�б���Ϣ
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
	 * �������޸���Ϣ
	 */
	public String addEditEmployee() throws Exception{
		int num = 0;
		Map map=RequestUtil.getMapByRequest(this.getRequest());
		
		if(StringUtil.checkObj(map.get("iProjectId"))){//���ݶ����Ѿ���ID���޸�
			num = osProjectService.editOsProject(map);
		}else{//����
			map.put("dCreateDate",new Date());
			num = osProjectService.addOsProject(map);
		}
		RequestUtil.responseOut(encoding, num+"", this.getResponse());
		return null;
	}
	
	/**
	 * ɾ����Ϣ
	 */
	public String deleteEmployee() throws Exception{
		Map<String, String> map=RequestUtil.getMapByRequest(this.getRequest());
		int num = osProjectService.deleteOsProject(map.get("iProjectId"));
		RequestUtil.responseOut(encoding, num+"", this.getResponse());
		return null;
	}

}
