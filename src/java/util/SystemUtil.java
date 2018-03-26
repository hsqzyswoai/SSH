package util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Scanner;

/**
 * 获取系统相关信息工具类
 * @author tanjianwen
 * @modified qiaoqide
 */
public class SystemUtil {
	/**
	 * 获取硬盘序列号
	 * @return 硬盘序列号
	 * @throws Exception
	 */
	public static final String getHDSerialNo() {
		try {
			String os = getOsName();
			if (os.startsWith("Windows")) {// windows环境下
				return getHDSerialNoForWindows();
			} else if (os.startsWith("Linux")) {// Linux环境下
				return getHDSerialNoForLinux();
			} else {
				return "";
			}
		} catch (Exception ex) {
			return "";
		}
	}
	
	/**
	 * 获取CPU序列号
	 * @return cpu序列号
	 * @author qiaoqide
	 */
	public static final String getCPUSerialNo(){
		try {
			String os = getOsName();
			if (os.startsWith("Windows")) {// windows环境下
				return getCPUSerialNoForWindows();
			} else if (os.startsWith("Linux")) {// Linux环境下
				return getCPUSerialNoForLinux();
			} else {
				return "";
			}
		} catch (Exception ex) {
			return null;
		}
	}
	
	/**
	 * 获取CPU个数/核数
	 * @return cpu核数
	 * @author qiaoqide
	 */
	public static final String getCPUCore(){
		try {
			String os = getOsName();
			if (os.startsWith("Windows")) { //windows环境下
				return getCPUCoreForWindows();
			} else if (os.startsWith("Linux")) { //Linux环境下
				return getCPUCoreForLinux();
			} else {
				return "";
			}
		} catch (Exception ex) {
			return null;
		}
	}

	/**
	 * 获取操作系统类型
	 * @return windows/linux
	 */
	private static String getOsName() {
		String os = "";
		os = System.getProperty("os.name");
		return os;
	}

	/**
	 * 获取硬盘序列号,此方法暂不支持64位操作系统.
	 * @return 硬盘序列号
	 * @throws Exception
	 
	private static String getHDSerialNoForWindows2() throws Exception {
		JDiskSerial ds = JDiskSerial.get();
		Disk disk = ds.disk(0);
		return disk.getSerialNumber();
	}*/
	
