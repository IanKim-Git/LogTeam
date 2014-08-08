package sub.controller;

import javax.annotation.Resource;

import model.domain.ProgUserBean;
import model.service.ProgUserService;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ProgUserController {
	@Resource(name="puService")
	private ProgUserService puService;
	
	//로그인 할 때 아이디(이메일)와 비밀번호 확인
	@RequestMapping(value="idPwCheck.do", method=RequestMethod.POST)
	public String idPwCheck(@RequestParam("email") String uemail, @RequestParam("pw") String upw, Model model){
		model.addAttribute("email", uemail);
		model.addAttribute("pw", upw);	

		ProgUserBean pu = puService.userCheck(uemail, upw);
		if(pu != null){
			model.addAttribute("name", pu.getUname());
			model.addAttribute("phone", pu.getUphone());
			return "successView";
		}
		return "failView";
	}
	
	//이메일 중복 체크
	@RequestMapping("idCheck.do")
	@ResponseBody
	public ResponseEntity<String> userEmailCheck(String email){
		String checkMsg = "<font color='blue'>사용 가능한 ID 입니다.</font>";		
//		String pu = ;//DB 확인 로직
		if(puService.userEmailCheck(email) != null){//이미 해당 id가 존재하는 조건식
			checkMsg = "<font color='red'>중복된 이메일입니다. 다시 입력해주세요.</font>";
		}
		//한글 응답에 따른 설정
		/* ResponseEntity("응답데이터", http프로토콜설정정보를스펙에맞게추가설정(한글인코딩), 정상응답메시지)
		 * 참고
		 * - 404 : 요청한 url에 해당하는 로직이 없음에 대한 응답 코드
		 * - 500 : 서버 시스템 또는 서버 app~ 오류에 대한 응답 코드
		 * - 200 : 정상 응답에 대한 코드 = HttpStatus.OK 동급으로 간주
		 */
		HttpHeaders resHeader = new HttpHeaders();
		resHeader.add("Content-Type", "text/html;charset=UTF-8");
		ResponseEntity resultMsg = new ResponseEntity<String>(checkMsg, resHeader, HttpStatus.OK);
		
		return resultMsg;
	}
	
	//회원가입
	@RequestMapping(value="insert.do", method=RequestMethod.POST)
//	@RequestMapping("insert.do")
//	@ResponseBody
	public String insertUser(@RequestParam("email") String uemail, @RequestParam("name") String uname, 
						 @RequestParam("pw") String upw, @RequestParam("phone") String uphone, Model model) {
		String resultMsg = "signInFail";//저장 실패시 응답되는 데이터
		System.out.println(uname);
		
		int result = puService.userSignIn(new ProgUserBean(uemail, uname, upw, uphone));
		if(result > 0 )  {
			model.addAttribute("email", uemail);
			model.addAttribute("name", uname);
			resultMsg = "signInSucc";//정상 저장시 응답되는 데이터
		}
		return resultMsg;
	}

}
