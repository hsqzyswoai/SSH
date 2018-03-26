package util;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.apache.commons.beanutils.BeanUtils;

public class MapToBean {

	private List<Method> setMethods;
	private List<String> Fields;
	
	/**
	 * @param m
	 * @param o�� bean ������Ա���ȫ����String����
	 */
	public void mapToBean(Map m, Object o) {
		if (setMethods == null) {
			// �����Ӧ��ϵ
			setMethods = new ArrayList<Method>();
			Fields = new ArrayList<String>();

			// ��ȡ���з���
			java.lang.reflect.Method[] ms = o.getClass().getMethods();

			for (Method method : ms) {
				// ��������set����
				String methodName = method.getName();
				if (methodName.startsWith("set")) {
					// ����set������ȡ��������
					StringBuffer fieldName = new StringBuffer(methodName.substring(3));
					Object value = m.get(fieldName);
					if (value == null) {
						char ch = fieldName.charAt(0);
						// ת����һ���ַ��Ĵ�Сд
						ch = (char) (ch >= 'A' && ch <= 'Z' ? ch + 32 : ch - 32);
						fieldName.setCharAt(0, ch);
						value = m.get(fieldName.toString());
						
						if (value == null) {
							value = m.get(fieldName.toString().toUpperCase());
						}
					}
					if (value != null) {
						try {
							// �����Ӧ��ϵ
							setMethods.add(method);
							Fields.add(fieldName.toString());
							method.invoke(o, new Object[] { value.toString() });
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
			}
		} else {
			// ֱ�Ӵӻ���ȡ
			for (int i = 0; i < setMethods.size(); i++) {
				Method mt = setMethods.get(i);
				String fieldName = Fields.get(i);
				Object value = m.get(fieldName);
				if (value == null)
					value = m.get(fieldName.toUpperCase());
				if (value != null) {
					try {
						mt.invoke(o, new Object[] { value.toString() });
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
	
	public static void mapToObj(Object obj, Map map) throws IllegalAccessException, InvocationTargetException {
		BeanUtils.populate(obj, map);
	}

	public static void main(String[] args) throws IllegalAccessException, InvocationTargetException {

	}
}