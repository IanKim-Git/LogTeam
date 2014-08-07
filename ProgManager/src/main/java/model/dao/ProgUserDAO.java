package model.dao;

import model.domain.ProgUserBean;

import org.apache.ibatis.session.SqlSession;

import util.DBUtil;

public class ProgUserDAO {
	//로그인 할 때 아이디와 비밀번호 체크
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
	}
	
	
/*	public static void main(String[] args) {
//		ProgUserDAO p = new ProgUserDAO();
//		System.out.println(p.userIdPwCheck("pst5400@naver.com", "1234"));
		System.out.println(userIdPwCheck("pst5400@naver.com", "1234"));
	}*/
}
