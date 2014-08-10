package model.service;

import java.util.List;

import javax.annotation.Resource;

import model.dao.ProjectDAO;

public class ProjectService {
	
	@Resource(name="projectDao")
	private ProjectDAO projectDao;
	
	//프로젝트 새로 만들기
	public int newProject(String pname, String ppw, String pmento, String pstart, String pend, String pleader, int pterminate) {
		int pnum;
		pnum = projectDao.newProject(pname, ppw, pmento, pstart, pend, pleader, pterminate);
		System.out.println("///////////////////////////////////////"+pnum);
			if(pnum!=0){
				newParticipation(pleader, pnum);
				pnum = 1;
			}
		return pnum;
	}
	
	public int newParticipation(String email, int pnum){
		return projectDao.newParticipation(email, pnum);
	}
	
	public List getProjectList(String uemail) {
		System.out.println("////////////////////////////////getproject list service//////////////////////////////");
		return projectDao.getProjectList(uemail);
	}

}


/*
 * public class ProgUserService {
	@Resource(name="puDao")
	private ProgUserDAO puDao;
	
	//로그인 할 때 아이디(이메일)와 이메일 체크 후 결과 반환
	public ProgUserBean userCheck(String uemail, String upw){
		return puDao.userIdPwCheck(uemail, upw);
	}
 */
