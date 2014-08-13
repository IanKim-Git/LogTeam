package sub.controller;

import java.util.List;

import javax.annotation.Resource;

import model.domain.AnnouncementBean;
import model.service.AnnouncementService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AnnouncementController {
	@Resource(name="anService")
	private AnnouncementService anService;
	
	//공지사항 목록 출력
	
	@RequestMapping("allAns.do")
	public ModelAndView allLogs(@RequestParam("pnum") String an_pnum ){
		System.out.println("####################프로젝트 번호 "+an_pnum);
		List<AnnouncementBean> list =  anService.allAns(Integer.parseInt(an_pnum));
		
		//데이터.를 request 저장 & view를 지정 가능한 객체
		ModelAndView mv = new ModelAndView();
		mv.addObject("list", list);	
		mv.setViewName("projectJsonView");	
		return mv;
	}

	//공지사항 작성
	@RequestMapping(value="writeAn.do", method=RequestMethod.POST)
	@ResponseBody
	public String insert(AnnouncementBean ab) {
//		System.out.println("###################받아온 데이터"+ab);
//		System.out.println("####################중요도  "+ab.getAnimportance());
		String resultMsg = "no";//저장 실패시 응답되는 데이터
		if(ab.getAnimportance() == -1){
	 		return "again";
	 	}
		int result = anService.anWrite(ab);
		if(result > 0 )  {
			resultMsg = "ok";//정상 저장시 응답되는 데이터
		}
		return resultMsg;  
	}
	 
	//공지사항 삭제
	@RequestMapping("/deleteAn.do")
	@ResponseBody
	public String delete(String annum) {
		String result = "no";
		if(anService.anDelete(Integer.parseInt(annum)) > 0 ) {
			result = "ok";
		}
		return result; //요청한 jsp 또는 html의 xhr에게 직접 응답
	}
	
	 
}
