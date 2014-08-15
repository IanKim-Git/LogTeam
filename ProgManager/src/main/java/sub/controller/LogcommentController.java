package sub.controller;

import java.util.List;

import javax.annotation.Resource;

import model.domain.LogcommentBean;
import model.service.LogcommentService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LogcommentController {
	@Resource(name="lcService")
	private LogcommentService lcService;
	
	//모든 코멘트 출력
	@RequestMapping("allLcs.do")
	public ModelAndView allAns(LogcommentBean lcb){
		System.out.println("####################프로젝트 번호 "+lcb.getC_l_pnum());
		System.out.println("####################로그 번호 "+lcb.getC_lnum());
		List<LogcommentBean> list =  lcService.allLcs(lcb);
		
		//데이터를 request 저장 & view를 지정 가능한 객체
		ModelAndView mv = new ModelAndView();
		mv.addObject("list", list);	
		mv.setViewName("projectJsonView");	
		return mv;
	}
}
