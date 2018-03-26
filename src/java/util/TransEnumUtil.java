package util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

@SuppressWarnings("unchecked")
public class TransEnumUtil {
	
	/**
	 * 翻译枚举，翻译后加上一个对应的字段(xxx_chsName)为翻译后的值
	 * @param data 数据
	 */
	public static void transEnumMeaning(List<Map> data, String tableName) {
		transEnumMeaning(data,null,tableName);
	}
	
	
	/**
	 * 翻译枚举，翻译后加上一个对应的字段(xxx_chsName)为翻译后的值
	 * @param data 数据
	 * @param keySet (可选)要翻译的字段名集合
	 */
	public static void transEnumMeaning(List<Map> data,Set keySet, String tableName) {
		try {
			if(null != data && data.size() > 0){
				Map cdata = new HashMap(data.get(0));
				Set set = cdata.keySet();
				if(null != keySet){
					set = keySet;
				}
				for (Iterator iterator = data.iterator(); iterator.hasNext();) {
					Map dataMap = (Map) iterator.next();
					for (Iterator setIter = set.iterator(); setIter.hasNext();) {
						String key = (String) setIter.next();
						if(ComminEnumUtil.containsKeyAll(tableName+"_"+key) && null != dataMap.get(key)) {
							String value = (String) ComminEnumUtil.getEnumMeaning(tableName+"_"+key, 
									dataMap.get(key).toString());//数据库中枚举为null的话，默认当为0
							dataMap.put(key + "_chsName", value);
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 翻译枚举，翻译后加上一个对应的字段(xxx_chsName)为翻译后的值
	 * @param data 要翻译的数据
	 * @param keys 枚举表对应的key
	 * @param columns 要翻译的字段
	 
	public static void transEnumMeaning(List<Map> data,String[] keys, 
			String[] columns) {
		String[] newColumns = new String[columns.length];
		for (int i = 0; i < columns.length; i++) {
			newColumns[i] = columns[i] + "_chsName";
		}
		transEnumMeaning(data,keys,columns,newColumns);
	}*/
	
	/**
	 * 翻译枚举
	 * @param data 要翻译的数据
	 * @param keys 枚举表对应的key
	 * @param columns 要翻译的字段
	 * @param newColumns 翻译后的字段名
	 
	public static void transEnumMeaning(List<Map> data,String[] keys, 
			String[] columns, String[] newColumns) {
		try {
			if(null != data && data.size() > 0){
				for (Iterator iterator = data.iterator(); iterator.hasNext();) {
					Map dataMap = (Map) iterator.next();
					for (int i = 0; i < keys.length; i++) {
						String key = keys[i];
						if(ComminEnumUtil.containsKey(key) && null != dataMap.get(columns[i])){
							String value = (String) ComminEnumUtil.getEnumMeaning(key, 
									dataMap.get(columns[i]).toString());
							dataMap.put(newColumns[i], value);
						}
					}					
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}*/
	
	/**
	 * @param args
	 */
	@SuppressWarnings("unchecked")
	public static void main(String[] args) {

		List list = new ArrayList();
		Map map = new HashMap();
		map.put("I_ASPEC", 3);
		map.put("AAAAAA", 3);
		list.add(map);
		
		
		map = new HashMap();
		map.put("I_ASPEC", 4);
		map.put("AAAAAA", 3);
		list.add(map);
		
		map = new HashMap();
		map.put("I_ASPEC", 3);
		map.put("AAAAAA", 3);
		list.add(map);
		
		map = new HashMap();
		map.put("I_ASPEC", 3);
		map.put("AAAAAA", 3);
		list.add(map);
		
		map = new HashMap();
		map.put("I_ASPEC", 3);
		map.put("AAAAAA", 44);
		list.add(map);
		
		map = new HashMap();
		map.put("I_ASPEC", 7);
		map.put("AAAAAA", 3);
		list.add(map);
		
		//TransEnumUtil.transEnumMeaning(list);
		
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Map m = (Map) iterator.next();
			System.out.println(" map data : " + m);
		}
	}

}
