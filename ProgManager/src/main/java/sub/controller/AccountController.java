package sub.controller;

import java.util.List;

import javax.annotation.Resource;

import model.domain.AccountBean;
import model.service.AccountService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AccountController {
	@Resource(name="acService")
	private AccountService acService;
	
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
	
	//공지사항 삭제
		@RequestMapping("/deleteAc.do")
		@ResponseBody
		public String delete(String acnum) {
			String result = "no";
			if(acService.acDelete(Integer.parseInt(acnum)) > 0 ) {
				result = "ok";
			}
			return result; //요청한 jsp 또는 html의 xhr에게 직접 응답
		}
}
