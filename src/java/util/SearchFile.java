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
 * 在文件中检索关键字
 * 
 * @author qiaoqide
 * 
 */
public class SearchFile {
	private FileWriter fw = null;
	
	/**检索的目录 */
	private static String rootDir = "D:/catt5.5/jzgj";
	
	/**要搜索的关键字 */
	//private static String[] keyWords_2 = {"t_trans_ne","T_TRANS_SHELF"};
	private static String[] keyWords_2 = {
		"T_TRANS_NE","T_TRANS_SHELF","T_TRANS_SLOT","T_TRANS_BOARD","T_TRANS_PORT","T_TRANS_CCS",
		"T_TRANS_OTN_NE","T_TRANS_OTN_SHELF","T_TRANS_OTN_SLOT","T_TRANS_OTN_BOARD","T_TRANS_OTN_PORT","T_TRANS_OTN_CCS",
		"T_TRANS_DWDM_NE","T_TRANS_DWDM_SHELF","T_TRANS_DWDM_SLOT","T_TRANS_DWDM_BOARD","T_TRANS_DWDM_PORT","T_TRANS_DWDM_CCS",
		"T_TRANS_PTN_NE","T_TRANS_PTN_SHELF","T_TRANS_PTN_SLOT","T_TRANS_PTN_BOARD","T_TRANS_PTN_PORT","T_TRANS_PTN_CCS"};
	
	/**检索关键字是否区分大小写 默认false不区分*/
	private static boolean caseCensetive = false;
	
	/**检索的文件copy到此目标文件夹 */
	private static String desFile = "d:/copyFile/";
	
	/**是否将检查结果写入文件清单*/
	private static boolean isWriteFileList = false;
	
	/**写入文件清单路径(isWriteFileList=true才需要设置)*/
	private static String fileListPath = "d:/java.csv";
	
	private static int count = 0;
	
	private static Map<String, String> fileMap = new HashMap<String,String>();
	
	public static void main(String args[]) {
		SearchFile searcher = new SearchFile();
		//D:/catt5.5/selfmgr/src/java/vo/app
		try {
			System.out.println("正在检索文件...");
			searcher.search(rootDir, "java", keyWords_2, caseCensetive);
			searcher.search(rootDir, "jsp", keyWords_2, caseCensetive);
			searcher.search(rootDir, "js", keyWords_2, caseCensetive);
			searcher.search(rootDir, "xml", keyWords_2, caseCensetive);
			searcher.search(rootDir, "sql", keyWords_2, caseCensetive);
			searcher.search(rootDir, "properties", keyWords_2, caseCensetive);
			System.out.println("检索完毕...");
			System.out.println("正在copy文件...");
			searcher.iterateFileMap();
			System.out.println("copy文件完成...");
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		
	}
	
	/**
	 * 在文件中搜索关键字
	 * @param path
	 *            要检测的文件的路径
	 * @param suffix
	 *            文件的后缀
	 * @param keyWords
	 *            要进行匹配的关键字
	 * @param isCaseSencitive
	 *            是否区分大小写。true - 区分，false - 不区分
	 * @param outputFile
	 *            保留结果的CSV文件
	 * @throws Exception 
	 */
	public void search(String path, String suffix, String[] keyWords,
			boolean isCaseSencitive) throws Exception {
		File file = new File(path);
		if (!file.exists()) { //如果文件夹不存在
            System.out.println("目录不存在：" + file.getAbsolutePath());
            return;
        }
		// 首先检测文件是否是目录，是的话就列出其子文件，递归调用该方法进行匹配测试
		if (file.isDirectory()) {
			String[] childs = file.list();
			
			for (int i = 0; i < childs.length; i++) {
				search(path + "/" + childs[i], suffix, keyWords,
						isCaseSencitive);
			}
			
			// 如果是普通文件，就对匹配指定后缀的文件进行关键字检测
		} else if(path.toLowerCase().endsWith(suffix)) {
			 
			String encoding = "UTF-8"; //对文件编码进行检测
			// 打开要读取的文件
			LineNumberReader lnr = new LineNumberReader(
					new InputStreamReader(new FileInputStream(file),
							encoding));// "UTF-8" "ISO-8859-1" "MS932"
			// 开始读取数据
			String dataStr = lnr.readLine();
			while (dataStr != null) {
				// 对数据字符串进行循环检测关键字
				for (int i = 0; i < keyWords.length; i++) {
					 //如果发现关键字就保存结果，格式为{文件路径，行号，关键字，文件字符集}
					if ((isCaseSencitive && dataStr.indexOf(keyWords[i]) != -1)
							|| (!isCaseSencitive && dataStr.toLowerCase()
									.indexOf(keyWords[i].toLowerCase()) != -1)) {
						putFile(file.getAbsolutePath(), lnr.getLineNumber() + "", keyWords[i]);
					}
				}
				// 读取下一行数据
				dataStr = lnr.readLine();
			}
		}
	}
	
	/**
	 * 写文件头部信息
	 * @throws Exception 
	 *
	 */
	private void createFile() throws Exception{

		String []arrHeads = new String[]{"文件路径","关键字&行号"};
        for(int i = 0; i < arrHeads.length; i++){
        	if(i > 0){
        		fw.write(",");
        	}
        	fw.write("\"" + arrHeads[i] + "\"");
        }
        fw.write(System.getProperty("line.separator"));
	}	
	
	/**
	 * 创建要保存结果果的CSV文件
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
	 * 把找出的文件路径、关键字和行号放到map中
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
	 * 迭代存放文件信息的map
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
			/*copy 检索的那件到目标文件夹,并将关键字和行号写入到文件最底部*/
			//copyFile(key, desFile);
			cp(key, desFile, val);
			//String fileName = key.substring(key.lastIndexOf("\\")+1, key.length());
			//writeInfo(desFile + fileName, val);
			System.out.println(key+" >> " + val);
			
			/*将检索的结果写入csv文件*/
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
            // 打开一个写文件器，构造函数中的第二个参数true表示以追加形式写文件     
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
	 * 复制文件
	 * @author tanjianwen
	 * @param from 来源全路径文件名
	 * @param to 复制全路径文件名
	 * @param val 检索的关键字和行号
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
		writeInfo(to, val); //在文件底部写上关键字与行号
	}
	
	/**
	 * 复制文件
	 * @author tanjianwen
	 * @param from 来源文件
	 * @param to 复制文件
	 */
	public static void cp(File from, File to) throws IOException {
		FileInputStream in = new FileInputStream(from);
		OutputStream out = new FileOutputStream(to);
		cp(in, out);
		in.close();
		out.close();
	}
	
	/**
	 * 复制文件
	 * @author tanjianwen
	 * @param from 来源文件流
	 * @param to 复制文件流
	 */
	public static void cp(InputStream in, OutputStream out) throws IOException {
		// 1K byte 的缓冲区!
		byte[] buf = new byte[1024];
		int count;
		while ((count = in.read(buf)) != -1) {
			// System.out.println(count);
			out.write(buf, 0, count);
		}
	}
}
