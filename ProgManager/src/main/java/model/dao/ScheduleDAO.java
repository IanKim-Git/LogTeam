package model.dao;

import java.util.List;

import model.domain.ProgUserBean;
import model.domain.ProjectBean;
import model.domain.ScheduleBean;
import model.domain.UserProjectBean;

import org.apache.ibatis.session.SqlSession;

import util.DBUtil;

public class ScheduleDAO {
	
	public static List<ScheduleBean> getSchedule(String pnum){
		
		SqlSession session = null;
		List<ScheduleBean> list = null;
		
		try{
			session = DBUtil.getSqlSession();
			list = session.selectList("prog.getSchedule", pnum);
			
		}finally{
			DBUtil.closeSqlSession(session);
		}
		return list;
	}
	

}
