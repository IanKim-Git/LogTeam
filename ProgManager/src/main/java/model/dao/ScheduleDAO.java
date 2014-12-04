package model.dao;

import java.util.List;

import model.domain.ProgUserBean;
import model.domain.ProjectBean;
import model.domain.ScheduleBean;
import model.domain.UserProjectBean;

import org.apache.ibatis.session.SqlSession;

import util.DBUtil;

public class ScheduleDAO {
	
	public int deleteSchedule(int snum) {
		SqlSession session = null;
		int result=0;
		try{
			session = DBUtil.getSqlSession();
			result=session.delete("prog.deleteSchedule", snum);
			session.commit();
		}finally{
			DBUtil.closeSqlSession(session);
		}
		return result;
	}
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

	public int sendSchedule(ScheduleBean scheBean) {
		
		String sdate = scheBean.getSdate();
		String edate = scheBean.getEdate();
		String[] sdateList = sdate.split(" ");
		String[] edateList = edate.split(" ");
		
		System.out.println(sdate);
		
		sdate=sdateList[3].substring(2)+"/"+convertMonth(sdateList[1])+"/"+sdateList[2];
		edate=edateList[3].substring(2)+"/"+convertMonth(edateList[1])+"/"+edateList[2];

		scheBean.setSdate(sdate);
		scheBean.setEdate(edate);
		
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
	public int updateSchedule(ScheduleBean scheBean) {
		String sdate = scheBean.getSdate();
		String edate = scheBean.getEdate();
		String[] sdateList = sdate.split(" ");
		String[] edateList = edate.split(" ");
		
		sdate=sdateList[3].substring(2)+"/"+convertMonth(sdateList[1])+"/"+sdateList[2];
		edate=edateList[3].substring(2)+"/"+convertMonth(edateList[1])+"/"+edateList[2];

		scheBean.setSdate(sdate);
		scheBean.setEdate(edate);
		
		int result=0;
		SqlSession session = null;
		
		try{
			session = DBUtil.getSqlSession();
			result = session.update("prog.updateSchedule", scheBean);
			session.commit();
		}finally{
			DBUtil.closeSqlSession(session);
		}
		return result;
	}
	
	public int checkUpdate(ScheduleBean scheBean) {
		//scheBean=convertType(scheBean);
		SqlSession session=null;
		int result=0;
		try{
			session = DBUtil.getSqlSession();
			result = session.selectOne("prog.checkUpdate", scheBean);
			if(result!=0){
				result=session.delete("prog.deleteSchedule", scheBean.getSnum());
				session.commit();
			}
		}finally{
			DBUtil.closeSqlSession(session);
		}
		return result;
	}
	public ScheduleBean convertType(ScheduleBean scheBean){
		String sdate = scheBean.getSdate();
		String edate = scheBean.getEdate();
		String[] sdateList = sdate.split(" ");
		String[] edateList = edate.split(" ");
		
		sdate=sdateList[3].substring(2)+"/"+convertMonth(sdateList[1])+"/"+sdateList[2];
		edate=edateList[3].substring(2)+"/"+convertMonth(edateList[1])+"/"+edateList[2];

		scheBean.setSdate(sdate);
		scheBean.setEdate(edate);
		
		return scheBean;
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
		case "Nov":
			return "11";
		case "Dec":
			return "12";
		}
		return null;
	}

}