	/**
	 * 获取硬盘序列号 windows系统
	 * @return 硬盘序列号
	 */
	private static String getHDSerialNoForWindows() {
		String hdSerial = ""; // 记录硬盘序列号
		
		//得到磁盘分区名称 new String[] { "c:", "d:", "e:", "f:" };
		String[] diskArr = getDisks(); 
		try {
			for(String disk : diskArr) {
				Process process = Runtime.getRuntime().exec(
						"cmd /c vol " + disk); //获取命令行参数 vol 或 dir都可以
				process.getOutputStream().close();
				Scanner sc = new Scanner(process.getInputStream());
				
				while(sc.hasNext()){
					String temp = sc.next();
					if(temp.indexOf("-") > 0){
						hdSerial += ("-" + temp);
						break;
					}
				}
				
				if(hdSerial != null){
					hdSerial = hdSerial.substring(hdSerial.indexOf(" ") + 1);
				}
			}
			if(hdSerial.length() > 0){
				hdSerial = hdSerial.substring(1);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return hdSerial;
	}
	
	/**
	 * 获取硬盘卷名
	 * @return 例:c,d,e,f盘
	 */
	public static String[] getDisks(){
		String[] disks = null;
/*		String[] arr = new String[] { "wmic", "logicaldisk", "get", "caption" };
		try {
			Process process = Runtime.getRuntime().exec(arr);
			process.getOutputStream().close();
			Scanner sc = new Scanner(process.getInputStream());
			sc.next(); //名称，必须走这一行
			String temp = "";
			while(sc.hasNext()){
				temp += ";" + sc.next();
			}
			if(temp.length() > 1){
				temp = temp.substring(1); //去掉第一个";"号
			}
			disks = temp.split(";");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return disks;*/
		
		//上面注释因不支持win7
		String diskStr = "";
		File[] roots = File.listRoots();   
	    for (int i = 0; i < roots.length; i++) {
	    	if(i > 0){
	    		diskStr += ";";
	    	}
	    	diskStr += roots[i].toString().replace("\\", "");  
	    }
	    disks = diskStr.split(";");
	    return disks;
	}

	/**
	 * 获取硬盘序列号,用于linux操作系统
	 * @return 硬盘序列号
	 */
	private static String getHDSerialNoForLinux() {
		try {
			String sn = "";
			String command = "";
			if (isSCSIorIDEHD() == "scsi") {
				command = "hdparm -i /dev/sda";
			} else if (isSCSIorIDEHD() == "ide") {
				command = "hdparm -i /dev/hda";
			} else {
				return "";
			}
			Process p = Runtime.getRuntime().exec(command);
			BufferedReader br = new BufferedReader(new InputStreamReader(p
					.getInputStream()));
			String line;
			while ((line = br.readLine()) != null) {
				if (line.contains("SerialNo")) {
					int index = line.indexOf("SerialNo") + "SerialNo".length()
							+ 1;
					sn = line.substring(index);
					break;
				}
			}
			br.close();

			sn = sn.trim();
			return sn;
		} catch (Exception e) {
			return "";
		}
	}

	/**
	 * 取硬盘接口类型
	 * @return scsi/ide
	 */
	private static String isSCSIorIDEHD() {
		String command = "fdisk -l";
		try {
			Process p = Runtime.getRuntime().exec(command);
			BufferedReader br = new BufferedReader(new InputStreamReader(p
					.getInputStream()));
			String line;
			while ((line = br.readLine()) != null) {
				if (line.contains("sd")) {
					return "scsi";
				}
				if (line.contains("hd")) {
					return "ide";
				}
			}
			br.close();
		} catch (IOException e) {
			return "unkonwn";
		}
		return "unkonwn";
	}
	
	/**
	 * 在windows下获取cpu序列号
	 * @return cpu序列号
	 */
	private static String getCPUSerialNoForWindows(){
		String num = "";
		try {
			String tempFilePath = "d:\\";
			File tempDir = new File(tempFilePath); 
		 	File file = File.createTempFile("realhowto", ".vbs", tempDir); 
			file.deleteOnExit();
			FileWriter fw = new FileWriter(file);
			String vbs = "Set objWMIService=GetObject(\"winmgmts:\\\\.\\root\\cimv2\")\n"
				+ "Set colItems=objWMIService.ExecQuery _ \n"
				+ " (\"Select * from Win32_Processor\")\n"
				+ "For Each objItem in colItems \n"
				+ "  Wscript.Echo objItem.ProcessorId \n"
				+ "  exit for ' do the first cpu only! \n"
				+ "Next \n";
			fw.write(vbs);
			fw.close();
			String 	p1 = "d:\\" + file.getName();
			Process p = Runtime.getRuntime().exec("cscript //NoLogo " + p1);
			BufferedReader input = new BufferedReader(
					new InputStreamReader(p.getInputStream()));
			String line;
			while((line = input.readLine()) != null){
				num += line;
			}
			input.close();
			file.delete();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return num;
	}
	
	/**
	 * 在windows下获取cpu序列号
	 * @return cpu序列号
	 */
	private static String getCPUSerialNoForWindows2(){
		String serial = "";
		try {
			String[] arr = new String[] {"wmic", 
					"cpu", "get", "ProcessorId" }; // 得到CPU序列号
			Process process = Runtime.getRuntime().exec(arr);
			process.getOutputStream().close();
			Scanner sc = new Scanner(process.getInputStream());
			sc.next(); //名称，必须走这一行
			serial = sc.next(); //值
		} catch (IOException e) {
			e.printStackTrace();
		}
		return serial;
	}
	
	/**
	 * 在linux下获取cpu序列号
	 * @return cpu序列号
	 */
	private static String getCPUSerialNoForLinux() {
		String num = "";
		Runtime rt = Runtime.getRuntime();
		try{
			Process proc = rt.exec("dmidecode");
			InputStreamReader isr = new InputStreamReader(proc.getInputStream());
			BufferedReader br = new BufferedReader(isr);
			String line = null;
			boolean istest = false;
			while((line = br.readLine()) != null){
				if(line.toUpperCase().contains("Processor Information".toUpperCase())){
					istest = true;
				}
				if(istest && line.trim().toUpperCase().startsWith("ID:"))
				{
					num = line.toUpperCase().trim().substring(3);
					break;
				}
			}
			isr.close();
		}catch(IOException e){
			e.printStackTrace();
		}
		return num;
	}
	
	/**
	 * 在windows下获取cpu个数/核数
	 * @return cpu核数
	 */
	private static String getCPUCoreForWindows(){
		String num = "";
		try {
			Process p = Runtime.getRuntime().exec(
					"cmd.exe /c echo %NUMBER_OF_PROCESSORS%");
			BufferedReader input = new BufferedReader(
					new InputStreamReader(p.getInputStream()));
			String line;
			while((line = input.readLine()) != null){
				num += line;
			}
			input.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return num;
	}
	
	/**
	 * 在Linux下获取cpu个数/核数
	 * @return cpu核数
	 */
	private static String getCPUCoreForLinux(){
		String num = "";
		String[] cmd = new String[]{"/bin/sh", "-c", 
				"cat /proc/cpuinfo | grep ^process | wc -l"};
		try {
			Process p = Runtime.getRuntime().exec(cmd); //用数组类型,否则复杂的命令会出问题
			BufferedReader input = new BufferedReader(
					new InputStreamReader(p.getInputStream()));
			String line;
			while((line = input.readLine()) != null){
				num += line;
			}
			input.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return num;
	}
	
	/**
	 * main方法
	 * @param args 参数
	 * @throws Exception
	 */
	public static void main(String args[]) throws Exception {
		//System.out.println(System.getProperty("java.library.path"));
		/*JDiskSerial ds = JDiskSerial.get();
		Disk disk = ds.disk(0);
		System.out.println(getHDSerialNo());// 硬盘序列号
		 */		
		
		System.out.println("CPU序列号:" + getCPUSerialNo());
		System.out.println("CPU核数:" + getCPUCore());
		System.out.println("硬盘序列号:" + getHDSerialNo());
		
	}
}
