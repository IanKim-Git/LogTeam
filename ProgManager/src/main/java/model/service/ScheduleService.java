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
		return scheduleDao.getSchedule(pnum);
	}

	public int sendSchedule(ScheduleBean scheBean) {
		return scheduleDao.sendSchedule(scheBean);
	}
	public int deleteSchedule(int snum) {
		System.out.println("/////////deleteSchedule service/////");
		return scheduleDao.deleteSchedule(snum);
	}

	public int checkUpdate(ScheduleBean scheBean) {
		return scheduleDao.checkUpdate(scheBean);
	}

}