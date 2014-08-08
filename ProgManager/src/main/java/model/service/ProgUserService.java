package model.service;

import javax.annotation.Resource;

import model.dao.ProgUserDAO;
import model.domain.ProgUserBean;

public class ProgUserService {
	@Resource(name="puDao")
	private ProgUserDAO puDao;
	
	//로그인 할 때 아이디(이메일)와 이메일 체크 후 결과 반환
	public ProgUserBean userCheck(String uemail, String upw){
		return puDao.userIdPwCheck(uemail, upw);
	}
	
	//회원가입 후 결과 반환
	public int userSignIn(ProgUserBean pu){
		return puDao.userSignIn(pu);
	}
	
	//이메일 중복 체크 결과 반환
	public String userEmailCheck(String uemail){
		return puDao.userIdCheck(uemail);
	}
	
	/*public static void main(String[] args) {
		ProgUserService p = new ProgUserService();
		System.out.println(p.userCheck("pst5400@naver.com", "1234"));
	}*/
}
