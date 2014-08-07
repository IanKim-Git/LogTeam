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
	
	/*public static void main(String[] args) {
		ProgUserService p = new ProgUserService();
		System.out.println(p.userCheck("pst5400@naver.com", "1234"));
	}*/
}
