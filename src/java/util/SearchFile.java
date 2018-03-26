package util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import util.StringUtil;
/**
 * ���ļ��м����ؼ���
 * 
 * @author qiaoqide
 * 
 */
public class SearchFile {
	private FileWriter fw = null;
	
	/**������Ŀ¼ */
	private static String rootDir = "D:/catt5.5/jzgj";
	
	/**Ҫ�����Ĺؼ��� */
	//private static String[] keyWords_2 = {"t_trans_ne","T_TRANS_SHELF"};
	private static String[] keyWords_2 = {
		"T_TRANS_NE","T_TRANS_SHELF","T_TRANS_SLOT","T_TRANS_BOARD","T_TRANS_PORT","T_TRANS_CCS",
		"T_TRANS_OTN_NE","T_TRANS_OTN_SHELF","T_TRANS_OTN_SLOT","T_TRANS_OTN_BOARD","T_TRANS_OTN_PORT","T_TRANS_OTN_CCS",
		"T_TRANS_DWDM_NE","T_TRANS_DWDM_SHELF","T_TRANS_DWDM_SLOT","T_TRANS_DWDM_BOARD","T_TRANS_DWDM_PORT","T_TRANS_DWDM_CCS",
		"T_TRANS_PTN_NE","T_TRANS_PTN_SHELF","T_TRANS_PTN_SLOT","T_TRANS_PTN_BOARD","T_TRANS_PTN_PORT","T_TRANS_PTN_CCS"};
	
	/**�����ؼ����Ƿ����ִ�Сд Ĭ��false������*/
	private static boolean caseCensetive = false;
	
	/**�������ļ�copy����Ŀ���ļ��� */
	private static String desFile = "d:/copyFile/";
	
	/**�Ƿ񽫼����д���ļ��嵥*/
	private static boolean isWriteFileList = false;
	
	/**д���ļ��嵥·��(isWriteFileList=true����Ҫ����)*/
	private static String fileListPath = "d:/java.csv";
	
	private static int count = 0;
	
	private static Map<String, String> fileMap = new HashMap<String,String>();
	
