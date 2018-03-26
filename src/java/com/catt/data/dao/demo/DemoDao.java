package com.catt.data.dao.demo;

import java.util.List;
import java.util.Map;
import pub.source.Data;

public interface DemoDao{
	
	public List getEmployeeList(Map map);
	
	public int addEmployee(List<Data> datas);
	
	public int editEmployee(List<Data> datas);
	
	public int deleteEmployee(String empId);
}
