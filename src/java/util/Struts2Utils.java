package util;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;


/**
 * Struts2������.
 * 
 * ʵ�ֻ�ȡRequest/Response/Session���ƹ�jsp/freemakerֱ������ı��ļ򻯺���.
 * 
 * @author ������
 */
public class Struts2Utils {

	//-- header �������� --//
	private static final String HEADER_ENCODING = "encoding";
	private static final String HEADER_NOCACHE = "no-cache";
	private static final String DEFAULT_ENCODING = "GBK";
	private static final boolean DEFAULT_NOCACHE = true;

	private static ObjectMapper mapper = new ObjectMapper();
	
	//-- ȡ��Request/Response/Session�ļ򻯺��� --//
	/**
	 * ȡ��HttpSession�ļ򻯺���.
	 */
	public static HttpSession getSession() {
		return ServletActionContext.getRequest().getSession();
	}

	/**
	 * ȡ��HttpSession�ļ򻯺���.
	 */
	public static HttpSession getSession(boolean isNew) {
		return ServletActionContext.getRequest().getSession(isNew);
	}

	/**
	 * ȡ��HttpSession��Attribute�ļ򻯺���.
	 */
	public static Object getSessionAttribute(String name) {
		HttpSession session = getSession(false);
		return (session != null ? session.getAttribute(name) : null);
	}

	/**
	 * ȡ��HttpRequest�ļ򻯺���.
	 */
	public static HttpServletRequest getRequest() {
		return ServletActionContext.getRequest();
	}

	/**
	 * ȡ��HttpRequest��Parameter�ļ򻯷���.
	 */
	public static String getParameter(String name) {
		return getRequest().getParameter(name);
	}

	/**
	 * ȡ��HttpResponse�ļ򻯺���.
	 */
	public static HttpServletResponse getResponse() {
		return ServletActionContext.getResponse();
	}

	//-- �ƹ�jsp/freemakerֱ������ı��ĺ��� --//
	/**
	 * ֱ��������ݵļ�㺯��.

	 * eg.
	 * render("text/plain", "hello", "encoding:GBK");
	 * render("text/plain", "hello", "no-cache:false");
	 * render("text/plain", "hello", "encoding:GBK", "no-cache:false");
	 * 
	 * @param headers �ɱ��header���飬Ŀǰ���ܵ�ֵΪ"encoding:"��"no-cache:",Ĭ��ֵ�ֱ�ΪUTF-8��true.
	 */
	public static void render(final String contentType, final String content, final String... headers) {
		HttpServletResponse response = initResponseHeader(contentType, headers);
		try {
			response.getWriter().write(content);
			response.getWriter().flush();
		} catch (IOException e) {
			throw new RuntimeException(e.getMessage(), e);
		}
	}

	/**
	 * ֱ������ı�.
	 * @see #render(String, String, String...)
	 */
	public static void renderText(final String text, final String... headers) {
		render(ServletUtils.TEXT_TYPE, text, headers);
	}

	/**
	 * ֱ�����HTML.
	 * @see #render(String, String, String...)
	 */
	public static void renderHtml(final String html, final String... headers) {
		render(ServletUtils.HTML_TYPE, html, headers);
	}

	/**
	 * ֱ�����XML.
	 * @see #render(String, String, String...)
	 */
	public static void renderXml(final String xml, final String... headers) {
		render(ServletUtils.XML_TYPE, xml, headers);
	}

	/**
	 * ֱ�����JSON.
	 * 
	 * @param jsonString json�ַ���.
	 * @see #render(String, String, String...)
	 */
	public static void renderJson(final String jsonString, final String... headers) {
		render(ServletUtils.JSON_TYPE, jsonString, headers);
	}

	/**
	 * ֱ�����JSON,ʹ��Jacksonת��Java����.
	 * 
	 * @param data ������List<POJO>, POJO[], POJO, Ҳ����Map��ֵ��.
	 * @see #render(String, String, String...)
	 */
	public static void renderJson(final Object data, final String... headers) {
		HttpServletResponse response = initResponseHeader(ServletUtils.JSON_TYPE, headers);
		try {
            mapper.configure(SerializationConfig.Feature.WRITE_DATES_AS_TIMESTAMPS, false);
            DateFormat myDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            mapper.getSerializationConfig().setDateFormat(myDateFormat);
            mapper.writeValue(response.getWriter(), data);
		} catch (IOException e) {
			throw new IllegalArgumentException(e);
		}
	}

	/**
	 * ֱ�����֧�ֿ���Mashup��JSONP.
	 * 
	 * @param callbackName callback������.
	 * @param object Java����,������List<POJO>, POJO[], POJO ,Ҳ����Map��ֵ��, ����ת��Ϊjson�ַ���.
	 */
	public static void renderJsonp(final String callbackName, final Object object, final String... headers) {
		String jsonString = null;
		try {
			jsonString = mapper.writeValueAsString(object);
		} catch (IOException e) {
			throw new IllegalArgumentException(e);
		}

		String result = new StringBuilder().append(callbackName).append("(").append(jsonString).append(");").toString();

		//��ȾContent-TypeΪjavascript�ķ�������,������Ϊjavascript���, ��callback197("{html:'Hello World!!!'}");
		render(ServletUtils.JS_TYPE, result, headers);
	}

	/**
	 * ����������contentType��headers.
	 */
	private static HttpServletResponse initResponseHeader(final String contentType, final String... headers) {
		//����headers����
		String encoding = DEFAULT_ENCODING;
		boolean noCache = DEFAULT_NOCACHE;
		for (String header : headers) {
			String headerName = StringUtils.substringBefore(header, ":");
			String headerValue = StringUtils.substringAfter(header, ":");

			if (StringUtils.equalsIgnoreCase(headerName, HEADER_ENCODING)) {
				encoding = headerValue;
			} else if (StringUtils.equalsIgnoreCase(headerName, HEADER_NOCACHE)) {
				noCache = Boolean.parseBoolean(headerValue);
			} else {
				throw new IllegalArgumentException(headerName + "����һ���Ϸ���header����");
			}
		}

		HttpServletResponse response = ServletActionContext.getResponse();

		//����headers����
		String fullContentType = contentType + ";charset=" + encoding;
		response.setContentType(fullContentType);
		if (noCache) {
			ServletUtils.setDisableCacheHeader(response);
		}

		return response;
	}

}
