package util;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import pub.servlet.ConfigInit;
import pub.source.DatabaseUtil;

/**网管子传输列表统一，表单1.0需集成*/
public class TransEnumSubSpecUtil {
	/**是否合并传输制式*/
	private static boolean  flag = true;
	/**制式格举文本-值映射*/
	private static HashMap<String, String> subSpec = null;
	
	/**静态块*/
	static{
		flag = getisMergeFlag();
		subSpec = getSubSpecEnum();
	}
	
	/**
	 * 获取统一表名
	 * @param tableName 原始表名
	 * @return  统一表名
	 */
	public static String getSubSpecTableName(String tableName){
		if(flag){
			Iterator<String> it = subSpec.keySet().iterator();
			for(; it.hasNext();){
				String key = "_"+it.next();
				if(tableName.contains(key)){
					tableName = tableName.replace(key, "");
					break;
				}
			}
		}
		return tableName;
	}
	
	/**
	 * 获取专业条件串
	 * @param tableName 原始表名
	 * @param tableAlias 表别名 
	 * @param posisionOfAnd  加and的位置，0不加，1加前，2加后
	 * @return  统一表名
	 */
	public static String getSubSpecCondition(String tableName, String tableAlias, int posisionOfAnd){
		String cond = "";
		if(flag){
			cond =(posisionOfAnd==1?" and " : " ")
			+(StringUtil.checkStr(tableAlias)? (tableAlias+"."):"") 
			+ "I_SUB_SPEC="+getSubsepcValueByTableName(tableName)
			+(posisionOfAnd==2?"  and  ":" ");
		}
		return cond;
	}
		
	
	/**
	 * 获限是否标合并标识
	 * @return 标识
	 *  */
	private static boolean getisMergeFlag(){
		String sFlag = ConfigInit.getProperty("MERGE_TRANS_TABLE_FLAG", "1");
		int flag = Integer.valueOf(sFlag);
		return flag == 1;
	}
	
	
	/**获取制式枚举映射关系*/
	private static HashMap<String, String> getSubSpecEnum(){
		String sql = "select  I_ENUM_VALUE as \"id\",S_ENUM_MEANING as \"text\" from T_ENUMERATE where S_ENUM_TYPE='I_SUB_SPEC'";
		List enums =  DatabaseUtil.queryForList(sql);
		
		HashMap<String, String> subSpec = new HashMap<String, String>();
		int size = enums.size();
		for(int i=0; i<size; i++){
			Map<String, String> temp = (Map<String, String>)enums.get(i);
			String id = temp.get("id");
			String text = temp.get("text");
			
			subSpec.put(text, id);
		}
		return subSpec;
	}
	
	/**根据表名获取制式值*/
	private static String getSubsepcValueByTableName(String tableName){
		Iterator<String> it = subSpec.keySet().iterator();
		String value = "1";
		for(; it.hasNext();){
			String key = it.next();
			if(tableName.contains(key)){
				value = subSpec.get(key);
				break;
			}
		}
		return value;
	}
	
	/**测试**/
	public static void main(String[] args) {
		System.out.println(getSubSpecTableName("T_TRANS_NE"));
		System.out.println(getSubSpecTableName("T_TRANS_OTN_NE"));
		System.out.println(getSubSpecCondition("T_TRANS_NE","a", 1));
		System.out.println(getSubSpecCondition("T_TRANS_NE",null, 2));
		
	}
}
