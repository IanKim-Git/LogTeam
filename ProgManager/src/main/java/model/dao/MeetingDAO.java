package model.dao;

import java.util.List;

import model.domain.MeetingBean;
import model.domain.ScheduleBean;

import org.apache.ibatis.session.SqlSession;

import util.DBUtil;

public class MeetingDAO {
	
	public int deleteMeeting(int snum) {
		SqlSession session = null;
		int result=0; 
		try{
			session = DBUtil.getSqlSession();
			result=session.delete("prog.deleteMeeting", snum);
			session.commit();
		}finally{
			DBUtil.closeSqlSession(session);
		}
		return result;
	}
	public static List<ScheduleBean> getMeeting(String pnum){
		
		SqlSession session = null;
		List<ScheduleBean> list = null;
		try{
			session = DBUtil.getSqlSession();
			list = session.selectList("prog.getMeeting", pnum);
		}finally{
			DBUtil.closeSqlSession(session);
		}
		return list;
	}

	public int sendMeeting(MeetingBean meetingBean) {
		
		meetingBean=convertType(meetingBean);
		
		int result=0;
		SqlSession session = null;
		 
		try{
			session = DBUtil.getSqlSession();
			result = session.insert("prog.insertMeeting", meetingBean);
			session.commit();
		}finally{
			DBUtil.closeSqlSession(session);
		}
		return result;
	}
	
	public int checkUpdate(MeetingBean meetingBean) {
		meetingBean=convertType(meetingBean);
		SqlSession session=null;
		int result=0;
		try{
			session = DBUtil.getSqlSession();
			result = session.selectOne("prog.checkUpdate", meetingBean);
			if(result!=0){
//				result=session.delete("prog.deleteMeetingBean", meetingBean.getSnum());
				session.commit();
			}
		}finally{
			DBUtil.closeSqlSession(session);
		}
		return result;
	}
	
	public MeetingBean convertType(MeetingBean meetingBean){
		String date = meetingBean.getMdate();
		String[] dateList = date.split(" ");
		
		System.out.println("!!!!!!!!!!!!!List"+dateList);
		date=dateList[3].substring(2)+"/"+convertMonth(dateList[1])+"/"+dateList[2]+" "+dateList[4]+":"+dateList[5]+":"+dateList[6];
		meetingBean.setMdate(date);
		
		return meetingBean;
	}

	
	public String convertMonth(String dateList){
		switch(dateList){
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
