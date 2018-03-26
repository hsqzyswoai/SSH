package util;
import java.util.regex.Matcher;   
import java.util.regex.Pattern;   
  
/**  
 * HTML����  
 * @author
 *  
 */  
public class HTMLUtil {   
  
    //>   
    public static final String GT = "&gt;";   
    //<   
    public static final String LT = "&lt;";   
    //"   
    public static final String QUOT = "&quot;";   
    //&   
    public static final String AMP = "&amp;";   
    //�ո�   
    public static final String SPACE = "&nbsp;";   
    //?   
    public static final String COPYRIGHT = "&copy;";   
    //?   
    public static final String REG = "&reg;";   
    //?   
    public static final String TM = "&trade;";   
    //��   
    public static final String RMB = "&yen;";   
       
       
    /**  
     * ɾ��script��ǩ  
     * @param str  
     * @return  
     */  
    public static String delScriptTag(String str){   
        String regEx_script = "<script[^>]*?>[\\s\\S]*?<\\/script>";   
        Pattern p_script = Pattern.compile(regEx_script,Pattern.CASE_INSENSITIVE);   
        Matcher m_script = p_script.matcher(str);    
        str = m_script.replaceAll("");   
        return str.trim();   
    }   
  
    /**  
     * ɾ��style��ǩ  
     * @param str  
     * @return  
     */  
    public static String delStyleTag(String str){   
        String regEx_style="<style[^>]*?>[\\s\\S]*?<\\/style>";   
        Pattern p_style = Pattern.compile(regEx_style,Pattern.CASE_INSENSITIVE);    
        Matcher m_style = p_style.matcher(str);    
        str = m_style.replaceAll("");   
        return str;   
    }   
       
    /**  
     * ɾ��HTML��ǩ  
     * @param str  
     * @return  
     */  
    public static String delHTMLTag(String str){   
        String regEx_html = "<[^>]+>";    
        Pattern p_html = Pattern.compile(regEx_html,Pattern.CASE_INSENSITIVE);    
        Matcher m_html = p_html.matcher(str);    
        str = m_html.replaceAll("");   
        return str;   
    }   
       
    /**  
     * ɾ�����б�ǩ  
     * @param str  
     * @return  
     */  
    public static String delAllTag(String str){    
        //ɾscript   
        str = delScriptTag(str);   
        //ɾstyle   
        str = delStyleTag(str);   
        //ɾHTML   
        str = delHTMLTag(str);   
        return str;   
    }   
       
    /**  
     * �����ǩ,�ָ�HTMLת���ַ�  
     * @param str  
     * @return  
     */  
    public static String clean(String str){   
        str = delAllTag(str);   
        str = str.replaceAll(SPACE, " ");   
        str = str.replaceAll(GT, ">");   
        str = str.replaceAll(LT, "<");   
        str = str.replaceAll(QUOT, "\"");   
        str = str.replaceAll(AMP, "&");   
        str = str.replaceAll(COPYRIGHT, "?");   
        str = str.replaceAll(REG,"?");   
        str = str.replaceAll(TM,"?");   
        str = str.replaceAll(RMB,"��");   
        return str;   
    }   
       
    /**  
     * ����ָ����ǩ  
     * @param str  
     * @param tag  
     *            ָ����ǩ  
     * @return String  
     */  
    public static String fiterHtmlTag(String str, String tag) {   
        String regxp = "<\\s*" + tag + "\\s+([^>]*)\\s*>";   
        Pattern pattern = Pattern.compile(regxp);   
        Matcher matcher = pattern.matcher(str);   
        StringBuffer sb = new StringBuffer();   
        boolean result1 = matcher.find();   
        while (result1) {   
            matcher.appendReplacement(sb, "");   
            result1 = matcher.find();   
        }   
        matcher.appendTail(sb);   
        return sb.toString();   
    }   
  
    /**  
     * �滻ָ���ı�ǩ  
     * @param str  
     * @param beforeTag  
     *            Ҫ�滻�ı�ǩ  
     * @param tagAttrib  
     *            Ҫ�滻�ı�ǩ����ֵ  
     * @param startTag  
     *            �±�ǩ��ʼ���  
     * @param endTag  
     *            �±�ǩ�������  
     * @return String  
     * example: �滻img��ǩ��src����ֵΪ[img]����ֵ[/img]  
     */  
    public static String replaceHtmlTag(String str, String beforeTag,   
            String tagAttrib, String startTag, String endTag) {   
        String regxpForTag = "<\\s*" + beforeTag + "\\s+([^>]*)\\s*>";   
        String regxpForTagAttrib = tagAttrib + "=\"([^\"]+)\"";   
        Pattern patternForTag = Pattern.compile(regxpForTag);   
        Pattern patternForAttrib = Pattern.compile(regxpForTagAttrib);   
        Matcher matcherForTag = patternForTag.matcher(str);   
        StringBuffer sb = new StringBuffer();   
        boolean result = matcherForTag.find();   
        while (result) {   
            StringBuffer sbreplace = new StringBuffer();   
            Matcher matcherForAttrib = patternForAttrib.matcher(matcherForTag   
                    .group(1));   
            if (matcherForAttrib.find()) {   
                matcherForAttrib.appendReplacement(sbreplace, startTag   
                        + matcherForAttrib.group(1) + endTag);   
            }   
            matcherForTag.appendReplacement(sb, sbreplace.toString());   
            result = matcherForTag.find();   
        }   
        matcherForTag.appendTail(sb);   
        return sb.toString();   
    }   
  
    public static void main(String[] args) {   
        System.out.println(clean(URLUtil.url2Str("http://www.baidu.com")));   
    }   
       
} 