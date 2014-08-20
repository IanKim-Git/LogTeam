package util;

public class MethodUtil {
	//파일 이름 생성하는 메소드
	public static String fileNameCreate(String original, String prefix){
		StringBuffer filename = new StringBuffer(prefix);
		filename.append(new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date()));
		filename.append(original.substring(original.lastIndexOf("."), original.length()));
		return filename.toString();
	}
	
	//파일 경로 생성하는 메소드
	public static String filePath(String path, String filename){
		return path+filename;
	}
}
