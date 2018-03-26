package com.catt.model.service.demo.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pub.source.Data;
import pub.source.DataType;
import pub.source.DatabaseUtil;

import com.catt.data.dao.demo.DemoDao;
import pub.source.TbEmployee;
import com.catt.model.service.demo.DemoService;

@Service("demoService")
public class DemoServiceImpl implements DemoService{
	
	@Autowired
	private DemoDao  demoDao;
	
	/**
	 * 查询人员集合
	 */
	public List getEmployeeList(Map map) {
		return demoDao.getEmployeeList(map);
	}

	/**
	 * 新增人员信息
	 */
	public int addEmployee(Map map) {
		List<Data> datas = new ArrayList<Data>();
		
		datas.add(Data.get("iEmployeeId", DataType.LONG, DatabaseUtil.getKeyId(null)));
		datas.add(Data.get("cEmployeeName", DataType.STRING, map.get("cEmployeeName")));
		datas.add(Data.get("iSex", DataType.INTEGER, map.get("iSex")));
		datas.add(Data.get("iLengthOfService", DataType.INTEGER, map.get("iLengthOfService")));
		datas.add(Data.get("dEmployDate", DataType.TIME_STAMP, map.get("dEmployDate")));
		datas.add(Data.get("iDutyId", DataType.LONG, map.get("iDutyId")));
		datas.add(Data.get("iDeptId", DataType.LONG, map.get("iDeptId")));
		datas.add(Data.get("cTel", DataType.STRING, map.get("cTel")));
		datas.add(Data.get("remark", DataType.STRING, map.get("remark")));
		
		return demoDao.addEmployee(datas);
	}

	/**
	 * 修改人员信息
	 */
	public int editEmployee(Map map) {
		List<Data> datas = new ArrayList<Data>();
		
		datas.add(Data.get(TbEmployee.iEmployeeId, map.get(TbEmployee.iEmployeeId.toString())));
		datas.add(Data.get(TbEmployee.cEmployeeName, map.get(TbEmployee.cEmployeeName.toString())));
		datas.add(Data.get(TbEmployee.iSex, map.get(TbEmployee.iSex.toString())));
		datas.add(Data.get(TbEmployee.iLengthOfService, map.get(TbEmployee.iLengthOfService.toString())));
		//datas.add(Data.get(TbEmployee.dEmployDate, map.get(TbEmployee.dEmployDate.toString())));
		datas.add(Data.get(TbEmployee.iDutyId, map.get(TbEmployee.iDutyId.toString())));
		datas.add(Data.get(TbEmployee.iDeptId, map.get(TbEmployee.iDeptId.toString())));
		datas.add(Data.get(TbEmployee.cTel, map.get(TbEmployee.cTel.toString())));
		datas.add(Data.get(TbEmployee.remark, map.get(TbEmployee.remark.toString())));
		
		return demoDao.editEmployee(datas);
	}

	/**
	 * 删除人员信息
	 */
	public int deleteEmployee(String empId) {
		return demoDao.deleteEmployee(empId);
	}
}
