package model.service;

import java.util.List;

import javax.annotation.Resource;

import model.dao.ScheduleDAO;
import model.domain.ScheduleBean;

public class ScheduleService {
	
	@Resource(name="scheduleDao")
	private ScheduleDAO scheduleDao;
	
	//프로젝트 번호를 이용해서 스케줄 가져오기
	public List getProjectList(String pnum) {
		System.out.println("////////////////////////////////getproject list service//////////////////////////////");
		return scheduleDao.getSchedule(pnum);
	}

	public int sendSchedule(ScheduleBean scheBean) {
		// TODO Auto-generated method stub
		System.out.println("//////////////sendSchedule service/////////////");
		
		return scheduleDao.sendSchedule(scheBean);
		
	}

}