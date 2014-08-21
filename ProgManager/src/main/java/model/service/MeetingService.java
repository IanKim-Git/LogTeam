package model.service;

import java.util.List;

import javax.annotation.Resource;

import model.dao.MeetingDAO;
import model.domain.MeetingBean;
import model.domain.ScheduleBean;

public class MeetingService {
	
	@Resource(name="meetingDao")
	private MeetingDAO meetingDao;
	
	public int sendMeeting(MeetingBean meetingBean) {
		return meetingDao.sendMeeting(meetingBean);
	}
	public int deleteMeeting(int snum) {
		return meetingDao.deleteMeeting(snum);
	}

	public int checkUpdate(MeetingBean meetingBean) {
		return meetingDao.checkUpdate(meetingBean);
	}


}