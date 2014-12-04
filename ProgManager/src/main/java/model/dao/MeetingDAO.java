package model.dao;

import java.util.List;

import model.domain.MeetingBean;
import model.domain.ScheduleBean;

import org.apache.ibatis.session.SqlSession;

import util.DBUtil;

public class MeetingDAO {
	
	public int deleteMeeting(int mnum) {
		SqlSession session = null;
		int result=0; 
		try{
			session = DBUtil.getSqlSession();
			result=session.delete("prog.deleteMeeting", mnum);
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
		//meetingBean=convertType(meetingBean);
		SqlSession session=null;
		int result=0;
		try{
			session = DBUtil.getSqlSession();
			result = session.selectOne("prog.checkUpdate2", meetingBean);
			if(result!=0){
				result=session.delete("prog.deleteMeeting", meetingBean.getMnum());
				session.commit();
			}
		}finally{
			DBUtil.closeSqlSession(session);
		}
		return result;
	}
	
	public MeetingBean convertType(MeetingBean meetingBean){
		
		String mdate = meetingBean.getMdate();
		String[] mdateList = mdate.split(" ");
		//mdate = "to_date('"+mdateList[3]+"-"+convertMonth(mdateList[1])+"-"+mdateList[2]+" "+mdateList[4].substring(0,5)+"','yyyy-mm-dd hh24:mi')";
	//	mdate=mdateList[3].substring(2)+"/"+convertMonth(mdateList[1])+"/"+mdateList[2]+" "+mdateList[4]+":00";
		//mdate=mdateList[3]+"/"+convertMonth(mdateList[1])+"/"+mdateList[2]+" "+mdateList[4]+":00";
		//mdate=mdateList[3]+"-"+convertMonth(mdateList[1])+"-"+mdateList[2]+" "+mdateList[4]+":00";
		mdate =mdateList[3]+"-"+convertMonth(mdateList[1])+"-"+mdateList[2]+" "+mdateList[4].substring(0,5);

/*		SimpleDateFormat SDformat = new SimpleDateFormat("yyyy-MM-dd HH24:mm:ss");
		try {
			meetingBean.setTemp(SDformat.parse(mdate));
			System.out.println(meetingBean.getTemp());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		System.out.println(mdate);
		meetingBean.setMdate(mdate);
		
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
		case "Nov":
			return "11";
		case "Dec":
			return "12";
		}
		return null;
	}
	public List<MeetingBean> getMeetingList(String pnum) {
		SqlSession session = null;
		List<MeetingBean> list = null;
		try{
			session = DBUtil.getSqlSession();
			list = session.selectList("prog.getMeeting", pnum);
		}finally{
			DBUtil.closeSqlSession(session);
		}
		return list;
	}
	public int updateMeeting(MeetingBean meetingBean) {
		meetingBean=convertType(meetingBean);
		
		int result=0;
		SqlSession session = null;
		 
		try{
			session = DBUtil.getSqlSession();
			result = session.insert("prog.updateMeeting", meetingBean);
			session.commit();
		}finally{
			DBUtil.closeSqlSession(session);
		}
		return result;
	}
}
