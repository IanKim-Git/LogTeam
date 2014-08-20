package sub.controller;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;

import model.domain.JudgeBean;
import model.domain.LogBean;
import model.domain.LogcommentBean;
import model.domain.ProgUserPhotoBean;
import model.service.JudgeService;
import model.service.LogService;
import model.service.LogcommentService;
import model.service.ProgUserService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LogController {
	@Resource(name="logService")
	private LogService logService;
	
	@Resource(name="lcService")
	private LogcommentService lcService;
	
	@Resource(name="judgeService")
	private JudgeService judgeService;
	
	@Resource(name = "puService")
	private ProgUserService puService;
	
	//김용두 사진 패스
//	private String pfilePath = "D:/2014KODB/slogProject/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/ProgManager/ProgFile/lphoto/";
	//박상태 사진 패스
//	private String pfilePath = "C:/Users/Ian/git/LogTeam/ProgManager/WebContent/ProgFile/uphoto";
	//황수남 사진 패스
//	private String pfilePath = "";
	//박다은 사진 패스
	private String pfilePath =  "C:/2014KODB/KODBFinalProject/GitTest/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/ProgManager/ProgFile/lphoto/";

	//김용두 파일 패스
//	private String lfilePath = "D:/2014KODB/slogProject/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/ProgManager/ProgFile/lfile/";
	//박상태 파일 패스
//	private String lfilePath = "C:/Users/Ian/git/LogTeam/ProgManager/WebContent/ProgFile/uphoto";
	//황수남 파일 패스
//	private String lfilePath = "";
	//박다은 파일 패스
	private String lfilePath =  "C:/2014KODB/KODBFinalProject/GitTest/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/ProgManager/ProgFile/lfile/";

	
	//해당 프로젝트의 모든 로그들과 코멘트를 반환하는 메소드
	@RequestMapping("allLogs.do")
	public ModelAndView allLogs(@RequestParam("pnum") String l_pnum, @RequestParam("uemail") String l_uemail){
//		System.out.println("####################프로젝트 번호"+l_pnum);
		int pnum = Integer.parseInt(l_pnum);
		List<LogBean> list =  logService.allSelectedLogs(new LogBean(l_uemail, pnum));
		List<LogcommentBean> clist = lcService.allPlcs(pnum);
		List<JudgeBean> jlist = judgeService.judgeList(pnum);
		List<ProgUserPhotoBean> ulist = puService.getUphotoUemail(pnum);
		
		//데이터.를 request 저장 & view를 지정 가능한 객체
		ModelAndView mv = new ModelAndView();
		mv.addObject("list", list);	//request.setAttribute("list", list);
		mv.addObject("clist", clist);
		mv.addObject("jlist", jlist);
		mv.addObject("ulist", ulist);
		mv.setViewName("projectJsonView");	//id=jsonView 객체를 찾아서 JsonView실행
		return mv;
	}
	
	//로그 삭제
	@RequestMapping("/deleteLog.do")
	@ResponseBody
	public String delete(String lnum) {
		String result = "no";
		if(logService.logDelete(Integer.parseInt(lnum)) > 0 ) {
			result = "ok";
		}
		return result; //요청한 jsp 또는 html의 xhr에게 직접 응답
	}
 
	//로그 작성 : only text
	@RequestMapping(value="write.do", method=RequestMethod.POST)
	@ResponseBody
	public String insert(@RequestParam("l_pnum") String l_pnum, @RequestParam("l_uemail") String l_uemail,
				 @RequestParam("ltext") String ltext, @RequestParam("lpublic") String lpublic) {
//			System.out.println("###################받아온 데이터"+lb);
		String resultMsg = "no";//저장 실패시 응답되는 데이터
		
		 if(Integer.parseInt(lpublic) == -1){
	 		return "again";
	 	}
		 
		int result = logService.logWrite(new LogBean(Integer.parseInt(l_pnum), l_uemail, ltext, Integer.parseInt(lpublic)));
		if(result > 0 )  {
			resultMsg = "ok";//정상 저장시 응답되는 데이터
		}
		return resultMsg;  
	}	
	
	//로그 작성 : with photo
	@RequestMapping(value="writePhoto.do", method=RequestMethod.POST)
	@ResponseBody
	public String insert(@RequestParam("file-0")  MultipartFile file, @RequestParam("l_pnum") String l_pnum,
			@RequestParam("l_uemail") String l_uemail, @RequestParam("ltext") String ltext, @RequestParam("lpublic") String lpublic) {
//		System.out.println("###################받아온 데이터"+lb);
		String resultMsg = "no";//저장 실패시 응답되는 데이터
		String photoName =  l_uemail;
		photoName += new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
		photoName += file.getOriginalFilename();
		
		if(Integer.parseInt(lpublic) == -1){
	 		return "again";
	 	}
		try{
			//폴더에 사진 저장
			file.transferTo(new File(pfilePath+photoName));
			String lphoto = "./ProgFile/lphoto/"+photoName;
			System.out.println("################################## controller 이미지 : " + lphoto);
			int result = logService.logWritePhoto(new LogBean(Integer.parseInt(l_pnum), l_uemail, ltext, Integer.parseInt(lpublic), lphoto));
			if(result>0){
				resultMsg = "ok";
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return resultMsg;  
	}
	
	//로그 작성 : with file
	@RequestMapping(value="writeFile.do", method=RequestMethod.POST)
	@ResponseBody
	public String insert(@RequestParam("l_pnum") String l_pnum, @RequestParam("l_uemail") String l_uemail, 
			@RequestParam("ltext") String ltext, @RequestParam("lpublic") String lpublic, @RequestParam("lfile-0")  MultipartFile lfile) {
//		System.out.println("###################받아온 데이터"+lb);
		String resultMsg = "no";//저장 실패시 응답되는 데이터
		String lfileName =  l_uemail;
		lfileName += new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
		lfileName += lfile.getOriginalFilename();
		String originalName = lfile.getOriginalFilename();
		System.out.println("##################################### 파일이름 : " + originalName);
		
		if(Integer.parseInt(lpublic) == -1){
	 		return "again";
	 	}
		try{
			//폴더에 파일 저장
			lfile.transferTo(new File(lfilePath+lfileName));
			System.out.println("################################## controller 파일 : " + lfileName);
			int result = logService.logWriteFile(new LogBean(Integer.parseInt(l_pnum), l_uemail, ltext, lfileName, originalName, Integer.parseInt(lpublic)));
			if(result>0){
				resultMsg = "ok";
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return resultMsg;  
	}
	
	//로그 작성 : with photo file
	@RequestMapping(value="writePhotoFile.do", method=RequestMethod.POST)
	@ResponseBody
	public String insert(@RequestParam("file-0")  MultipartFile file, @RequestParam("l_pnum") String l_pnum,
			@RequestParam("l_uemail") String l_uemail, @RequestParam("ltext") String ltext, @RequestParam("lpublic") String lpublic, @RequestParam("lfile-0")  MultipartFile lfile) {
//		System.out.println("###################받아온 데이터"+lb);
		String resultMsg = "no";//저장 실패시 응답되는 데이터
		
		//사진
		String photoName =  l_uemail;
		photoName += new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
		photoName += file.getOriginalFilename();
		
		//파일
		String lfileName =  l_uemail;
		lfileName += new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
		lfileName += lfile.getOriginalFilename();
		String originalName = lfile.getOriginalFilename();
		
		if(Integer.parseInt(lpublic) == -1){
	 		return "again";
	 	}
		try{
			//폴더에 사진 저장
			file.transferTo(new File(pfilePath+photoName));
			String lphoto = "./ProgFile/lphoto/"+photoName;
			System.out.println("################################## controller 이미지 : " + lphoto);
			
			//폴더에 파일 저장
			lfile.transferTo(new File(lfilePath+lfileName));
			System.out.println("################################## controller 파일 : " + lfileName);
			
			int result = logService.logWritePhotoFile(new LogBean(Integer.parseInt(l_pnum), l_uemail, ltext, Integer.parseInt(lpublic), lphoto, lfileName, originalName));
			if(result>0){
				resultMsg = "ok";
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return resultMsg;  
	}
	
	@RequestMapping("/down.do")
	public ModelAndView down(String lfile){
		System.out.println("########################################### 다운 받을 파일 이름 : "+lfile);
		File file = new File(lfilePath+lfile);
		/*
		 * downLoadView는 뷰의 이름 : DownLoadCustomView.class를 생성한 id이다.
		 * 
		 * BeanNameViewResolver(빈의 이름으로 뷰를찾는다)를
		 * 등록하면 먼저 빈의 이름으로 찾을수 있도록 하고
		 * 만약, bean의 id중에 찾는 이름이 없으면 
		 * InternalResourceViewResolver 에서 등록된 뷰가 실행된다.
		 * */
		return new ModelAndView("downLoadView", "downFile", file);
	}
	
}
