package util;

import java.util.List;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;

/**
 * <pre>
 * Description:
 * Author：Zhang zhongtao
 * Date：11-5-20 上午1:26
 * </pre>
 */
public class ExtendsStruts2Utils extends Struts2Utils{
    private static Logger log  = Logger.getLogger(ExtendsStruts2Utils.class);
    private static ObjectMapper mapper = new ObjectMapper();
    /***
     * Json字符串转换为单个对象
     * 1、如果json字符串包含转换目录对象没有的属性，
     *    则需要把目标对象加上@JsonIgnoreProperties(ignoreUnknown = true)注解
     *    用来告诉jackjson忽略没有对应的属性
     * @param json
     * @param clazz
     * @param <T>
     * @return
     */
    public static <T> T renderJson2Object(String json, Class clazz){
        return (T)JsonUtil.renderJson2Object(json,clazz);
    }

    /***
     * Json字符串转换为集合对象
     * 1、如果json字符串包含转换目标对象没有的属性，
     *    则需要把目标对象加上@JsonIgnoreProperties(ignoreUnknown = true)注解
     *    用来告诉jackjson忽略没有对应的属性
     * @param json json字符串
     * @param clazz list中对象类型
     * @return
     */
    public static List renderJson2List(String json,Class clazz){
        return JsonUtil.renderJson2List(json,clazz);
    }


    /**
     * 返回json给flex(json使用UTF-8)，由于公司使用的FlexViewer框架为UTF-8编码，所以提供此方法
     * @param obj
     */
    public static void renderJson2Flex(Object obj){
        renderJson(obj,"encoding:UTF-8");
    }
}
