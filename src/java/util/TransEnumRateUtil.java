package util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import pub.source.DatabaseUtil;

/**
 * ����ö��(���T_ENUMERATE��)
 * @author qiaoqide
 * @since 2015-5-18
 *
 */
public class TransEnumRateUtil {
	
	/**
	 * ����ö�����ͺ�ö��ֵ�������Ӧ��ö���ı�
	 * @param map
	 * @return
	 */
	public static String getEnumText(String subSpec, String val){
		Map m = translateEnum(subSpec, "1");
		String text = StringUtil.toString(m.get(val));
		return text;
	}
	
	/**
	 * ����ö�����ͺ�ö���ı��������Ӧ��ö��id
	 * @param map
	 * @return
	 */
	public static String getEnumId(String subSpec, String text){
		Map m = translateEnum(subSpec, "2");
		String id = StringUtil.toString(m.get(text));
		return id;
	}
	
	/**
	 * ȡö�ٻ�򵥶����Ӧ���ı�����
	 * @param map
	 * @return
	 */
	public static Map<String, String> translateEnum(String subSpec, String transType){
		CacheUtil ch = CacheUtil.getInstance();
		String key = "jzgj_" + transType+"_" + subSpec;
		
		//�ȴӻ�����ȡ����
		Map<String, String> m = (Map<String, String>)ch.get(key);
		if(m == null || m.size() == 0){
			m = new HashMap<String, String>();
			
			//�õ����ݲ�����ֵ��
			m.put("sSubSpec", subSpec);
			List list = getEnumData(m);
			
			m.clear();
			Map<String, String> tp;
			String tpKey;
			String tpText;
			int length = list.size();
			for(int i = 0; i < length; i++){
				tp=(Map<String, String>)list.get(i);
				tpKey = tp.get("id");
				tpText = tp.get("text");
				
				if("1".equals(transType)){
					m.put(tpKey, StringUtil.checkObj(tpText) ? tpText : tpKey);
				}else{
					m.put(tpText, StringUtil.checkObj(tpKey) ? tpKey : tpText);
				}
			}
			//����
			ch.put(key, m);
		}
		return m;
	}
	
	/**
	 * ��ѯö��
	 * @param m
	 * @return
	 */
	public static List getEnumData(Map m){
		StringBuffer sb = new StringBuffer();
		String subSpec = StringUtil.toString(m.get("sSubSpec")); //רҵ����
		sb.append("select I_ENUM_VALUE as \"id\", ");
		sb.append("S_ENUM_MEANING as \"text\" from ");
		sb.append("T_ENUMERATE where S_ENUM_TYPE='").append(subSpec).append("' ");
		return DatabaseUtil.queryForList(sb.toString());
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String text = getEnumText("I_SUB_SPEC","1");
		System.out.println("text="+text);
		
		String id = getEnumId("I_SUB_SPEC","SDH");
		System.out.println("id="+id);
	}

}
