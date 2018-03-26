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
 * 授权文件加解密
 * @author qiaoqide
 * @date 2012-08-30
 *
 */
public class LicenseUtil {
	/**license文件路径*/
	private static String licensePath="";
	/**并发数量上限*/
	private static String bfNum;
	/**当前并发数量*/
	public static int number=1;
	
	/**
	 * 创建license授权文件
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
		    //处理序列号之间的"-"
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
			sb.append("<onLineNum>"+StringUtil.toString(map.get("iOnlineNum"))+"</onLineNum>");//在线人数
			sb.append("<bfNum>"+StringUtil.toString(map.get("iBfNum"))+"</bfNum>");//并发数量
			sb.append("<cpuCore>"+StringUtil.toString(map.get("iCpuCore"))+"</cpuCore>");//cpu个数/核数
			sb.append("<versionType>"+StringUtil.toString(map.get("iVersionType"))+"</versionType>");
			sb.append("<versionNum>"+StringUtil.toString(map.get("sVersionNum"))+"</versionNum>");
			sb.append("<licType>"+StringUtil.toString(map.get("iDateType"))+"</licType>");
			sb.append("<endDate>"+StringUtil.toString(map.get("dEndDate"))+"</endDate>");
			sb.append("</root>");
		    mm = new RandomAccessFile(file, "rw");//文件模式为读写
		    byte []key=getKeyBytes(hardSn.toString());//将序列号作为密钥
		    String md5Str=MD5Tool.HexEncode(sb.toString());//md5加密
		    //byte []str=DESTool.encryptMode(key, md5Str.getBytes("UTF-8"));//des加密
		    byte []str=DESTool.encrypt(key, md5Str).getBytes();//des加密
		    String hexStr=parseByte2HexStr(str);//将加密后的结果转换成十六进制
		    mm.writeBytes(hexStr); //将得到的十六进制写入文件中
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
	 * 创建注册文件
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
		    //处理序列号之间的"-"
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
		    mm = new RandomAccessFile(file, "rw");//文件模式为读写
		    byte []key=getKeyBytes("cattsoftware");//密钥
		    //byte []str=DESTool.encryptMode(key, sb.toString().getBytes("UTF-8"));//加密
		    byte []str=DESTool.encrypt(key, sb.toString()).getBytes();//加密
		    String hexStr=parseByte2HexStr(str);//将加密后的结果转换成十六进制
		    mm.writeBytes(hexStr); //将的到的十六进制写入文件中
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
	 * 解密服务端导入的注册文件,将文件的内容以json的格式返回
	 * @return
	 */
	public static String resolveRegisterDoc(Map map){
		String json="";
		try {
			String licStr=readRegisterDoc(map);
    		//解析授权内容
    		StringReader read = new StringReader(licStr);
    		InputSource source = new InputSource(read);
    		SAXBuilder sb = new SAXBuilder();
            //通过输入源构造一个Document
    		org.jdom.Document doc = sb.build(source);
            org.jdom.Element root = doc.getRootElement();
            List jiedian = root.getChildren();
            Element et = null;
            Map<String,String> mp=new HashMap<String,String>();
            int size = jiedian.size();
            for(int i=0; i<size; i++){
            	 et = (Element) jiedian.get(i);//循环依次得到子元素
            	 mp.put(et.getName(), et.getText());
            }
            json="{\"sCusName\":\""+StringUtil.toString(mp.get("cusName"))+"\",\"sLinkName\":\""+StringUtil.toString(mp.get("linkName"))+"\","+
            "\"sTelNum\":\""+StringUtil.toString(mp.get("telNum"))+"\",\"sEmail\":\""+StringUtil.toString(mp.get("email"))+"\","+
            "\"sSysName\":\""+StringUtil.toString(mp.get("systemName"))+"\",\"sHardwareSn\":\""+StringUtil.toString(mp.get("hardwareSn"))+"\","+
            "\"sDiskSn\":\""+StringUtil.toString(mp.get("diskSn"))+"\",\"sCpuSn\":\""+StringUtil.toString(mp.get("cpuSn"))+"\"," +
            "\"sSysVer\":\""+StringUtil.toString(mp.get("systemVer"))+"\"}";
		} catch (Exception e) {
			return "{\"error\":\"请导入正确的注册文件!\"}";
		}
        return json;
	}
	
