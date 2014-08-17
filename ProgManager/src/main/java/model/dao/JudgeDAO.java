package model.dao;

import java.util.List;

import model.domain.JudgeBean;

import org.apache.ibatis.session.SqlSession;

import util.DBUtil;

public class JudgeDAO {
	//평가 반영
	public int evaluation(JudgeBean jb){
		SqlSession session = null;
		boolean flag = false;
		int result = 0;
		try {
			session = DBUtil.getSqlSession();
			result = session.insert("prog.evaluation", jb);
			flag = result > 0 ? true : false;
		} finally {
			DBUtil.closeSqlSession(flag, session);
		}
		return result;
	}
	
	//현재 해당 로그를 평가하는 사람이 이전에 평가를 했는지 확인
	public String dupCheck(JudgeBean jb){
		SqlSession session = null;
		String ju = null;
		try {
			session = DBUtil.getSqlSession();
			ju = session.selectOne("prog.dupCheck", jb);
		} finally {
			DBUtil.closeSqlSession(session);
		}
		return ju;
	}
	
	//해당 프로젝트의 유저의 평가 점수 반환
	public int getScores(String l_uemail){
		SqlSession session = null;
		List<Integer> list = null;
		int sum =  0;
		try {
			session = DBUtil.getSqlSession();
			list = session.selectList("prog.getScores", l_uemail);
			for(int i : list){
				sum += i;
			}
			
		} finally {
			DBUtil.closeSqlSession(session);
		}
		return sum;
	}
	
	//단위 테스트
/*	public static void main(String [] args){
		JudgeDAO jd = new JudgeDAO();
//		insert into judge (j_uemail, j_lnum, jscore, j_l_pnum)
//		values (#{j_uemail}, #{j_lnum}, #{jscore}, #{j_l_pnum})
//		jd.evaluation(new JudgeBean("a@a.a", 2, -1, 1));
//		jd.evaluation(new JudgeBean("t@t.t", 1, -1, 1));
//		select j_uemail from judge where j_lnum=#{j_lnum} and j_uemail=#{j_uemail}
		if(jd.dupCheck(new JudgeBean(2, "a@a.a")) != null){
			System.out.println("이미 평가하셨습니다.");
		}
		int scores = jd.getScores("t@t.t");
		System.out.println("t@t.t의 평가 점수 : " + scores);
	}*/
}
