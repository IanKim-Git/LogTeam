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
			System.out.println(list.toString());
		}finally{
			DBUtil.closeSqlSession(session);
		}
		return list;
	}

	public int sendSchedule(ScheduleBean scheBean) {
		
		String sdate = scheBean.getSdate();
		String edate = scheBean.getEdate();
		System.out.println("!!!!!!sdate"+sdate);
		String[] sdateList = sdate.split(" ");
		String[] edateList = edate.split(" ");
		
		System.out.println("!!!!!!!!!!!!!List"+sdateList);

		sdate=sdateList[3].substring(2)+"/"+convertMonth(sdateList[1])+"/"+sdateList[2];
		edate=edateList[3].substring(2)+"/"+convertMonth(edateList[1])+"/"+edateList[2];

		scheBean.setSdate(sdate);
		scheBean.setEdate(edate);
		
		System.out.println("이야아아아아아ㅏ아아아아아압!!!!!!!!!!!"+sdate);
		int result=0;
		SqlSession session = null;
		 
		try{
			session = DBUtil.getSqlSession();
			result = session.insert("prog.insertSchedule", scheBean);
			session.commit();
		}finally{
			DBUtil.closeSqlSession(session);
		}
		return result;
	}
	public String convertMonth(String sdateList){
		switch(sdateList){
		case "Jan":
			return "01";
		case "Feb":
			return "02";
		case "Mar":
			return "03";
		case "Apr":
			return "04";
		case "May":
			return "05";
		case "Jun":
			return "06";
		case "Jul":
			return "07";
		case "Aug":
			return "08";
		case "Seb":
			return "09";
		case "Oct":
			return "10";
		case "Nob":
			return "11";
		case "Dec":
			return "12";
		}
		return null;
	}
}
