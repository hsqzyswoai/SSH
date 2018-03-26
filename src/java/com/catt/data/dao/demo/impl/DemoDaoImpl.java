package com.catt.data.dao.demo.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.catt.data.dao.demo.DemoDao;
import pub.source.TbEmployee;

import pub.dbDialectFactory.Dialect;
import pub.dbDialectFactory.DialectFactory;
import pub.source.Data;
import pub.source.DataType;
import pub.source.DatabaseUtil;
import util.StringUtil;

@SuppressWarnings("serial")
@Repository("demoDao")
public class DemoDaoImpl implements DemoDao{
	
	/**
	 * 查询人员集合或者导出
	 */
	public List getEmployeeList(Map map) {
		String pageNo = (String)map.get("pageNo");
		String limit = (String)map.get("limit");
		
		List list=new ArrayList();
		Dialect dia = DialectFactory.getDialect();
		StringBuffer sql = new StringBuffer();
		//如果是oracle库,都加个别名，并用“”号引起来
		sql.append("select e.iEmployeeId as \"iEmployeeId\",e.cEmployeeName \"cEmployeeName\",e.iSex \"iSex\", (case e.iSex when 1 then '男' when 2 then '女' end) as \"sSex\",");
		sql.append("e.iLengthOfService \"iLengthOfService\",");
		sql.append(dia.datetimeTostring("e.dEmployDate", "")); 
		sql.append(" \"dEmployDate\",e.cTel \"cTel\",e.iDutyId \"iDutyId\",du.cDutyName \"cDutyName\",");
		sql.append("e.iDeptId \"iDeptId\",de.cDeptName \"cDeptName\",e.remark \"remark\" ");
		sql.append(" from tbEmployee e left join tbDept de on e.iDeptId=de.iDeptId left join tbDuty du");
		sql.append(" on e.iDutyId=du.iDutyId where 1=1 ");
		
		if(StringUtil.checkObj(map.get("iEmployeeId"))){
			sql.append(" and e.iEmployeeId = ?");
			list.add(Integer.valueOf((String)map.get("iEmployeeId")));
		}
		if(StringUtil.checkObj(map.get("cEmployeeName"))){
			sql.append(" and e.cEmployeeName like ? ");
			list.add("%"+map.get("cEmployeeName")+"%");
		}
		if(StringUtil.checkObj(map.get("sName"))){
			sql.append(" and e.cEmployeeName like ? ");
			list.add("%"+map.get("sName")+"%");
		}
		
		if(StringUtil.checkObj(map.get("sSex"))){
			sql.append(" and e.iSex = ? ");
			//list.add(StringUtil.toInt((String)map.get("sSex")));
			
			list.add(DataType.INTEGER.getVal(map.get("sSex")));
		}
		if(StringUtil.checkObj(map.get("iDeptId"))){
			String inParams = DatabaseUtil.inParameterLoader(StringUtil.toString(map.get("iDeptId")), list);
			sql.append(" and e.iDeptId ");
			sql.append(inParams);
		}
		if(StringUtil.checkObj(map.get("iDuty"))){
			String inParams = DatabaseUtil.inParameterLoader(StringUtil.toString(map.get("iDuty")), list);
			sql.append(" and e.iDutyId ");
			sql.append(inParams);
		}
		if(StringUtil.checkObj(map.get("sTel"))){
			sql.append(" and e.cTel like ? ");
			list.add("%"+map.get("sTel")+"%");
		}
		if (StringUtil.checkObj(map.get("remark"))) {
			sql.append(" and e.remark like ?");
			list.add("%"+map.get("remark")+"%");
		}
		if(StringUtil.checkObj(map.get("creatTime")) && StringUtil.checkObj(map.get("endTime"))){
			sql.append(" and e.dEmployDate between ?").append(" and ?");
			list.add(StringUtil.parseObj("7", (String)map.get("creatTime") + " 00:00:00"));
			list.add(StringUtil.parseObj("4", (String)map.get("endTime"), null, true));
		}else if (StringUtil.checkObj(map.get("endTime"))) {
			sql.append(" and e.dEmployDate < ?");
			list.add(StringUtil.parseObj("4", (String)map.get("endTime"), null, true));
		}else if (StringUtil.checkObj(map.get("creatTime"))) {
			sql.append(" and e.dEmployDate > ?");
			list.add(StringUtil.parseObj("7", (String)map.get("creatTime") + " 00:00:00"));
		}
		sql.append(" order by e.dEmployDate desc,e.iEmployeeId desc");
		
		
		/** PrepareStatement 传参	*/
		List list1=null;
		if(StringUtil.checkObj(pageNo) && StringUtil.checkObj(limit)){
			list1 = DatabaseUtil.queryForListByPage(sql.toString(), Integer.parseInt(pageNo), Integer.parseInt(limit), list, null);
		}else{
			list1 = DatabaseUtil.queryForList(sql.toString(), list, null);
		}
			
		return list1;
	}

	/**
	 * 新增人员信息
	 */
	public int addEmployee(List<Data> datas) {
		return DatabaseUtil.saveByDataMap(TbEmployee.cEmployeeName.getTableName(), datas, null, null);
	}

	/**
	 * 修改人员信息
	 */
	public int editEmployee(List<Data> datas) {
		return DatabaseUtil.saveByDataMap(TbEmployee.cEmployeeName.getTableName(), datas, TbEmployee.iEmployeeId.toString(), null);
	}

	/**
	 * 删除人员信息
	 */
	public int deleteEmployee(String empId) {
		String sql = "delete from tbEmployee where iEmployeeId in ("+empId+")";
		return DatabaseUtil.updateDateBase(sql,null);
	}
}
