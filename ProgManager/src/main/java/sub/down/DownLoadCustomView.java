package sub.down;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class DownLoadCustomView extends AbstractView {

	@Override
	protected void renderMergedOutputModel(Map<String, Object> map, HttpServletRequest request, 
										   HttpServletResponse response) throws Exception {
		
		File file = (File) map.get("downFile");
		
		response.setContentType("application/download;charset-UTF-8");
		response.setContentLength((int)file.length());
	
		
		String userAgent = request.getHeader("User-Agent");
		boolean isInternetExplorer = userAgent.indexOf("MSIE") > -1;
				
		String fileName = null;
		
		if(isInternetExplorer){
			fileName = URLEncoder.encode(file.getName() , "UTF-8");
		}else{
			//한글문제 발생 
			//fileName = new String(file.getName().getBytes("UTF-8") , "iso-8859-1");
			//fileName = URLEncoder.encode(file.getName() , "iso-8859-1") ;
			//fileName = URLEncoder.encode(file.getName() , "utf-8") ;
			
			//fileName = new String(file.getName().getBytes("UTF-8") , "utf-8");  //ok
			fileName = file.getName();//ok
		}
		
		response.setHeader("Content-Disposition","attachment;filename=\"" + fileName.replace("+", "%20") + "\";");
		//response.setHeader("Content-Transfer-Encoding", "binary");
		
		OutputStream out = response.getOutputStream();
		FileInputStream fis = null;
		try{
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
		}
		catch(Exception e){
			map.put("error", e.toString());
		}
		finally{
			if(fis != null){
				try{
					fis.close();
				}
				catch(IOException ex){}
			}
		}		
		out.flush();		
	}


}







