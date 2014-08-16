package sub.controller;

import java.util.List;

import javax.annotation.Resource;

import model.domain.LogcommentBean;
import model.service.LogcommentService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	//코멘트 작성
	@RequestMapping(value="writeLc.do", method=RequestMethod.POST)
	@ResponseBody
	public String insert(LogcommentBean lcb) {
		System.out.println("###################받아온 데이터 "+lcb);
		String resultMsg = "no";//저장 실패시 응답되는 데이터		 
		int result = lcService.lcWrite(lcb);
		if(result > 0 )  {
			resultMsg = "ok";//정상 저장시 응답되는 데이터
		}
		return resultMsg;  
	}
	
	//코멘트 삭제
	@RequestMapping("/deleteLc.do")
	@ResponseBody
	public String delete(String cnum) {
		String result = "no";
		if(lcService.lcDelete(Integer.parseInt(cnum)) > 0 ) {
			result = "ok";
		}
		return result; //요청한 jsp 또는 html의 xhr에게 직접 응답
	}
}
