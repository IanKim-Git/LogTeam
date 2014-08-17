package sub.controller;

import javax.annotation.Resource;

import model.domain.JudgeBean;
import model.service.JudgeService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class JudgeController {
	@Resource(name="judgeService")
	private JudgeService judgeService;
	
	//로그 평가
	//insert into judge (j_uemail, j_lnum, jscore, j_l_pnum)
	@RequestMapping(value="evaluation.do", method=RequestMethod.POST)
	@ResponseBody
	public String insert(JudgeBean jb) {
		System.out.println("###################받아온 데이터 "+jb);
		String resultMsg = "no";//저장 실패시 응답되는 데이터		 
		int result = judgeService.evaluation(jb);
		if(result > 0 )  {
			resultMsg = "ok";//정상 저장시 응답되는 데이터
		}
		return resultMsg;  
	}
}
