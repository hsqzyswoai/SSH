package util;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import pub.servlet.ConfigInit;
import pub.source.DatabaseUtil;

/**�����Ӵ����б�ͳһ����1.0�輯��*/
public class TransEnumSubSpecUtil {
	/**�Ƿ�ϲ�������ʽ*/
	private static boolean  flag = true;
	/**��ʽ����ı�-ֵӳ��*/
	private static HashMap<String, String> subSpec = null;
	
	/**��̬��*/
	static{
		flag = getisMergeFlag();
		subSpec = getSubSpecEnum();
	}
	
	/**
	 * ��ȡͳһ����
	 * @param tableName ԭʼ����
	 * @return  ͳһ����
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
	 * ��ȡרҵ������
	 * @param tableName ԭʼ����
	 * @param tableAlias ����� 
	 * @param posisionOfAnd  ��and��λ�ã�0���ӣ�1��ǰ��2�Ӻ�
	 * @return  ͳһ����
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
	 * �����Ƿ��ϲ���ʶ
	 * @return ��ʶ
	 *  */
	private static boolean getisMergeFlag(){
		String sFlag = ConfigInit.getProperty("MERGE_TRANS_TABLE_FLAG", "1");
		int flag = Integer.valueOf(sFlag);
		return flag == 1;
	}
	
	
	/**��ȡ��ʽö��ӳ���ϵ*/
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
	
	/**���ݱ�����ȡ��ʽֵ*/
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
	
	/**����**/
	public static void main(String[] args) {
		System.out.println(getSubSpecTableName("T_TRANS_NE"));
		System.out.println(getSubSpecTableName("T_TRANS_OTN_NE"));
		System.out.println(getSubSpecCondition("T_TRANS_NE","a", 1));
		System.out.println(getSubSpecCondition("T_TRANS_NE",null, 2));
		
	}
}
