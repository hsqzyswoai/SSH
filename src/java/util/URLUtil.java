package util;
import java.io.BufferedReader;   
import java.io.InputStreamReader;   
import java.io.UnsupportedEncodingException;   
import java.net.HttpURLConnection;   
import java.net.URL;   
import java.net.URLConnection;   
import java.net.URLDecoder;   
import java.net.URLEncoder;   
import java.util.Iterator;   
import java.util.Map;   
  
import javax.servlet.http.HttpServletRequest;   
  
/**  
 * URL����  
 * @author 
 *  
 */  
public class URLUtil {   
  
    /**  
     * ��url���б���  
     */  
    public static String encodeURL(String url) {   
        try {   
            return URLEncoder.encode(url, "UTF-8");   
        } catch (UnsupportedEncodingException e) {   
            e.printStackTrace();   
            return null;   
        }   
    }   
       
    /**  
     * ��url���н���  
     * @param url  
     * @return  
     */  
    public static String decodeURL(String url){   
        try {   
            return URLDecoder.decode(url, "UTF-8");   
        } catch (UnsupportedEncodingException e) {   
            e.printStackTrace();   
            return null;   
        }   
    }   
  
    /**  
     * �ж�URL��ַ�Ƿ����  
     * @param url  
     * @return  
     */  
    public static boolean isURLExist(String url) {   
        try {   
            URL u = new URL(url);   
            HttpURLConnection urlconn = (HttpURLConnection) u.openConnection();   
            int state = urlconn.getResponseCode();   
            if (state == 200) {   
                return true;   
            } else {   
                return false;   
            }   
        } catch (Exception e) {   
            return false;   
        }   
    }   
       
    /**  
     * �����������ԭΪkey=value����ʽ,for struts2  
     * @param params  
     * @return  
     */  
    public static String getParamString(Map<?, ?> params) {   
        StringBuffer queryString = new StringBuffer(256);   
        Iterator<?> it = params.keySet().iterator();   
        int count = 0;   
        while (it.hasNext()) {   
            String key = (String) it.next();   
            String[] param = (String[]) params.get(key);   
            for (int i = 0; i < param.length; i++) {   
                if (count == 0) {   
                    count++;   
                } else {   
                    queryString.append("&");   
                }   
                queryString.append(key);   
                queryString.append("=");   
                try {   
                    queryString.append(URLEncoder.encode((String) param[i], "UTF-8"));   
                } catch (UnsupportedEncodingException e) {   
                }   
            }   
        }   
        return queryString.toString();   
    }   
  
    /**  
     * ��������·��������  
     * @param request  
     * @return  
     */  
    public static String getRequestURL(HttpServletRequest request) {   
        StringBuffer originalURL = new StringBuffer(request.getServletPath());   
        Map<?,?> parameters = request.getParameterMap();   
        if (parameters != null && parameters.size() > 0) {   
            originalURL.append("?");   
            originalURL.append(getParamString(parameters));   
        }   
        return originalURL.toString();   
    }   
  
    /**  
     * ץȡ��ҳ����,�Զ�ʶ�����  
     * @param urlString  
     * @return  
     */  
    public static String url2Str(String urlString) {   
        try {   
            StringBuffer html = new StringBuffer();   
            URL url = new URL(urlString);   
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();   
            URLConnection c = url.openConnection();   
            c.connect();   
            String contentType = c.getContentType();   
            String characterEncoding = null;   
            int index = contentType.indexOf("charset=");   
            if(index == -1){   
                characterEncoding = "UTF-8";   
            }else{   
                characterEncoding = contentType.substring(index + 8, contentType.length());   
            }   
            InputStreamReader isr = new InputStreamReader(conn.getInputStream(), characterEncoding);   
            BufferedReader br = new BufferedReader(isr);   
            String temp;   
            while ((temp = br.readLine()) != null) {   
                html.append(temp).append("\n");   
            }   
            br.close();   
            isr.close();   
            return html.toString();   
         } catch (Exception e) {   
            e.printStackTrace();   
            return null;   
         }   
     }   
            
     public static void main(String[] args) {   
         String content = URLUtil.url2Str("http://www.baidu.com");;   
         System.out.println(content);   
     }   
} 