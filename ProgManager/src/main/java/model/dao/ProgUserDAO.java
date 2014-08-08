package model.dao;

import java.util.List;

import model.domain.ProgUserBean;

import org.apache.ibatis.session.SqlSession;

import util.DBUtil;

public class ProgUserDAO {
	//로그인 할 때 아이디와 비밀번호가 테이블에 존재하는지 체크
	public ProgUserBean userIdPwCheck(String uemail, String upw) {
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
	
	// 회원 가입
	public int userSignIn(ProgUserBean pu) {
		SqlSession session = null;
		boolean flag = false;
		int result = 0;
		try {
			session = DBUtil.getSqlSession();
//			if(uphone == null || uphone.equals("")){
				result = session.insert("progUser.signIn", pu);				
//			}else{
//				result = session.insert("progUser.signIn", pu);
//			}
			flag = result > 0 ? true : false;
		} finally {
			DBUtil.closeSqlSession(flag, session);
		}
		return result;
	}
	
	// 회원 가입 시 이메일 중복 체크
	public String userIdCheck(String uemail) {
		SqlSession session = null;
		String id = null;
		try{
			session = DBUtil.getSqlSession();
			id = session.selectOne("progUser.IdCheck", uemail);
		}finally{
			DBUtil.closeSqlSession(session);
		}
		return id;
	}
	
	//모든 회원 정보
	public List<ProgUserBean> allUsers() {
		SqlSession session = null;
		List<ProgUserBean> list = null;
		try {
			session = DBUtil.getSqlSession();
			list = session.selectList("progUser.allUsers");
		} finally {
			DBUtil.closeSqlSession(session);
		}
		return list;
	}
	
/*	public static void main(String[] args) {
		ProgUserDAO p = new ProgUserDAO();
		int result = 0;
		System.out.println("### 로그인 테스트 ###");
		System.out.println(p.userIdPwCheck("a@a.a", "1234"));
		
		System.out.println("### 회원가입 테스트 ###");
		//new ProgUserBean(uemail, uname, upw)
		//new ProgUserBean(uemail, uname, upw, uphone)
//		insert into proguser(uemail, uname, upw, uphone) values(#{uemail} , #{uname} , #{upw}, #{uphone})
//		result = p.userSignIn("d@d.d", "박다은", "1234", null);
//		result = p.userSignIn("e@e.e", "박소현", "1234", "");
//		result = p.userSignIn(new ProgUserBean("f@f.f", "박상준", "1234", "000-0000-0000"));
//		result = p.userSignIn(new ProgUserBean("g@g.g", "박상준", "1234", ""));
		if(result > 0){
			System.out.println("회원가입 성공");
		}else{
			System.out.println("회원가입 실패");
		}
		System.out.println("### 모든 사용자 출력 테스트 ###");
		List<ProgUserBean> au = p.allUsers();
		for(ProgUserBean pu : au){
			System.out.println(pu);
		}
		
		System.out.println("### 이메일 중복 테스트 ###");
		System.out.println(p.userIdCheck("zz"));
	}*/
}
