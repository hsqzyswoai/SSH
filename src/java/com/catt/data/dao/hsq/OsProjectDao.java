package com.catt.data.dao.hsq;

import java.util.List;
import java.util.Map;

import pub.source.Data;

public interface OsProjectDao {
	
	public List getOsProjectList(Map map);
	
	public int addOsProject(List<Data> datas);
	
	public int editOsProject(List<Data> datas);
	
	public int deleteOsProject(String proId);
}