	/**
	 * 读取文件内容并解密,map的key必须有fileObj
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
		    byte []byteStr=parseHexStr2Byte(readStr);//将十六进制转换成二进制文本
		    byte []str=DESTool.decrypt(key, new String(byteStr)).getBytes();//再将二进制解密
		    result = new String(str);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
	/**
	 * 创建试用版license授权文件
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
		    //处理序列号之间的"-"
			for(String str : sn.split("-")) {
				  hardSn.append(str);
			}
			Calendar c = Calendar.getInstance();
			c.add(Calendar.DAY_OF_MONTH, 15);
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			sb.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
			sb.append("<root>");
			sb.append("<cusName>暂无</cusName>");
			sb.append("<systemName>"+systemName+"</systemName>");
			sb.append("<hardwareSn>"+hardSn.toString()+"</hardwareSn>");
			sb.append("<sourceChName>用户表</sourceChName>");
			sb.append("<tableName>tbOsStaff</tableName>");
			sb.append("<licenseNum>2000</licenseNum>");
			sb.append("<onLineNum>4000</onLineNum>");
			sb.append("<bfNum>4</bfNum>");
			sb.append("<cpuCore>2</cpuCore>");//cpu个数/核数
			sb.append("<versionType>0</versionType>");
			sb.append("<versionNum>1.0</versionNum>");
			sb.append("<licType>1</licType>");
			sb.append("<endDate>"+sdf.format(c.getTime())+"</endDate>");
			sb.append("</root>");
		    mm = new RandomAccessFile(file, "rw");//文件模式为读写
		    byte []key=getKeyBytes(hardSn.toString());//将序列号作为密钥
		    String md5Str=MD5Tool.HexEncode(sb.toString());//md5加密
		    //byte []str=DESTool.encryptMode(key, md5Str.getBytes("UTF-8"));//加密
		    String n = DESTool.encrypt(key, md5Str);
		    byte[] str = DESTool.encrypt(key, md5Str).getBytes();
		    String hexStr=parseByte2HexStr(str);//将加密后的结果转换成十六进制
		    mm.writeBytes(hexStr); //将的到的十六进制写入文件中
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
	 * 获取资源数量
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
	 * 获取当前在线人数
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
	 * 获取密钥
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
	 * 将二进制转换成十六进制
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
	 * 将十六进制转换成二进制
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
	 * 删除文件
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
	 * 上传文件
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
				msg="没有文件";
			}
			fos = new FileOutputStream(map.get("systemPath").toString() + map.get("fileName").toString());
			fis = new FileInputStream(myFile);
			byte[] buffer = new byte[1024];
			int length = 0;
			while ((length = fis.read(buffer)) > 0) {
				fos.write(buffer, 0, length);
			}
			msg="导入成功";
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			msg="导入失败";
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
	 * 读取授权文件内容并解密
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
			    byte []byteStr=parseHexStr2Byte(readStr);//将十六进制转换成二进制文本
			    String n = new String(byteStr);
			    //byte []str=DESTool.decryptMode(key, byteStr);//将二进制内容用des解密
			    byte []str = DESTool.decrypt(key, new String(byteStr)).getBytes();//将二进制内容用des解密
			    result = MD5Tool.HexDecode(new String(str));//用MD5解密
			    //System.out.println("解密后文件内容是:"+ "\r\n" + result);
		    }
        } catch (Exception e) {
        	result="";
            e.printStackTrace();
        }
        return result;
    }
    
	/**
	 * 获取并发量 被OprationInterceptor.java调用
	 * @param request
	 * @return
	 */
	public static String getBfNum(HttpServletRequest request) {
		try {
			if(licensePath.equals("")){
				licensePath = RequestUtil.getRealPath(request) + "WEB-INF/classes/license.lic";//授权文件路径
				String SerialNo=SystemUtil.getHDSerialNo()+SystemUtil.getCPUSerialNo();//获取硬盘与cpu序列号
				String licStr=readLicenseDoc(MD5Tool.HexEncode(SerialNo), licensePath);
				//解析授权内容
				StringReader read = new StringReader(licStr);
				InputSource source = new InputSource(read);
				SAXBuilder sb = new SAXBuilder();
	            //通过输入源构造一个Document
				org.jdom.Document doc = sb.build(source);
	            org.jdom.Element root = doc.getRootElement();
	            //获取并发数量
	            org.jdom.Element bfNumNode=root.getChild("bfNum");//cpu个数/核数
	            if(StringUtil.checkStr(bfNumNode.getText())){//判断是否限制了并发数量
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
	 * 应用端查看授权信息
	 * @return
	 */
	public static String getLicenseInfo(Map map){
		String json="";
		String SerialNo=SystemUtil.getHDSerialNo()+SystemUtil.getCPUSerialNo();
		String filePath=map.get("filePath").toString();//授权文件路径
		String licStr=readLicenseDoc(MD5Tool.HexEncode(SerialNo), filePath);
		try {
			//解析授权内容
			StringReader read = new StringReader(licStr);
			InputSource source = new InputSource(read);
			SAXBuilder sb = new SAXBuilder();
	        //通过输入源构造一个Document
			org.jdom.Document doc = sb.build(source);
	        org.jdom.Element root = doc.getRootElement();
	        org.jdom.Element sysNameNode=root.getChild("systemName");//系统名称
	        org.jdom.Element cusNameNode=root.getChild("cusName");//客户名称
	        org.jdom.Element licTypeNode=root.getChild("licType");//授权类型 1普通授权 2永久授权
	        org.jdom.Element versionTypeNode=root.getChild("versionType");//版本类型 1正式版/0试用版
	        org.jdom.Element bfNumNode=root.getChild("bfNum");//限制并发数量
	        org.jdom.Element cpuCoreNode=root.getChild("cpuCore");//cpu个数/核数
	        org.jdom.Element onLineNumNode=root.getChild("onLineNum");//可同时在线人数
	        org.jdom.Element versionNumNode=root.getChild("versionNum");//版本号
	        org.jdom.Element endDateNode=root.getChild("endDate");//到期时间
	        org.jdom.Element sourceChNameNode=root.getChild("sourceChName");//业务表中文名
	        org.jdom.Element tableNameNode=root.getChild("tableName");//业务表名
	        org.jdom.Element licenseNumNode=root.getChild("licenseNum");//业务表数据量限制
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
	 * 应用端查看授权信息,供jsp页面调用
	 * @return
	 */
	public static List getLicenseInfoByPage(Map map){
		String json=getLicenseInfo(map);
		List jsonList = JackJson.getListByJsonArray("["+json+"]");
		return jsonList;
	}
	
	/**
	 * 是否在并发范围内
	 * @param request
	 * @param response
	 * @return
	 */
	public static boolean isPassRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		boolean flag=true;
		bfNum=getBfNum(request);//读取并发数量
		if(!bfNum.equals("")){
			if(number>Integer.parseInt(bfNum)){
				if(isAjaxRequest(request)){
					response.setStatus(8888);
					flag=false;
				}else{
					request.setAttribute("err", "当前用户请求数量过多,请稍后再试!");
					request.getRequestDispatcher(request.getContextPath()+"/error.jsp").forward(request, response);
					flag=false;
				}
			}
			if(flag)number++;//统计请求数量
		}
		return flag;
	}
	
	public static void minRequestNum(){
		number--;
	}
	
	//针对jquery的ajax请求
	private static boolean isAjaxRequest(HttpServletRequest request) {
		String header = request.getHeader("X-Requested-With");
		return (header != null && "XMLHttpRequest".equals(header));
	}
	
	/**
	 * license试用版授权生成后立即改变标示
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
		    mm = new RandomAccessFile(file, "rw");//文件模式为读写
		    mm.writeBytes(MD5Tool.HexEncode("false")); //将本次同步的开始时间保存到文件
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
	 * 读取license试用版标示,判断是否是第一次生成的license
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
