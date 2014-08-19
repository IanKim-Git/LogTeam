package model.dao;

import java.util.List;

import model.domain.LogBean;

import org.apache.ibatis.session.SqlSession;

import util.DBUtil;

public class LogDAO {
	//해당 프로젝트에 있는 모든 로그 출력
	public List<LogBean> allLogs(int l_pnum) {
		SqlSession session = null;
		List<LogBean> list = null;
		try {
			session = DBUtil.getSqlSession();
			list = session.selectList("prog.allLogs", l_pnum);
			
		} finally {
			DBUtil.closeSqlSession(session);
		}
		return list;
	}
	
	//해당 로그 삭제
	public int logDelete(int lnum) {
		SqlSession session = null;
		boolean flag = false;
		int result = 0;
		try {
			session = DBUtil.getSqlSession();
			result = session.delete("prog.logDelete", lnum);
			flag = result > 0 ? true : false;
		} finally {
			DBUtil.closeSqlSession(flag, session);
		}
		return result;
	}
	
	//로그 작성 : only text
	public int logWrite(LogBean lb) {
		SqlSession session = null;
		boolean flag = false;
		int result = 0;
		try {
			session = DBUtil.getSqlSession();
			result = session.insert("prog.logWrite", lb);
			flag = result > 0 ? true : false;
		} finally {
			DBUtil.closeSqlSession(flag, session);
		}
		return result;
	}
	
	//로그 작성 : with photo
	public int logWritePhoto(LogBean lb) {
		SqlSession session = null;
		boolean flag = false;
		int result = 0;
		System.out.println("################################# 이미지 : "+lb.getLphoto());
		try {
			session = DBUtil.getSqlSession();
			result = session.insert("prog.logWritePhoto", lb);
			flag = result > 0 ? true : false;
		} finally {
			DBUtil.closeSqlSession(flag, session);
		}
		return result;
	}
	
	//로그 작성 : with file
	public int logWriteFile(LogBean lb) {
		SqlSession session = null;
		boolean flag = false;
		int result = 0;
		System.out.println("################################# 파일 : "+lb.getLfile());
		try {
			session = DBUtil.getSqlSession();
			result = session.insert("prog.logWriteFile", lb);
			flag = result > 0 ? true : false;
		} finally {
			DBUtil.closeSqlSession(flag, session);
		}
		return result;
	}
	
	//로그 작성 : with photo file
	public int logWritePhotoFile(LogBean lb) {
		SqlSession session = null;
		boolean flag = false;
		int result = 0;
		System.out.println("################################# 이미지 : "+lb.getLphoto());
		System.out.println("################################# 파일 : "+lb.getLfile());
		try {
			session = DBUtil.getSqlSession();
			result = session.insert("prog.logWritePhotoFile", lb);
			flag = result > 0 ? true : false;
		} finally {
			DBUtil.closeSqlSession(flag, session);
		}
		return result;
	}
		
	
	//단위 테스트
	/*public static void main(String[] args){
		LogDAO ld = new LogDAO();
//		ld.logDelete(25);
		
//		 insert into log(lnum, l_pnum, l_uemail, ldata, ltext, lpublic, ladmission)
//		values(seq_l.nextval , #{l_pnum}, #{l_uemail}, sysdate, #{ltext}, #{lpublic}, 0)
		 
		ld.logWrite(new LogBean(2, "t@t.t", "test contents lpublic", 1));
		List<LogBean> lb = ld.allLogs(2);
		for(LogBean l : lb){
			System.out.println(l);
		}
		
	}*/
}
