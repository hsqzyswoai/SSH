package com.catt.model.service.hsq.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.catt.data.dao.hsq.OsProjectDao;
import com.catt.model.service.hsq.OsProjectService;

import pub.source.Data;
import pub.source.DataType;
import pub.source.DatabaseUtil;
import pub.source.TbEmployee;
import pub.source.hsq.TbOsProject;

@Service("osProjectService")
public class OsProjectServiceImpl implements OsProjectService{
	
	@Autowired
	private OsProjectDao osProjectDao;
	/*
	 * ²é
	 */
	@Override
	public List getOsProjectList(Map map) {
		return osProjectDao.getOsProjectList(map);
	}
	/*
	 * Ôö
	 */
	@Override
	public int addOsProject(Map map) {
		List<Data> datas = new ArrayList<Data>();
		
		datas.add(Data.get("iProjectId", DataType.LONG, DatabaseUtil.getKeyId(null)));
		datas.add(Data.get("iProjectBigTypeId", DataType.LONG, map.get("iProjectBigTypeId")));
		datas.add(Data.get("iProjectSmallTypeId", DataType.LONG, map.get("iProjectSmallTypeId")));
		datas.add(Data.get("sProjectName", DataType.STRING, map.get("sProjectName")));
		datas.add(Data.get("iPeopleCount", DataType.INTEGER, map.get("iPeopleCount")));
		datas.add(Data.get("dEndDate", DataType.TIME_STAMP, map.get("dEndDate")));
		datas.add(Data.get("dCreateDate", DataType.TIME_STAMP, map.get("dCreateDate")));
		datas.add(Data.get("sPmName", DataType.STRING, map.get("sPmName")));
		datas.add(Data.get("sRemark", DataType.STRING, map.get("sRemark")));
		
		return osProjectDao.addOsProject(datas);
	}
	/*
	 * ¸Ä
	 */
	@Override
	public int editOsProject(Map map) {
		List<Data> datas = new ArrayList<Data>();
		
		datas.add(Data.get(TbOsProject.iProjectId, map.get(TbOsProject.iProjectId.toString())));
		datas.add(Data.get(TbOsProject.iProjectBigTypeId, map.get(TbOsProject.iProjectBigTypeId.toString())));
		datas.add(Data.get(TbOsProject.iProjectSmallTypeId, map.get(TbOsProject.iProjectSmallTypeId.toString())));
		datas.add(Data.get(TbOsProject.sProjectName, map.get(TbOsProject.sProjectName.toString())));
		datas.add(Data.get(TbOsProject.iPeopleCount, map.get(TbOsProject.iPeopleCount.toString())));
		datas.add(Data.get(TbOsProject.dEndDate, map.get(TbOsProject.dEndDate.toString())));
		datas.add(Data.get(TbOsProject.dCreateDate, map.get(TbOsProject.dCreateDate.toString())));
		datas.add(Data.get(TbOsProject.sPmName, map.get(TbOsProject.sPmName.toString())));
		datas.add(Data.get(TbOsProject.sRemark, map.get(TbOsProject.sRemark.toString())));
		
		return osProjectDao.editOsProject(datas);
	}
	/*
	 * É¾
	 */
	@Override
	public int deleteOsProject(String proId) {
		return osProjectDao.deleteOsProject(proId);
	}
	

}
