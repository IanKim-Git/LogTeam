package sub.controller;

import java.util.List;

import javax.annotation.Resource;

import model.domain.ProjectBean;
import model.service.ProgUserService;
import model.service.ProjectService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ProjectController {
	@Resource(name="projectService")
	private ProjectService projectService;
	
	@Resource(name="puService")
	private ProgUserService puService;

	@RequestMapping(value="newProject.do", method=RequestMethod.POST)
	@ResponseBody
	public String newProject(@RequestParam("pname") String pname, @RequestParam("ppw") String ppw, @RequestParam("pmento") String pmento, 
			@RequestParam("pstart") String pstart, @RequestParam("pend") String pend, @RequestParam("pleader") String pleader, Model model ){

		System.out.println(pleader);
		model.addAttribute("pname", pname);
		model.addAttribute("ppw", ppw);
		model.addAttribute("pmento", pmento);
		model.addAttribute("pstart", pstart);
		model.addAttribute("pend", pend);
		model.addAttribute("pleader", pleader);
		model.addAttribute("pterminate", 0);

		int result = projectService.newProject(pname, ppw, pmento, pstart, pend, pleader, 0);
		if(result != 0)
			return "ok";
		else
			return "no";
	}
	
	@RequestMapping(value="enterProjectMain.do", method=RequestMethod.POST)
	public String newProject(@RequestParam("pnum") String pnum, @RequestParam("pname") String pname, Model model){

		System.out.println("///////////////////////sdfsdfsdf/////////////////////");
		System.out.println("////////////////////////////////////////////"+pnum);
		
		model.addAttribute("pnum", pnum);
		model.addAttribute("pname", pname);
		return "projectMain";
	}

	/* 스프링 웹 설정 파일 참조 : springAjaxMyBatis-servlet.xml  
	<bean id="jsonView" class="net.sf.json.spring.web.servlet.view.JsonView" >
		<property name="contentType" value="text/html;charset=UTF-8" />
	</bean> */
	@RequestMapping("/getProjectList.do")
	public ModelAndView select(String uemail){
		System.out.println(uemail+"///////////////////////////");
		System.out.println("get project List.do controller//////////////////////////////////");
		
		List<ProjectBean> list =  projectService.getProjectList(uemail);
		System.out.println(list.toString()+"//////////////////////");
		ModelAndView mv = new ModelAndView();
		mv.addObject("list", list);			
		mv.setViewName("projectJsonView");	//id=jsonView 객체를 찾아서 JsonView실행
		return mv;
	}
	
	//프로젝트 정보로 이동
	@RequestMapping("projectInfo.do")
	public String enterProjectInfo(@RequestParam("enterProInfoPnum") String pnum, Model model){
		model.addAttribute("pnum", pnum);
		//model.addAttribute("pinfo", projectService.getProjectInfo(pnum));
		//model.addAttribute("puser", puService.projectUserList(pnum));
		return "projectInfo";
	}
	
	//공지사항으로 이동
	@RequestMapping("announcement.do")
	public String enterAnnouncement(@RequestParam("enterAnnPnum") String pnum, Model model){
		model.addAttribute("pnum", pnum);
		return "announcement";
	}
	
	//캘린더로 이동
	@RequestMapping("calender.do")
	public String enterCalender(@RequestParam("enterCalPnum") String pnum, Model model){
		model.addAttribute("pnum", pnum);
		return "calender";
	}
	
	//로그게시판으로 이동
	@RequestMapping("logList.do")
	public String enterLogList(@RequestParam("enterLogPnum") String pnum, Model model){
		model.addAttribute("pnum", pnum);
		return "logList";
	}
	
	//팀원성과도로 이동
	@RequestMapping("outcome.do")
	public String enterOutcome(@RequestParam("enterOutPnum") String pnum, Model model){
		model.addAttribute("pnum", pnum);
		return "outcome";
	}
	
	//회계관리로 이동
	@RequestMapping("account.do")
	public String enterAccount(@RequestParam("enterAccPnum") String pnum, Model model){
		model.addAttribute("pnum", pnum);
		return "account";
	}

}







