package sub.controller;

import java.util.List;

import javax.annotation.Resource;

import model.domain.LogBean;
import model.service.LogService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LogController {
	@Resource(name="logService")
	private LogService logService;
	
	//해당 프로젝트의 모든 로그들을 반환하는 메소드
	@RequestMapping("allLogs.do")
	public ModelAndView allLogs(@RequestParam("pnum") String l_pnum ){
//		System.out.println("####################프로젝트 번호"+l_pnum);
		List<LogBean> list =  logService.allLogs(Integer.parseInt(l_pnum));
		
		//데이터.를 request 저장 & view를 지정 가능한 객체
		ModelAndView mv = new ModelAndView();
		mv.addObject("list", list);	//request.setAttribute("list", list);
		mv.setViewName("projectJsonView");	//id=jsonView 객체를 찾아서 JsonView실행
		return mv;
	}
	
	//로그 삭제
	@RequestMapping("/delete.do")
	@ResponseBody
	public String delete(String lnum) {
		String result = "no";
		if(logService.logDelete(Integer.parseInt(lnum)) > 0 ) {
			result = "ok";
		}
		return result; //요청한 jsp 또는 html의 xhr에게 직접 응답
	}
	
	//로그 작성
	@RequestMapping(value="write.do", method=RequestMethod.POST)
	@ResponseBody
	public String insert(LogBean lb) {
//		System.out.println("###################받아온 데이터"+lb);
		String resultMsg = "no";//저장 실패시 응답되는 데이터
		int result = logService.logWrite(lb);
		if(result > 0 )  {
			resultMsg = "ok";//정상 저장시 응답되는 데이터
		}
		return resultMsg;  
	}
	
}
