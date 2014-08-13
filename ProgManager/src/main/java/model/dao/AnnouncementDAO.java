package model.dao;

import java.util.List;

import model.domain.AnnouncementBean;

import org.apache.ibatis.session.SqlSession;

import util.DBUtil;

public class AnnouncementDAO {
	//해당 프로젝트의 공지사항 불러오기	
	public List<AnnouncementBean> allAns(int an_pnum) {
		SqlSession session = null;
		List<AnnouncementBean> list = null;
		try {
			session = DBUtil.getSqlSession();
			list = session.selectList("prog.allAns", an_pnum);
			
			
		} finally {
			DBUtil.closeSqlSession(session);
		}
		return list;
	}
		
	//공지사항 작성
	public int anWrite(AnnouncementBean ab) {
		SqlSession session = null;
		boolean flag = false;
		int result = 0;
		try {
			session = DBUtil.getSqlSession();
			result = session.insert("prog.anWrite", ab);
			flag = result > 0 ? true : false;
		} finally {
			DBUtil.closeSqlSession(flag, session);
		}
		return result;
	}
		
	//공지사항 삭제
	public int anDelete(int annum) {
		SqlSession session = null;
		boolean flag = false;
		int result = 0;
		try {
			session = DBUtil.getSqlSession();
			result = session.delete("prog.anDelete", annum);
			flag = result > 0 ? true : false;
		} finally {
			DBUtil.closeSqlSession(flag, session);
		}
		return result;
	}	 
	
	//단위테스트
/*	public static void main(String[] args){
		
		insert into announcement(annum, an_pnum, andate, an_uemail, ancontent, animportance)
			values(seq_an.nextval , #{an_pnum}, sysdate, ,#{an_uemail}, #{ancontent}, #{animportance})
		 
		AnnouncementDAO ad = new AnnouncementDAO();
//		ad.anWrite(new AnnouncementBean(2, "t@t.t", "notice1", 1));
//		ad.anWrite(new AnnouncementBean(2, "t@t.t", "notice2", 1));
//		ad.anWrite(new AnnouncementBean(2, "t@t.t", "notice3", 1));
//		ad.anWrite(new AnnouncementBean(2, "t@t.t", "공지사항4", 1));
//		ad.anDelete(2);
//		ad.anDelete(3);
//		ad.anDelete(4);
//		ad.anDelete(9);
//		ad.anDelete(7);
//		ad.anDelete(8);
		List<AnnouncementBean> ab = ad.allAns(2);
		for(AnnouncementBean temp : ab){
			System.out.println(temp);
		}
	}*/
}
