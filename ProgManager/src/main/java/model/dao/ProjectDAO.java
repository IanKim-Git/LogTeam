package model.dao;

import java.util.List;

import model.domain.ProjectBean;
import model.domain.UserProjectBean;

import org.apache.ibatis.session.SqlSession;

import util.DBUtil;

public class ProjectDAO {
	
	//프로젝트 추가하는 메소드
	public static int newProject(String pname, String ppw, String pmento, String pstart, String pend, String pleader, int pterminate){
		SqlSession session = null;
		int result=0;
		int pnum=0;
		ProjectBean pu = new ProjectBean(pname,ppw,pmento,pstart,pend,pleader,pterminate);

		try{
			session = DBUtil.getSqlSession();
			result = session.insert("prog.newProject", pu);
			session.commit();
			pnum = session.selectOne("prog.getProjectNumber", pu);
			session.commit();
			System.out.println("/////////////////////////////"+result+"////"+pnum+"///////////////////////////////");
		}finally{
			DBUtil.closeSqlSession(session);
		}
		if(result!=0)
			return pnum;
		else
			return result;
	}
	
	public static int newParticipation(String up_uemail, int up_pnum){
		SqlSession session = null;
		int result;
		System.out.println("dao new parti///////////////////////////" + up_uemail+"  "+up_pnum);
		try{
			session = DBUtil.getSqlSession();
			result = session.insert("prog.newParticipation", new UserProjectBean(up_uemail, up_pnum));
			session.commit();
		}finally{
			DBUtil.closeSqlSession(session);
		}
		return result;
	}
	
	//프로젝트 리스트 불러오기
	public static List<ProjectBean> getProjectList(String uemail){		
		SqlSession session = null;
		List<ProjectBean> plist = null;
		try {
			session = DBUtil.getSqlSession();
			plist = session.selectList("prog.SelectAllProject", uemail);
			//System.out.println(plist.toString());
		} finally {
			DBUtil.closeSqlSession(session);
		}
		return plist;
	}
	
	//해당 프로젝트 불러오기
	public static ProjectBean getProject(int pnum){
		SqlSession session = null;
		ProjectBean projectbean = null;
		try{
			session = DBUtil.getSqlSession();
			projectbean = session.selectOne("prog.getProjectInfo", pnum);
		}finally{
			DBUtil.closeSqlSession(session);
		}
		return projectbean;
	}
	
	//프로젝트 삭제하기
	public static boolean deleteProject(){
		
		return true;
	}
	
	//프로젝트 종료하기
	public static boolean endProject(){
		
		return true;
	}
	
	
	/*//로그인 할 때 아이디와 비밀번호 체크
	public static ProgUserBean userIdPwCheck(String uemail, String upw) {
		SqlSession session = null;
		ProgUserBean pu = null;
		try{
			session = DBUtil.getSqlSession();
			pu = session.selectOne("progUser.IdPwCheck", new ProgUserBean(uemail, upw));
		}finally{
			DBUtil.closeSqlSession(session);
		}
		return pu;
	}*/
	
	
//	public static void main(String[] args) {
//		ProgUserDAO p = new ProgUserDAO();
//		System.out.println(p.userIdPwCheck("pst5400@naver.com", "1234"));
//		System.out.println(getProjectList().toString());
//	}
}
