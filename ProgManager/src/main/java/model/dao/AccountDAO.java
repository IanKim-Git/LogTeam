package model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import util.DBUtil;
import model.domain.AccountBean;
import model.domain.AnnouncementBean;

public class AccountDAO {
	// 회계 등록 : 소득 -> 소득[지출]을 작성할 때, 소득[지출]에 값이 입력되었을 때 지출[소득] 부분은 비활성화
	public int acWrite(AccountBean acb){
		SqlSession session = null;
		boolean flag = false;
		int result = 0;
		try {
			session = DBUtil.getSqlSession();
			result = session.insert("prog.acWrite", acb);
			flag = result > 0 ? true : false;
		} finally {
			DBUtil.closeSqlSession(flag, session);
		}
		return result;
	}
	
	//회계 목록 출력
	public List<AccountBean> allAcs(int ac_pnum) {
		SqlSession session = null;
		List<AccountBean> list = null;
		try {
			session = DBUtil.getSqlSession();
			list = session.selectList("prog.allAcs", ac_pnum);
			
			
		} finally {
			DBUtil.closeSqlSession(session);
		}
		return list;
	}
	
	// 소득만 출력
	public int allAcplus(int ac_pnum){
		SqlSession session = null;
		List<Integer> list = null;
		int sumPlus =  0;
		try {
			session = DBUtil.getSqlSession();
			list = session.selectList("prog.allAcplus", ac_pnum);
			for(int i : list){
				sumPlus += i;
			}
			
		} finally {
			DBUtil.closeSqlSession(session);
		}
		return sumPlus;
	}
	
	// 지출만 출력
	public int allAcminus(int ac_pnum){
		SqlSession session = null;
		List<Integer> list = null;
		int sumMinus =  0;
		try {
			session = DBUtil.getSqlSession();
			list = session.selectList("prog.allAcminus", ac_pnum);
			for(int i : list){
				sumMinus += i;
			}
			
		} finally {
			DBUtil.closeSqlSession(session);
		}
		return sumMinus;
	}
	
	// 회계 삭제
	public int acDelete(int acnum){
		SqlSession session = null;
		boolean flag = false;
		int result = 0;
		try {
			session = DBUtil.getSqlSession();
			result = session.delete("prog.acDelete", acnum);
			flag = result > 0 ? true : false;
		} finally {
			DBUtil.closeSqlSession(flag, session);
		}
		return result;
	}
	
	//단위 테스트
/*	public static void main(String[] args){
//		insert into account (ac_pnum, acnum, acplus, acminus, accontents)
//		values (#{ac_pnum}, seq_ac.nextval, #{acplus}, #{acminus}, #{accontents})
		AccountDAO acd = new AccountDAO();
//		acd.acWrite(new AccountBean(2, 300000, 0, ));
//		acd.acWrite(new AccountBean(2, 0, 20000, "식사"));
//		acd.acWrite(new AccountBean(2, 0, 2000, "교통비"));
//		acd.acWrite(new AccountBean(2, 30000, 0, "식사 지원비"));
//		acd.acWrite(new AccountBean(2, "교통비3", 0, 2000));
		
		
		System.out.println("소득 총액 : " + acd.allAcplus(2));
		System.out.println("지출 총액 : " + acd.allAcminus(2));
				
		for(AccountBean acb : acd.allAns(2)){
			System.out.println(acb);
		}
		
//		acd.acDelete(24);
//		
//		System.out.println("소득 총액 : " + acd.allAcplus(2));
//		System.out.println("지출 총액 : " + acd.allAcminus(2));
//				
//		for(AccountBean acb : acd.allAns(2)){
//			System.out.println(acb);
//		}
	}*/
}
