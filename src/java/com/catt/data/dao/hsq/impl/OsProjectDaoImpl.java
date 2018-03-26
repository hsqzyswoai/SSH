package com.catt.data.dao.hsq.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.catt.data.dao.hsq.OsProjectDao;

import pub.dbDialectFactory.Dialect;
import pub.dbDialectFactory.DialectFactory;
import pub.source.Data;
import pub.source.DataType;
import pub.source.DatabaseUtil;
import pub.source.hsq.TbOsProject;
import util.StringUtil;
@SuppressWarnings("serial")
@Repository("osProjectDao")
public class OsProjectDaoImpl implements OsProjectDao{
	/**
	 * 查询项目集合
	 */
	@Override
	public List getOsProjectList(Map map) {
		String pageNo = (String)map.get("pageNo");
		String limit = (String)map.get("limit");
		
		List list=new ArrayList();
		Dialect dia = DialectFactory.getDialect();
		StringBuffer sql = new StringBuffer();
		//如果是oracle库,都加个别名，并用“”号引起来
		sql.append("select o.iProjectId as \"iProjectId\",o.sProjectName \"sProjectName\",o.iPeopleCount \"iPeopleCount\",");
		sql.append("o.sPmName \"sPmName\",o.sRemark \"sRemark\",");
		sql.append(dia.datetimeTostring("o.dEndDate", "")); 
		sql.append(" \"dEndDate\",");
		sql.append(dia.datetimeTostring("o.dCreateDate", "")); 
		sql.append(" \"dCreateDate\",");
		sql.append("o.iProjectBigTypeId \"iProjectBigTypeId\",bt.sProjectBigTypeName \"sProjectBigTypeName\",");
		sql.append("o.iProjectSmallTypeId \"iProjectSmallTypeId\",st.sProjectSmallTypeName \"sProjectSmallTypeName\" ");
		sql.append(" from tbOsProject o left join TbOsProjectBigType bt on o.iProjectBigTypeId=bt.iProjectBigTypeId left join TbOsProjectSmallType st");
		sql.append(" on o.iProjectSmallTypeId=st.iProjectSmallTypeId where 1=1 ");
		
		if(StringUtil.checkObj(map.get("iProjectId"))){
			sql.append(" and o.iProjectId = ?");
			list.add(Integer.valueOf((String)map.get("iProjectId")));
		}
		if(StringUtil.checkObj(map.get("sProjectName"))){
			sql.append(" and o.sProjectName like ? ");
			list.add("%"+map.get("sProjectName")+"%");
		}
		if(StringUtil.checkObj(map.get("sName"))){
			sql.append(" and o.sProjectName like ? ");
			list.add("%"+map.get("sName")+"%");
		}
		
		if(StringUtil.checkObj(map.get("iPeopleCount"))){
			sql.append(" and o.iPeopleCount = ? ");			
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
		if (StringUtil.checkObj(map.get("sRemark"))) {
			sql.append(" and o.sRemark like ?");
			list.add("%"+map.get("sRemark")+"%");
		}
		if(StringUtil.checkObj(map.get("dCreateDate"))){
			sql.append(" and o.dCreateDate > ?");
			list.add(StringUtil.parseObj("4", (String)map.get("dCreateDate"),null, true));
		}else if (StringUtil.checkObj(map.get("dEndDate"))) {
			sql.append(" and o.dEndDate < ?");
			list.add(StringUtil.parseObj("4", (String)map.get("dEndDate"), null, true));
		}
		sql.append(" order by o.dCreateDate desc,o.iProjectId desc");
		
		
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
	 * 新增项目信息
	 */
	@Override
	public int addOsProject(List<Data> datas) {
		return DatabaseUtil.saveByDataMap(TbOsProject.sProjectName.getTableName(), datas, null, null);
	}
	/**
	 * 修改项目信息
	 */
	@Override
	public int editOsProject(List<Data> datas) {
		return DatabaseUtil.saveByDataMap(TbOsProject.sProjectName.getTableName(), datas, TbOsProject.iProjectId.toString(), null);
	}
	/**
	 * 删除项目信息
	 */
	@Override
	public int deleteOsProject(String proId) {
		String sql = "delete from tbOsProject where iProjectId in ("+proId+")";
		return DatabaseUtil.updateDateBase(sql,null);
	}

}
