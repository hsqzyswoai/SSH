package util;

import java.util.List;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;

/**
 * <pre>
 * Description:
 * Author��Zhang zhongtao
 * Date��11-5-20 ����1:26
 * </pre>
 */
public class ExtendsStruts2Utils extends Struts2Utils{
    private static Logger log  = Logger.getLogger(ExtendsStruts2Utils.class);
    private static ObjectMapper mapper = new ObjectMapper();
    /***
     * Json�ַ���ת��Ϊ��������
     * 1�����json�ַ�������ת��Ŀ¼����û�е����ԣ�
     *    ����Ҫ��Ŀ��������@JsonIgnoreProperties(ignoreUnknown = true)ע��
     *    ��������jackjson����û�ж�Ӧ������
     * @param json
     * @param clazz
     * @param <T>
     * @return
     */
    public static <T> T renderJson2Object(String json, Class clazz){
        return (T)JsonUtil.renderJson2Object(json,clazz);
    }

    /***
     * Json�ַ���ת��Ϊ���϶���
     * 1�����json�ַ�������ת��Ŀ�����û�е����ԣ�
     *    ����Ҫ��Ŀ��������@JsonIgnoreProperties(ignoreUnknown = true)ע��
     *    ��������jackjson����û�ж�Ӧ������
     * @param json json�ַ���
     * @param clazz list�ж�������
     * @return
     */
    public static List renderJson2List(String json,Class clazz){
        return JsonUtil.renderJson2List(json,clazz);
    }


    /**
     * ����json��flex(jsonʹ��UTF-8)�����ڹ�˾ʹ�õ�FlexViewer���ΪUTF-8���룬�����ṩ�˷���
     * @param obj
     */
    public static void renderJson2Flex(Object obj){
        renderJson(obj,"encoding:UTF-8");
    }
}
