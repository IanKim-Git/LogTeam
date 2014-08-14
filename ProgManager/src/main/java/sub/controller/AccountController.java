package sub.controller;

import java.util.List;

import javax.annotation.Resource;

import model.domain.AccountBean;
import model.domain.AnnouncementBean;
import model.service.AccountService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AccountController {
	@Resource(name="acService")
	private AccountService acService;
	
	//회계 목록
	@RequestMapping("allAcs.do")
	public ModelAndView allAcs(@RequestParam("pnum") String ac_pnum ){
		System.out.println("####################프로젝트 번호 "+ac_pnum);
		List<AccountBean> list =  acService.allAcs(Integer.parseInt(ac_pnum));
		
		//데이터.를 request 저장 & view를 지정 가능한 객체
		ModelAndView mv = new ModelAndView();
		mv.addObject("list", list);	
		mv.setViewName("projectJsonView");	
		return mv;
	}
	
	//회계 삭제
	@RequestMapping("/deleteAc.do")
	@ResponseBody
	public String delete(String acnum) {
		String result = "no";
		if(acService.acDelete(Integer.parseInt(acnum)) > 0 ) {
			result = "ok";
		}
		return result; //요청한 jsp 또는 html의 xhr에게 직접 응답
	}
	
	//회계 등록
	@RequestMapping(value="writeAc.do", method=RequestMethod.POST)
	@ResponseBody
	public String insert(AccountBean acb) {
		System.out.println("###################받아온 데이터"+acb);
		String resultMsg = "no";//저장 실패시 응답되는 데이터
	
		int result = acService.acWrite(acb);
		if(result > 0 )  {
			resultMsg = "ok";//정상 저장시 응답되는 데이터
		}
		return resultMsg;  
	}
}