	public static void main(String args[]) {
		SearchFile searcher = new SearchFile();
		//D:/catt5.5/selfmgr/src/java/vo/app
		try {
			System.out.println("���ڼ����ļ�...");
			searcher.search(rootDir, "java", keyWords_2, caseCensetive);
			searcher.search(rootDir, "jsp", keyWords_2, caseCensetive);
			searcher.search(rootDir, "js", keyWords_2, caseCensetive);
			searcher.search(rootDir, "xml", keyWords_2, caseCensetive);
			searcher.search(rootDir, "sql", keyWords_2, caseCensetive);
			searcher.search(rootDir, "properties", keyWords_2, caseCensetive);
			System.out.println("�������...");
			System.out.println("����copy�ļ�...");
			searcher.iterateFileMap();
			System.out.println("copy�ļ����...");
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		
	}
	
	/**
	 * ���ļ��������ؼ���
	 * @param path
	 *            Ҫ�����ļ���·��
	 * @param suffix
	 *            �ļ��ĺ�׺
	 * @param keyWords
	 *            Ҫ����ƥ��Ĺؼ���
	 * @param isCaseSencitive
	 *            �Ƿ����ִ�Сд��true - ���֣�false - ������
	 * @param outputFile
	 *            ���������CSV�ļ�
	 * @throws Exception 
	 */
	public void search(String path, String suffix, String[] keyWords,
			boolean isCaseSencitive) throws Exception {
		File file = new File(path);
		if (!file.exists()) { //����ļ��в�����
            System.out.println("Ŀ¼�����ڣ�" + file.getAbsolutePath());
            return;
        }
		// ���ȼ���ļ��Ƿ���Ŀ¼���ǵĻ����г������ļ����ݹ���ø÷�������ƥ�����
		if (file.isDirectory()) {
			String[] childs = file.list();
			
			for (int i = 0; i < childs.length; i++) {
				search(path + "/" + childs[i], suffix, keyWords,
						isCaseSencitive);
			}
			
			// �������ͨ�ļ����Ͷ�ƥ��ָ����׺���ļ����йؼ��ּ��
		} else if(path.toLowerCase().endsWith(suffix)) {
			 
			String encoding = "UTF-8"; //���ļ�������м��
			// ��Ҫ��ȡ���ļ�
			LineNumberReader lnr = new LineNumberReader(
					new InputStreamReader(new FileInputStream(file),
							encoding));// "UTF-8" "ISO-8859-1" "MS932"
			// ��ʼ��ȡ����
			String dataStr = lnr.readLine();
			while (dataStr != null) {
				// �������ַ�������ѭ�����ؼ���
				for (int i = 0; i < keyWords.length; i++) {
					 //������ֹؼ��־ͱ���������ʽΪ{�ļ�·�����кţ��ؼ��֣��ļ��ַ���}
					if ((isCaseSencitive && dataStr.indexOf(keyWords[i]) != -1)
							|| (!isCaseSencitive && dataStr.toLowerCase()
									.indexOf(keyWords[i].toLowerCase()) != -1)) {
						putFile(file.getAbsolutePath(), lnr.getLineNumber() + "", keyWords[i]);
					}
				}
				// ��ȡ��һ������
				dataStr = lnr.readLine();
			}
		}
	}
	
	/**
	 * д�ļ�ͷ����Ϣ
	 * @throws Exception 
	 *
	 */
	private void createFile() throws Exception{

		String []arrHeads = new String[]{"�ļ�·��","�ؼ���&�к�"};
        for(int i = 0; i < arrHeads.length; i++){
        	if(i > 0){
        		fw.write(",");
        	}
        	fw.write("\"" + arrHeads[i] + "\"");
        }
        fw.write(System.getProperty("line.separator"));
	}	
	
	/**
	 * ����Ҫ����������CSV�ļ�
	 * @param sPath
	 * @param lineNum
	 * @param keyWords
	 * @throws Exception
	 */
	private void writeToCsv(String sPath, String keyWords_lineNum) throws Exception{
		
		if(count == 0){
			createFile();
		}
		//fw.write(System.getProperty("line.separator"));
		fw.write("\"" + sPath + "\",\""+keyWords_lineNum+"\"");
		fw.write(System.getProperty("line.separator"));
	}
	
	/**
	 * ���ҳ����ļ�·�����ؼ��ֺ��кŷŵ�map��
	 * @param sPath
	 * @param lineNum
	 * @param keyWords
	 */
	private void putFile(String sPath, String lineNum, 
			String keyWords){
		String val = fileMap.get(sPath);
		if(StringUtil.checkStr(val)){
			val += ";\n(" + keyWords + ":" + lineNum + ")";
		}else{
			val = "(" + keyWords + ":" + lineNum + ")";
		}
		fileMap.put(sPath, val);
	}
	
	/**
	 * ��������ļ���Ϣ��map
	 * @throws Exception
	 */
	private void iterateFileMap() throws Exception{
		if(isWriteFileList){
			fw = new FileWriter(fileListPath, true);
		}
		
		for(Iterator<String> iterator = fileMap.keySet().iterator(); 
		iterator.hasNext();){
			String key = iterator.next();
			String val = fileMap.get(key);
			/*copy �������Ǽ���Ŀ���ļ���,�����ؼ��ֺ��к�д�뵽�ļ���ײ�*/
			//copyFile(key, desFile);
			cp(key, desFile, val);
			//String fileName = key.substring(key.lastIndexOf("\\")+1, key.length());
			//writeInfo(desFile + fileName, val);
			System.out.println(key+" >> " + val);
			
			/*�������Ľ��д��csv�ļ�*/
			if(isWriteFileList){
				writeToCsv(key, val);
				count++;
			}
		}
		if(fw != null){
			fw.close();
		}
	}
	
	private static void writeInfo(String fileName, String insertContent) throws Exception{
		/*RandomAccessFile raf = new RandomAccessFile(fileName, "rw");
		raf.seek(0);
	    raf.write(insertContent.getBytes());
	    raf.close();*/
		FileWriter writer = null;  
        try {
            // ��һ��д�ļ��������캯���еĵڶ�������true��ʾ��׷����ʽд�ļ�     
            writer = new FileWriter(fileName, true);
            writer.write("/*" + insertContent +" */");
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {     
                if(writer != null){
                    writer.close();
                }
            }catch (IOException e) {
                e.printStackTrace();
            }
        }
	}
	
	/**
	 * �����ļ�
	 * @author tanjianwen
	 * @param from ��Դȫ·���ļ���
	 * @param to ����ȫ·���ļ���
	 * @param val �����Ĺؼ��ֺ��к�
	 */
	public static void cp(String from, String to, String val) throws Exception {
		String fileName = "";
		if(from.indexOf("src") > -1){
			fileName = from.substring(from.lastIndexOf("src"), from.length());
			
		}
		if(from.indexOf("WebRoot") > -1){
			fileName = from.substring(from.lastIndexOf("WebRoot"), from.length());
			
		}
		String desPath = fileName.substring(0, fileName.lastIndexOf("\\")+1);
		File f = new File(to + desPath);
		if(!f.exists()){
			f.mkdirs();
		}
		to = to + fileName;
		cp(new File(from), new File(to));
		writeInfo(to, val); //���ļ��ײ�д�Ϲؼ������к�
	}
	
	/**
	 * �����ļ�
	 * @author tanjianwen
	 * @param from ��Դ�ļ�
	 * @param to �����ļ�
	 */
	public static void cp(File from, File to) throws IOException {
		FileInputStream in = new FileInputStream(from);
		OutputStream out = new FileOutputStream(to);
		cp(in, out);
		in.close();
		out.close();
	}
	
	/**
	 * �����ļ�
	 * @author tanjianwen
	 * @param from ��Դ�ļ���
	 * @param to �����ļ���
	 */
	public static void cp(InputStream in, OutputStream out) throws IOException {
		// 1K byte �Ļ�����!
		byte[] buf = new byte[1024];
		int count;
		while ((count = in.read(buf)) != -1) {
			// System.out.println(count);
			out.write(buf, 0, count);
		}
	}
}
