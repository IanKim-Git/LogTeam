package model.service;

import java.util.List;

import javax.annotation.Resource;

import model.dao.ProgUserDAO;
import model.dao.ProjectDAO;
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
	
	//개인 정보 변경
	public int userUpdateInfo(ProgUserBean pu){
		return puDao.userUpdate(pu);
	}
	
	//개인 정보 반환
	public ProgUserBean userInfo(String uemail){
		return puDao.userInfo(uemail);
	}
	
	//해당 프로젝트에 속한 회원 리스트 반환
	public List projectUserList(int pnum){
		return puDao.allProjectUsers(pnum);
	}
}
