package util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Scanner;

/**
 * ��ȡϵͳ�����Ϣ������
 * @author tanjianwen
 * @modified qiaoqide
 */
public class SystemUtil {
	/**
	 * ��ȡӲ�����к�
	 * @return Ӳ�����к�
	 * @throws Exception
	 */
	public static final String getHDSerialNo() {
		try {
			String os = getOsName();
			if (os.startsWith("Windows")) {// windows������
				return getHDSerialNoForWindows();
			} else if (os.startsWith("Linux")) {// Linux������
				return getHDSerialNoForLinux();
			} else {
				return "";
			}
		} catch (Exception ex) {
			return "";
		}
	}
	
	/**
	 * ��ȡCPU���к�
	 * @return cpu���к�
	 * @author qiaoqide
	 */
	public static final String getCPUSerialNo(){
		try {
			String os = getOsName();
			if (os.startsWith("Windows")) {// windows������
				return getCPUSerialNoForWindows();
			} else if (os.startsWith("Linux")) {// Linux������
				return getCPUSerialNoForLinux();
			} else {
				return "";
			}
		} catch (Exception ex) {
			return null;
		}
	}
	
	/**
	 * ��ȡCPU����/����
	 * @return cpu����
	 * @author qiaoqide
	 */
	public static final String getCPUCore(){
		try {
			String os = getOsName();
			if (os.startsWith("Windows")) { //windows������
				return getCPUCoreForWindows();
			} else if (os.startsWith("Linux")) { //Linux������
				return getCPUCoreForLinux();
			} else {
				return "";
			}
		} catch (Exception ex) {
			return null;
		}
	}

	/**
	 * ��ȡ����ϵͳ����
	 * @return windows/linux
	 */
	private static String getOsName() {
		String os = "";
		os = System.getProperty("os.name");
		return os;
	}

	/**
	 * ��ȡӲ�����к�,�˷����ݲ�֧��64λ����ϵͳ.
	 * @return Ӳ�����к�
	 * @throws Exception
	 
	private static String getHDSerialNoForWindows2() throws Exception {
		JDiskSerial ds = JDiskSerial.get();
		Disk disk = ds.disk(0);
		return disk.getSerialNumber();
	}*/
	
	/**
	 * ��ȡӲ�����к� windowsϵͳ
	 * @return Ӳ�����к�
	 */
	private static String getHDSerialNoForWindows() {
		String hdSerial = ""; // ��¼Ӳ�����к�
		
		//�õ����̷������� new String[] { "c:", "d:", "e:", "f:" };
		String[] diskArr = getDisks(); 
		try {
			for(String disk : diskArr) {
				Process process = Runtime.getRuntime().exec(
						"cmd /c vol " + disk); //��ȡ�����в��� vol �� dir������
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
	 * ��ȡӲ�̾���
	 * @return ��:c,d,e,f��
	 */
	public static String[] getDisks(){
		String[] disks = null;
/*		String[] arr = new String[] { "wmic", "logicaldisk", "get", "caption" };
		try {
			Process process = Runtime.getRuntime().exec(arr);
			process.getOutputStream().close();
			Scanner sc = new Scanner(process.getInputStream());
			sc.next(); //���ƣ���������һ��
			String temp = "";
			while(sc.hasNext()){
				temp += ";" + sc.next();
			}
			if(temp.length() > 1){
				temp = temp.substring(1); //ȥ����һ��";"��
			}
			disks = temp.split(";");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return disks;*/
		
		//����ע����֧��win7
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
	 * ��ȡӲ�����к�,����linux����ϵͳ
	 * @return Ӳ�����к�
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
	 * ȡӲ�̽ӿ�����
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
	 * ��windows�»�ȡcpu���к�
	 * @return cpu���к�
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
	 * ��windows�»�ȡcpu���к�
	 * @return cpu���к�
	 */
	private static String getCPUSerialNoForWindows2(){
		String serial = "";
		try {
			String[] arr = new String[] {"wmic", 
					"cpu", "get", "ProcessorId" }; // �õ�CPU���к�
			Process process = Runtime.getRuntime().exec(arr);
			process.getOutputStream().close();
			Scanner sc = new Scanner(process.getInputStream());
			sc.next(); //���ƣ���������һ��
			serial = sc.next(); //ֵ
		} catch (IOException e) {
			e.printStackTrace();
		}
		return serial;
	}
	
	/**
	 * ��linux�»�ȡcpu���к�
	 * @return cpu���к�
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
	 * ��windows�»�ȡcpu����/����
	 * @return cpu����
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
	 * ��Linux�»�ȡcpu����/����
	 * @return cpu����
	 */
	private static String getCPUCoreForLinux(){
		String num = "";
		String[] cmd = new String[]{"/bin/sh", "-c", 
				"cat /proc/cpuinfo | grep ^process | wc -l"};
		try {
			Process p = Runtime.getRuntime().exec(cmd); //����������,�����ӵ�����������
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
	 * main����
	 * @param args ����
	 * @throws Exception
	 */
	public static void main(String args[]) throws Exception {
		//System.out.println(System.getProperty("java.library.path"));
		/*JDiskSerial ds = JDiskSerial.get();
		Disk disk = ds.disk(0);
		System.out.println(getHDSerialNo());// Ӳ�����к�
		 */		
		
		System.out.println("CPU���к�:" + getCPUSerialNo());
		System.out.println("CPU����:" + getCPUCore());
		System.out.println("Ӳ�����к�:" + getHDSerialNo());
		
	}
}
