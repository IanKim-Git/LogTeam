package model.dao;

import java.util.List;

import model.domain.ProgUserBean;
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
	
	//날짜 계산
		public static String getProjectDate(int pnum){
			SqlSession session = null;
			String projectbean = null;
			try{
				session = DBUtil.getSqlSession();
				projectbean = session.selectOne("prog.getProjectDate", pnum);
			}finally{
				DBUtil.closeSqlSession(session);
			}
			return projectbean;
		}
		
		// 프로젝트 정보 변경
		public int projectUpdateInfo(ProjectBean pb) {
			SqlSession session = null;
			boolean flag = false;
			int result = 0;
			try {
				session = DBUtil.getSqlSession();
				result = session.update("prog.projectUpdate", pb);
				flag = result > 0 ? true : false;

			} finally {
				DBUtil.closeSqlSession(flag, session);
			}
			return result;
		}
		
		// 프로젝트 삭제
		public int projectDelete(int pnum) {
			SqlSession session = null;
			boolean flag = false;
			int result = 0;
			try {
				session = DBUtil.getSqlSession();
				result = session.delete("prog.deleteProject", pnum);
				flag = result > 0 ? true : false;

			} finally {
				DBUtil.closeSqlSession(flag, session);
			}
			return result;
		}
		
		public String getProjectLeader(int pnum) {
			SqlSession session = null;
			String leader = null;
			try {
				session = DBUtil.getSqlSession();
				leader = session.selectOne("prog.getProjectLeader", pnum);
			} finally {
				DBUtil.closeSqlSession(session);
			}
			return leader;
		}
	
	//pnum과 ppw받아서 있는 프로젝트인지 확인하기
	public static boolean checkProNumAndPass(int pnum, String ppw){
		SqlSession session = null;
		ProjectBean projectbean = null;
		try{
			session = DBUtil.getSqlSession();
			projectbean = session.selectOne("prog.checkProValid", new ProjectBean(pnum,ppw));
		}finally{
			DBUtil.closeSqlSession(session);
		}
		if(projectbean!=null){
			projectbean = null;
			return true;
		}else{
			return false;
		}
	}
	
	//프로젝트 삭제하기
	public static boolean deleteProject(){
		
		return true;
	}
	
	//프로젝트 종료하기
	public static boolean endProject(){
		
		return true;
	}
	
//	public static void main(String[] args) {
//		ProgUserDAO p = new ProgUserDAO();
//		System.out.println(p.userIdPwCheck("pst5400@naver.com", "1234"));
//		System.out.println(getProjectList().toString());
//	}
}
