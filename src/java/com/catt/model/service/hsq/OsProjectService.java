package com.catt.model.service.hsq;

import java.util.List;
import java.util.Map;

import pub.source.Data;

public interface OsProjectService {
	
	public List getOsProjectList(Map map);
	
	public int addOsProject(Map map);
	
	public int editOsProject(Map map);
	
	public int deleteOsProject(String proId);
}
