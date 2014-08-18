package sub.controller;

import java.io.File;

import javax.annotation.Resource;

import model.domain.ProgUserBean;
import model.domain.ProgUserPhotoBean;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ProgUserController {
	@Resource(name = "puService")
	private ProgUserService puService;

	// 로그인 할 때 아이디(이메일)와 비밀번호 확인
	@RequestMapping(value = "idPwCheck.do", method = RequestMethod.POST)
	public String idPwCheck(@RequestParam("email") String uemail, @RequestParam("pw") String upw, Model model) {
		model.addAttribute("email", uemail);
		model.addAttribute("pw", upw);

		ProgUserBean pu = puService.userCheck(uemail, upw);
		
		if (pu != null) {
			model.addAttribute("name", pu.getUname());
			model.addAttribute("phone", pu.getUphone());
			model.addAttribute("photo", pu.getuPhoto());
			model.addAttribute("title", "메인 화면");
			return "successView";
		}
		return "failView";
	}
	

	// 이메일 중복 체크
	@RequestMapping("idCheck.do")
	@ResponseBody
	public ResponseEntity<String> userEmailCheck(String email) {
		String checkMsg = "<font color='blue'>사용 가능한 ID 입니다.</font>";
		// String pu = ;//DB 확인 로직
		if (puService.userEmailCheck(email) != null) {// 이미 해당 id가 존재하는 조건식
			checkMsg = "<font color='red'>중복된 이메일입니다. 다시 입력해주세요.</font>";
		}
		// 한글 응답에 따른 설정
		/*
		 * ResponseEntity("응답데이터", http프로토콜설정정보를스펙에맞게추가설정(한글인코딩), 정상응답메시지) 참고 -
		 * 404 : 요청한 url에 해당하는 로직이 없음에 대한 응답 코드 - 500 : 서버 시스템 또는 서버 app~ 오류에 대한
		 * 응답 코드 - 200 : 정상 응답에 대한 코드 = HttpStatus.OK 동급으로 간주
		 */
		HttpHeaders resHeader = new HttpHeaders();
		resHeader.add("Content-Type", "text/html;charset=UTF-8");
		ResponseEntity resultMsg = new ResponseEntity<String>(checkMsg,
				resHeader, HttpStatus.OK);

		return resultMsg;
	}

	// 회원가입
	@RequestMapping(value = "insert.do", method = RequestMethod.POST)
	@ResponseBody
	public String insert(@RequestParam("email2") String uemail, @RequestParam("name") String uname,
			@RequestParam("pw2") String upw, @RequestParam("phone") String uphone, Model model) {
		// System.out.println("Eee");
		String resultMsg = "signInFail";// 저장 실패시 응답되는 데이터
		System.out.println(uname);

		int result = puService.userSignIn(new ProgUserBean(uemail, uname, upw, uphone));
		if (result > 0) {
			model.addAttribute("email2", uemail);
			model.addAttribute("name", uname);
			resultMsg = "ok";// 정상 저장시 응답되는 데이터
		}
		System.out.println("result////////////////////////////////////" + resultMsg);
		return resultMsg;
	}

/*	// 개인 정보 변경 페이지로 사용자 정보 넘기기
	@RequestMapping(value = "sendEmail.do", method = RequestMethod.POST)
	public String sendUserEmail(@RequestParam("email") String uemail,
			Model model) {
		ProgUserBean pu = puService.userInfo(uemail);
		model.addAttribute("user", pu);
		return "updateInfo";
	}*/

	// 개인정보 변경
	@RequestMapping(value = "update.do", method = RequestMethod.POST)
	@ResponseBody
	public String updateUser(@RequestParam("email2") String uemail,@RequestParam("name") String uname,
			@RequestParam("pw2") String upw, @RequestParam("phone") String uphone, Model model) {
		String resultMsg = "signInFail";// 저장 실패시 응답되는 데이터
		int result = puService.userUpdateInfo(new ProgUserBean(uemail, uname,
				upw, uphone));
		if (result > 0) {
			model.addAttribute("email2", uemail);
			model.addAttribute("name", uname);
			model.addAttribute("pw2", upw);
			model.addAttribute("phone", uphone);
			model.addAttribute("title", "메인 화면");
			resultMsg = "ok";// 정상 저장시 응답되는 데이터
		}
		return resultMsg;
	}
	

	// 프로필 사진 등록
	@RequestMapping(value = "uPhotoUpload.do", method = RequestMethod.POST)
	@ResponseBody
	public String updateUserPhoto(@RequestParam("file-0")  MultipartFile file, @RequestParam("name") String uemail) {
		String resultMsg = "no";
		String fileName =  uemail;
			   fileName += new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
			   fileName += file.getOriginalFilename();
		
		//김용두 파일 패스
		String filePath1 = "D:/2014KODB/slogProject/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/ProgManager/ProgFile/uphoto/";
		String filePath12 = "C:/Users/Ian/git/LogTeam/ProgManager/WebContent/ProgFile/uphoto";
		//박상태 파일 패스
		String filePath2 = "";
		//황수남 파일 패스
		String filePath3 = "";
		//박다은 파일 패스
		String filePath4 = "C:\2014KODB/KODBFinalProject/GitTest/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/ProgManager/ProgFile/uphoto/";
		try{
			//폴더에 파일 저장
			file.transferTo(new File(filePath1+fileName));
			int result = puService.userPhoto(new ProgUserPhotoBean(uemail, "./ProgFile/uphoto/"+fileName));
			if(result>0)
				resultMsg = "ok";
		}catch(Exception e){
			e.printStackTrace();
		}
		return resultMsg;
	}

	// 회원 탈퇴
	@RequestMapping(value = "delete.do", method = RequestMethod.POST)
	@ResponseBody
	public String deleteUser(@RequestParam("email2") String uemail,
			@RequestParam("pw2") String upw, Model model) {
		String resultMsg = "signInFail";// 저장 실패시 응답되는 데이터
		int result = puService.userDelete(new ProgUserBean(uemail, upw));
		
		if (result > 0) {
			model.addAttribute("email2", uemail);
			model.addAttribute("pw2", upw);
			model.addAttribute("title", "메인 화면");
			resultMsg = "ok";// 정상 저장시 응답되는 데이터
		}
		return resultMsg;
	}

	// 개인정보 변경 취소
	@RequestMapping(value = "cancel.do", method = RequestMethod.POST)
	public String cancelUpdate(@RequestParam("oldemail") String uemail,
			Model model) {
		System.out.println("수정하기 취소");
		ProgUserBean pu = puService.userInfo(uemail);
		model.addAttribute("email", uemail);
		model.addAttribute("name", pu.getUname());
		model.addAttribute("pw", pu.getUpw());
		model.addAttribute("phone", pu.getUphone());
		model.addAttribute("title", "메인 화면");
		return "successView";
	}

}
