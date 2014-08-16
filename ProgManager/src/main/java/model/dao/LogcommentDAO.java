package model.dao;

import java.util.List;

import model.domain.LogcommentBean;

import org.apache.ibatis.session.SqlSession;

import util.DBUtil;

public class LogcommentDAO {
	//코멘트 등록하기(해당 프로젝트의 로그에 코멘트 작성)
	public int lcWrite(LogcommentBean lcb){
		SqlSession session = null;
		boolean flag = false;
		int result = 0;
		try {
			session = DBUtil.getSqlSession();
			result = session.insert("prog.lcWrite", lcb);
			flag = result > 0 ? true : false;
		} finally {
			DBUtil.closeSqlSession(flag, session);
		}
		return result;
	}
	
	//해당 프로젝트의 로그의 코멘트 전부 불러오기
	public List<LogcommentBean> allLcs(LogcommentBean lcb){
		SqlSession session = null;
		List<LogcommentBean> list = null;
		try {
			session = DBUtil.getSqlSession();
			list = session.selectList("prog.allLcs", lcb);
			
		} finally {
			DBUtil.closeSqlSession(session);
		}
		return list;
	}
	
	//해당 프로젝트의 로그의 코멘트 전부 불러오기
	public List<LogcommentBean> allPlcs(int c_l_pnum){
		SqlSession session = null;
		List<LogcommentBean> list = null;
		try {
			session = DBUtil.getSqlSession();
			list = session.selectList("prog.allPlcs", c_l_pnum);
			
		} finally {
			DBUtil.closeSqlSession(session);
		}
		return list;
	}
	
	//자신의 코멘트 삭제(코멘트 번호)
	public int lcDelete(int cnum){
		SqlSession session = null;
		boolean flag = false;
		int result = 0;
		try {
			session = DBUtil.getSqlSession();
			result = session.delete("prog.lcDelete", cnum);
			flag = result > 0 ? true : false;
		} finally {
			DBUtil.closeSqlSession(flag, session);
		}
		return result;
	}
	
	//단위 테스트
/*	public static void main(String [] args){
		LogcommentDAO lcd = new LogcommentDAO();
//		insert into logcomment (c_lnum, cnum, cdate, c_uemail, ctext, c_l_pnum)
//		values(#{c_lnum}, seq_c.nextval, sysdate, #{c_uemail}, #{ctext}, #{c_l_pnum})
//		lcd.lcWrite(new LogcommentBean(2, "c@c.c", 2, "첫 덧글이다"));
//		lcd.lcWrite(new LogcommentBean(2, "c@c.c", 2, "두 번째 덧글이다"));
//		lcd.lcWrite(new LogcommentBean(2, "c@c.c", 2, "세 번째 덧글이다"));
//		lcd.lcWrite(new LogcommentBean(3, "c@c.c", 2, "coco"));
//		lcd.lcWrite(new LogcommentBean(3, "c@c.c", 2, "coco2"));
//		lcd.lcWrite(new LogcommentBean(4, "c@c.c", 2, "coco3"));
//		lcd.lcWrite(new LogcommentBean(4, "c@c.c", 2, "coco4"));
//		select * from logcomment where c_lnum=#{c_lnum} and c_l_pnum=#{c_l_pnum} order by cdate
		for(LogcommentBean lcb : lcd.allPlcs(2)){
			System.out.println(lcb);
		}
//		lcd.lcDelete(25);
//		lcd.lcDelete(26);
		
	}*/
}
