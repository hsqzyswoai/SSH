package util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.io.StringReader;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jdom.Element;
import org.jdom.input.SAXBuilder;
import org.xml.sax.InputSource;

import pub.servlet.ConfigInit;
import pub.source.DatabaseUtil;

/**
 * ��Ȩ�ļ��ӽ���
 * @author qiaoqide
 * @date 2012-08-30
 *
 */
public class LicenseUtil {
	/**license�ļ�·��*/
	private static String licensePath="";
	/**������������*/
	private static String bfNum;
	/**��ǰ��������*/
	public static int number=1;
	
	/**
	 * ����license��Ȩ�ļ�
	 * @param map
	 * @return
	 */
	public static int createLicenseDoc(Map map){
		int flag=0;
		RandomAccessFile mm=null;
		try {
			String path=map.get("systemPath").toString()+map.get("fileName").toString();
		    File file = new File(path); 
		    if(!file.exists()){
		    	//new File(file.getParent()).mkdir();
		    	file.createNewFile();
		    }
		    StringBuffer sb=new StringBuffer();
		    String sn = map.get("sHardwareSn").toString();
		    StringBuffer hardSn=new StringBuffer();
		    //�������к�֮���"-"
			for(String str : sn.split("-")) {
				  hardSn.append(str);
			}
			sb.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
			sb.append("<root>");
			sb.append("<cusName>"+StringUtil.toString(map.get("sCusName"))+"</cusName>");
			sb.append("<systemName>"+StringUtil.toString(map.get("sSystemName"))+"</systemName>");
			sb.append("<hardwareSn>"+hardSn.toString()+"</hardwareSn>");
			sb.append("<sourceChName>"+StringUtil.toString(map.get("sSourceChName"))+"</sourceChName>");
			sb.append("<tableName>"+StringUtil.toString(map.get("sTableName"))+"</tableName>");
			sb.append("<licenseNum>"+StringUtil.toString(map.get("iLicenseNum"))+"</licenseNum>");
			sb.append("<onLineNum>"+StringUtil.toString(map.get("iOnlineNum"))+"</onLineNum>");//��������
			sb.append("<bfNum>"+StringUtil.toString(map.get("iBfNum"))+"</bfNum>");//��������
			sb.append("<cpuCore>"+StringUtil.toString(map.get("iCpuCore"))+"</cpuCore>");//cpu����/����
			sb.append("<versionType>"+StringUtil.toString(map.get("iVersionType"))+"</versionType>");
			sb.append("<versionNum>"+StringUtil.toString(map.get("sVersionNum"))+"</versionNum>");
			sb.append("<licType>"+StringUtil.toString(map.get("iDateType"))+"</licType>");
			sb.append("<endDate>"+StringUtil.toString(map.get("dEndDate"))+"</endDate>");
			sb.append("</root>");
		    mm = new RandomAccessFile(file, "rw");//�ļ�ģʽΪ��д
		    byte []key=getKeyBytes(hardSn.toString());//�����к���Ϊ��Կ
		    String md5Str=MD5Tool.HexEncode(sb.toString());//md5����
		    //byte []str=DESTool.encryptMode(key, md5Str.getBytes("UTF-8"));//des����
		    byte []str=DESTool.encrypt(key, md5Str).getBytes();//des����
		    String hexStr=parseByte2HexStr(str);//�����ܺ�Ľ��ת����ʮ������
		    mm.writeBytes(hexStr); //���õ���ʮ������д���ļ���
		    flag=1;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			flag=0;
		}finally{
			if(mm!=null){
				try {
					mm.close();
				} catch (IOException e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				
			}
		}
		return flag;
	}
	
	/**
	 * ����ע���ļ�
	 * @param map
	 * @return
	 */
	public static int createRegisterDoc(Map map){
		int flag=0;
		RandomAccessFile mm=null;
		try {
			String path=map.get("systemPath").toString()+map.get("fileName").toString();
		    File file = new File(path); 
		    if(!file.exists()){
		    	file.createNewFile();
		    }
		    StringBuffer sb=new StringBuffer();
		    String sn = map.get("sHardwareSn").toString();
		    StringBuffer hardSn=new StringBuffer();
		    //�������к�֮���"-"
			for(String str : sn.split("-")) {
				  hardSn.append(str);
			}
			sb.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
			sb.append("<root>");
			sb.append("<cusName>"+StringUtil.toString(map.get("sCusName"))+"</cusName>");
			sb.append("<linkName>"+StringUtil.toString(map.get("sLinkName"))+"</linkName>");
			sb.append("<telNum>"+StringUtil.toString(map.get("sTelNum"))+"</telNum>");
			sb.append("<email>"+StringUtil.toString(map.get("sEmail"))+"</email>");
			sb.append("<systemName>"+StringUtil.toString(map.get("sSystemName"))+"</systemName>");
			sb.append("<hardwareSn>"+map.get("sHardwareSn").toString()+"</hardwareSn>");
			sb.append("<diskSn>"+StringUtil.toString(map.get("sDiskSn"))+"</diskSn>");
			sb.append("<cpuSn>"+StringUtil.toString(map.get("sCpuSn"))+"</cpuSn>");
			sb.append("<systemVer>"+StringUtil.toString(map.get("sSystemVer"))+"</systemVer>");
			sb.append("</root>");
		    mm = new RandomAccessFile(file, "rw");//�ļ�ģʽΪ��д
		    byte []key=getKeyBytes("cattsoftware");//��Կ
		    //byte []str=DESTool.encryptMode(key, sb.toString().getBytes("UTF-8"));//����
		    byte []str=DESTool.encrypt(key, sb.toString()).getBytes();//����
		    String hexStr=parseByte2HexStr(str);//�����ܺ�Ľ��ת����ʮ������
		    mm.writeBytes(hexStr); //���ĵ���ʮ������д���ļ���
		    flag=1;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			flag=0;
		}finally{
			if(mm!=null){
				try {
					mm.close();
				} catch (IOException e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				
			}
		}
		return flag;
	}
	
	/**
	 * ���ܷ���˵����ע���ļ�,���ļ���������json�ĸ�ʽ����
	 * @return
	 */
	public static String resolveRegisterDoc(Map map){
		String json="";
		try {
			String licStr=readRegisterDoc(map);
    		//������Ȩ����
    		StringReader read = new StringReader(licStr);
    		InputSource source = new InputSource(read);
    		SAXBuilder sb = new SAXBuilder();
            //ͨ������Դ����һ��Document
    		org.jdom.Document doc = sb.build(source);
            org.jdom.Element root = doc.getRootElement();
            List jiedian = root.getChildren();
            Element et = null;
            Map<String,String> mp=new HashMap<String,String>();
            int size = jiedian.size();
            for(int i=0; i<size; i++){
            	 et = (Element) jiedian.get(i);//ѭ�����εõ���Ԫ��
            	 mp.put(et.getName(), et.getText());
            }
            json="{\"sCusName\":\""+StringUtil.toString(mp.get("cusName"))+"\",\"sLinkName\":\""+StringUtil.toString(mp.get("linkName"))+"\","+
            "\"sTelNum\":\""+StringUtil.toString(mp.get("telNum"))+"\",\"sEmail\":\""+StringUtil.toString(mp.get("email"))+"\","+
            "\"sSysName\":\""+StringUtil.toString(mp.get("systemName"))+"\",\"sHardwareSn\":\""+StringUtil.toString(mp.get("hardwareSn"))+"\","+
            "\"sDiskSn\":\""+StringUtil.toString(mp.get("diskSn"))+"\",\"sCpuSn\":\""+StringUtil.toString(mp.get("cpuSn"))+"\"," +
            "\"sSysVer\":\""+StringUtil.toString(mp.get("systemVer"))+"\"}";
		} catch (Exception e) {
			return "{\"error\":\"�뵼����ȷ��ע���ļ�!\"}";
		}
        return json;
	}
	
	/**
	 * ��ȡ�ļ����ݲ�����,map��key������fileObj
	 * @return
	 * @author qiaoqide
	 */
    private static String readRegisterDoc(Map map){
        String read="";
        FileReader fileread=null;
        BufferedReader bufread=null;
        String readStr="";
        String result="";
        try {
		    //File file = new File(map.get("systemPath").toString()+map.get("fileName").toString()); 
		    File file= (File)map.get("fileObj");
            fileread = new FileReader(file);
            bufread = new BufferedReader(fileread);
            try {
                while ((read = bufread.readLine()) != null) {
                    readStr = readStr + read;
                }
                bufread.close();
                fileread.close();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
		    byte []key=getKeyBytes("cattsoftware");
		    byte []byteStr=parseHexStr2Byte(readStr);//��ʮ������ת���ɶ������ı�
		    byte []str=DESTool.decrypt(key, new String(byteStr)).getBytes();//�ٽ������ƽ���
		    result = new String(str);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
	/**
	 * �������ð�license��Ȩ�ļ�
	 * @param map
	 * @return
	 */
	public static int createTrialVersionLicense(Map map){
		int flag=0;
		String systemName=ConfigInit.Config.getProperty("SYSTEM_NAME");
		RandomAccessFile mm=null;
		try {
			String path=map.get("systemPath").toString();
		    File file = new File(path); 
		    if(!file.exists()){
		    	file.createNewFile();
		    }
		    StringBuffer sb=new StringBuffer();
		    String sn = map.get("sHardwareSn").toString();
		    StringBuffer hardSn=new StringBuffer();
		    //�������к�֮���"-"
			for(String str : sn.split("-")) {
				  hardSn.append(str);
			}
			Calendar c = Calendar.getInstance();
			c.add(Calendar.DAY_OF_MONTH, 15);
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			sb.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
			sb.append("<root>");
			sb.append("<cusName>����</cusName>");
			sb.append("<systemName>"+systemName+"</systemName>");
			sb.append("<hardwareSn>"+hardSn.toString()+"</hardwareSn>");
			sb.append("<sourceChName>�û���</sourceChName>");
			sb.append("<tableName>tbOsStaff</tableName>");
			sb.append("<licenseNum>2000</licenseNum>");
			sb.append("<onLineNum>4000</onLineNum>");
			sb.append("<bfNum>4</bfNum>");
			sb.append("<cpuCore>2</cpuCore>");//cpu����/����
			sb.append("<versionType>0</versionType>");
			sb.append("<versionNum>1.0</versionNum>");
			sb.append("<licType>1</licType>");
			sb.append("<endDate>"+sdf.format(c.getTime())+"</endDate>");
			sb.append("</root>");
		    mm = new RandomAccessFile(file, "rw");//�ļ�ģʽΪ��д
		    byte []key=getKeyBytes(hardSn.toString());//�����к���Ϊ��Կ
		    String md5Str=MD5Tool.HexEncode(sb.toString());//md5����
		    //byte []str=DESTool.encryptMode(key, md5Str.getBytes("UTF-8"));//����
		    String n = DESTool.encrypt(key, md5Str);
		    byte[] str = DESTool.encrypt(key, md5Str).getBytes();
		    String hexStr=parseByte2HexStr(str);//�����ܺ�Ľ��ת����ʮ������
		    mm.writeBytes(hexStr); //���ĵ���ʮ������д���ļ���
		    flag=1;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			flag=0;
		}finally{
			if(mm!=null){
				try {
					mm.close();
				} catch (IOException e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				
			}
		}
		return flag;
	}
    
	/**
	 * ��ȡ��Դ����
	 * @param map
	 * @return
	 */
	public static int getSourceCount(Map map) {
		int count=0;
		try {
			String sql="select count(*)as \"iStaffId\" from "+map.get("sTableName");
			List l=DatabaseUtil.queryForList(sql);
			if(l!=null&&l.size()>0){
				Map mp=(Map)l.get(0);
				count=Integer.parseInt(StringUtil.toString(mp.get("iStaffId")));
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return count;
	}
	
	/**
	 * ��ȡ��ǰ��������
	 * @param map
	 * @return
	 */
	public static int getOnLineCount() {
		int count=0;
		try {
			String sql="select count(*) as \"onLineNum\" from tbLoginLog where dLoginOutTime is null";
			List l=DatabaseUtil.queryForList(sql);
			if(l!=null&&l.size()>0){
				Map mp=(Map)l.get(0);
				count=Integer.parseInt(StringUtil.toString(mp.get("onLineNum")));
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return count;
	}
	
    
	/**
	 * ��ȡ��Կ
	 * @param seq
	 * @return
	 */
	private static byte[] getKeyBytes(String seq) throws Exception {
		String sequence = DESTool.confusion(seq);
		final byte[] keyBytes;
		if (sequence.length() >= 24) {
			keyBytes = sequence.substring(0, 24).getBytes("UTF-8");
		} else {
			for (int i = sequence.length();i <= 24;i++) {
				sequence+="0";
			}
			keyBytes = sequence.getBytes("UTF-8");
		}
		return keyBytes;
	}
	
	/**
	 * ��������ת����ʮ������
	 * @param buf
	 * @return
	 */
	public static String parseByte2HexStr(byte buf[]) {  
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < buf.length; i++) {  
                String hex = Integer.toHexString(buf[i] & 0xFF);  
                if (hex.length() == 1) {  
                        hex = '0' + hex;  
                }  
                sb.append(hex.toUpperCase());  
        }  
        return sb.toString();
	}
	
	/**
	 * ��ʮ������ת���ɶ�����
	 * @param hexStr
	 * @return
	 * @author qiaoqide
	 */
	public static byte[] parseHexStr2Byte(String hexStr) {  
        if (hexStr.length() < 1)  
                return null;  
        byte[] result = new byte[hexStr.length()/2];  
        for (int i = 0;i< hexStr.length()/2; i++) {  
                int high = Integer.parseInt(hexStr.substring(i*2, i*2+1), 16);  
                int low = Integer.parseInt(hexStr.substring(i*2+1, i*2+2), 16);  
                result[i] = (byte) (high * 16 + low);  
        }  
        return result;
	}
	
	/**
	 * ɾ���ļ�
	 * @param map
	 * @return
	 */
	public static int deleteFile(Map map){
		int flag=0;
		try {
			String path=map.get("systemPath").toString()+map.get("fileName").toString();
		    File file = new File(path); 
		    if(file.exists()){
		    	file.delete();
		    }
		    flag=1;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return flag;
	}
	
	/**
	 * �ϴ��ļ�
	 * @param map
	 * @return
	 */
	public static String uploadFile(Map map){
		FileOutputStream fos=null;
		FileInputStream fis=null;
		String msg="";
		try {
			File myFile=(File)map.get("fileObj");
			if(myFile==null){
				msg="û���ļ�";
			}
			fos = new FileOutputStream(map.get("systemPath").toString() + map.get("fileName").toString());
			fis = new FileInputStream(myFile);
			byte[] buffer = new byte[1024];
			int length = 0;
			while ((length = fis.read(buffer)) > 0) {
				fos.write(buffer, 0, length);
			}
			msg="����ɹ�";
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			msg="����ʧ��";
		}finally{
			try {
				if(fis!=null){
					fis.close();
				}
				if(fos!=null){
					fos.close();
				}
			} catch (IOException e) {
				// TODO: handle exception
			}

		}
		return msg;
	}
	
	/**
	 * ��ȡ��Ȩ�ļ����ݲ�����
	 * @return
	 * @author qiaoqide
	 */
    public static String readLicenseDoc(String serialNo, String filePath){
        String read;
        FileReader fileread=null;
        BufferedReader bufread=null;
        String readStr="";
        String result="";
        try {
		    File file = new File(filePath);
		    if(file.exists()){
	            fileread = new FileReader(file);
	            bufread = new BufferedReader(fileread);
	            try {
	                while ((read = bufread.readLine()) != null) {
	                    readStr = readStr + read;
	                }
	                bufread.close();
	                fileread.close();
	            } catch (IOException e) {
	                e.printStackTrace();
	            }
			    byte []key=getKeyBytes(serialNo);
			    byte []byteStr=parseHexStr2Byte(readStr);//��ʮ������ת���ɶ������ı�
			    String n = new String(byteStr);
			    //byte []str=DESTool.decryptMode(key, byteStr);//��������������des����
			    byte []str = DESTool.decrypt(key, new String(byteStr)).getBytes();//��������������des����
			    result = MD5Tool.HexDecode(new String(str));//��MD5����
			    //System.out.println("���ܺ��ļ�������:"+ "\r\n" + result);
		    }
        } catch (Exception e) {
        	result="";
            e.printStackTrace();
        }
        return result;
    }
    
	/**
	 * ��ȡ������ ��OprationInterceptor.java����
	 * @param request
	 * @return
	 */
	public static String getBfNum(HttpServletRequest request) {
		try {
			if(licensePath.equals("")){
				licensePath = RequestUtil.getRealPath(request) + "WEB-INF/classes/license.lic";//��Ȩ�ļ�·��
				String SerialNo=SystemUtil.getHDSerialNo()+SystemUtil.getCPUSerialNo();//��ȡӲ����cpu���к�
				String licStr=readLicenseDoc(MD5Tool.HexEncode(SerialNo), licensePath);
				//������Ȩ����
				StringReader read = new StringReader(licStr);
				InputSource source = new InputSource(read);
				SAXBuilder sb = new SAXBuilder();
	            //ͨ������Դ����һ��Document
				org.jdom.Document doc = sb.build(source);
	            org.jdom.Element root = doc.getRootElement();
	            //��ȡ��������
	            org.jdom.Element bfNumNode=root.getChild("bfNum");//cpu����/����
	            if(StringUtil.checkStr(bfNumNode.getText())){//�ж��Ƿ������˲�������
	            	bfNum=bfNumNode.getText();
	            }
			}
		} catch (Exception e) {
			// TODO: handle exception
			bfNum="";
		}
		return bfNum;
	}
	
	/**
	 * Ӧ�ö˲鿴��Ȩ��Ϣ
	 * @return
	 */
	public static String getLicenseInfo(Map map){
		String json="";
		String SerialNo=SystemUtil.getHDSerialNo()+SystemUtil.getCPUSerialNo();
		String filePath=map.get("filePath").toString();//��Ȩ�ļ�·��
		String licStr=readLicenseDoc(MD5Tool.HexEncode(SerialNo), filePath);
		try {
			//������Ȩ����
			StringReader read = new StringReader(licStr);
			InputSource source = new InputSource(read);
			SAXBuilder sb = new SAXBuilder();
	        //ͨ������Դ����һ��Document
			org.jdom.Document doc = sb.build(source);
	        org.jdom.Element root = doc.getRootElement();
	        org.jdom.Element sysNameNode=root.getChild("systemName");//ϵͳ����
	        org.jdom.Element cusNameNode=root.getChild("cusName");//�ͻ�����
	        org.jdom.Element licTypeNode=root.getChild("licType");//��Ȩ���� 1��ͨ��Ȩ 2������Ȩ
	        org.jdom.Element versionTypeNode=root.getChild("versionType");//�汾���� 1��ʽ��/0���ð�
	        org.jdom.Element bfNumNode=root.getChild("bfNum");//���Ʋ�������
	        org.jdom.Element cpuCoreNode=root.getChild("cpuCore");//cpu����/����
	        org.jdom.Element onLineNumNode=root.getChild("onLineNum");//��ͬʱ��������
	        org.jdom.Element versionNumNode=root.getChild("versionNum");//�汾��
	        org.jdom.Element endDateNode=root.getChild("endDate");//����ʱ��
	        org.jdom.Element sourceChNameNode=root.getChild("sourceChName");//ҵ���������
	        org.jdom.Element tableNameNode=root.getChild("tableName");//ҵ�����
	        org.jdom.Element licenseNumNode=root.getChild("licenseNum");//ҵ�������������
	        json+="{\"ssysName\":\""+sysNameNode.getText()+"\","+
	        "\"idateType\":\""+licTypeNode.getText()+"\","+
	        "\"scusName\":\""+cusNameNode.getText()+"\","+
	        "\"sversionType\":\""+versionTypeNode.getText()+"\","+
	        "\"ibfNum\":\""+bfNumNode.getText()+"\","+
	        "\"icpuCore\":\""+cpuCoreNode.getText()+"\","+
	        "\"ionlineNum\":\""+onLineNumNode.getText()+"\","+
	        "\"sversionNum\":\""+versionNumNode.getText()+"\","+
	        "\"sSourceChName\":\""+sourceChNameNode.getText()+"\","+
	        "\"stableName\":\""+tableNameNode.getText()+"\","+
	        "\"ilicenseNum\":\""+licenseNumNode.getText()+"\","+
	        "\"dendDate\":\""+endDateNode.getText()+"\"}";
		} catch (Exception e) {
			// TODO: handle exception
		}
        return json;
	}
	
	/**
	 * Ӧ�ö˲鿴��Ȩ��Ϣ,��jspҳ�����
	 * @return
	 */
	public static List getLicenseInfoByPage(Map map){
		String json=getLicenseInfo(map);
		List jsonList = JackJson.getListByJsonArray("["+json+"]");
		return jsonList;
	}
	
	/**
	 * �Ƿ��ڲ�����Χ��
	 * @param request
	 * @param response
	 * @return
	 */
	public static boolean isPassRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		boolean flag=true;
		bfNum=getBfNum(request);//��ȡ��������
		if(!bfNum.equals("")){
			if(number>Integer.parseInt(bfNum)){
				if(isAjaxRequest(request)){
					response.setStatus(8888);
					flag=false;
				}else{
					request.setAttribute("err", "��ǰ�û�������������,���Ժ�����!");
					request.getRequestDispatcher(request.getContextPath()+"/error.jsp").forward(request, response);
					flag=false;
				}
			}
			if(flag)number++;//ͳ����������
		}
		return flag;
	}
	
	public static void minRequestNum(){
		number--;
	}
	
	//���jquery��ajax����
	private static boolean isAjaxRequest(HttpServletRequest request) {
		String header = request.getHeader("X-Requested-With");
		return (header != null && "XMLHttpRequest".equals(header));
	}
	
	/**
	 * license���ð���Ȩ���ɺ������ı��ʾ
	 * @param filePath
	 * @return
	 */
	public static boolean changeLicenseFlag(String filePath){
		boolean flag=true;
		RandomAccessFile mm=null;
		try {
		    File file = new File(filePath+"WEB-INF/classes/license.properties"); 
		    if(!file.exists()){
		    	//file.createNewFile();
		    	return false;
		    }
		    mm = new RandomAccessFile(file, "rw");//�ļ�ģʽΪ��д
		    mm.writeBytes(MD5Tool.HexEncode("false")); //������ͬ���Ŀ�ʼʱ�䱣�浽�ļ�
		    flag=false;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			flag=false;
		}finally{
			if(mm!=null){
				try {
					mm.close();
				} catch (IOException e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				
			}
		}
		return flag;
	}
	
	/**
	 * ��ȡlicense���ð��ʾ,�ж��Ƿ��ǵ�һ�����ɵ�license
	 * @return
	 * @author qiaoqide
	 */
    public static boolean readLicenseFlag(String filePath){
    	boolean flag=false;
        String read="";
        FileReader fileread=null;
        BufferedReader bufread=null;
        String readStr="";
        try {
		    File file = new File(filePath+"WEB-INF/classes/license.properties");
		    if(file.exists()){
	            fileread = new FileReader(file);
	            bufread = new BufferedReader(fileread);
	            try {
	                while ((read = bufread.readLine()) != null) {
	                    readStr = readStr + read;
	                }
	                bufread.close();
	                fileread.close();
	                if(MD5Tool.HexDecode(readStr).equals("true"))
	                	flag=true;
	            } catch (IOException e) {
	                // TODO Auto-generated catch block
	                e.printStackTrace();
	            }
		    }else{
		    	flag=false;
		    }
        } catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
        	flag=false;
            e.printStackTrace();
        }
        return flag;
    }

}
