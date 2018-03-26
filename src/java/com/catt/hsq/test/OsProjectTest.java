package com.catt.hsq.test;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.catt.model.service.hsq.OsProjectService;

import pub.source.Data;
import pub.source.DataType;
import pub.source.DatabaseUtil;
import util.JackJson;


public class OsProjectTest {
	@Test
	public void cha(){
		ApplicationContext ctx=new ClassPathXmlApplicationContext("applicationContext.xml");
		OsProjectService service= (OsProjectService) ctx.getBean("osProjectService");
		Map map=new HashMap();
		map.put("sProjectName", "123456");
		List list=service.getOsProjectList(map);
		
		for (Object object : list) {
			System.out.println(object.toString());
		}
		System.out.println(list.size());
	}
	@Test
	public void zen(){
		
		ApplicationContext ctx=new ClassPathXmlApplicationContext("applicationContext.xml");
		OsProjectService service= (OsProjectService) ctx.getBean("osProjectService");
		Map map=new HashMap();
		map.put("iProjectBigTypeId", 2);
		map.put("iProjectSmallTypeId", 6);
		map.put("sProjectName", "hsq新增数据");
		map.put("iPeopleCount", 6);
		map.put("dCreateDate", new Date());
		map.put("sRemark", "232");
		
		int i=service.addOsProject(map);
		System.out.println(i);
	}
}
