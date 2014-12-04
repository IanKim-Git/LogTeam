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
	public int deleteMeeting(int mnum) {
		return meetingDao.deleteMeeting(mnum);
	}

	public int checkUpdate(MeetingBean meetingBean) {
		return meetingDao.checkUpdate(meetingBean);
	}
	public List<MeetingBean> getProjectList(String pnum) {
		// TODO Auto-generated method stub
		return meetingDao.getMeetingList(pnum);
	}
	public int updateMeeting(MeetingBean meetingBean) {
		return meetingDao.updateMeeting(meetingBean);
	}


}