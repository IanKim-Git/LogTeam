package model.service;

import java.util.List;

import javax.annotation.Resource;

import model.dao.ProjectDAO;
import model.domain.ProgUserBean;
import model.domain.ProjectBean;
import model.domain.UserProjectBean;

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
	
	public boolean joinProject(int pnum, String ppw, String uemail){
		if(projectDao.checkProNumAndPass(pnum,ppw)){
			if(newParticipation(uemail, pnum)>0)
				return true;
			else
				return false;
		}else{
			return false;
		}
	}
	
	//프로젝트 참여하기
	public int newParticipation(String email, int pnum){
		return projectDao.newParticipation(email, pnum);
	}
	
	//유저 emial을 통하여 참여한 프로젝트 리스트 불러오기
	public List getProjectList(String uemail) {
		System.out.println("////////////////////////////////getproject list service//////////////////////////////");
		return projectDao.getProjectList(uemail);
	}
	
	public ProjectBean getProjectInfo(int pnum){
		System.out.println("////////////////////////////////getproject info service//////////////////////////////");
		return projectDao.getProject(pnum);
	}
	
	public String getProjectDate(int pnum){
		System.out.println("////////////////////////////////getproject info service//////////////////////////////");
		return projectDao.getProjectDate(pnum);
	}
	//프로젝트 정보 변경
	public int projectUpdateInfo(ProjectBean pb) {
		return projectDao.projectUpdateInfo(pb);
	}
	//프로젝트 삭제
	public int projectDelete(int pnum) {
		return projectDao.projectDelete(pnum);
	}
	//프로젝트 리더 가져오기
	public String getProjectLeader(int pnum) {
		return projectDao.getProjectLeader(pnum);
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
