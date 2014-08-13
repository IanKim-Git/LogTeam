package model.service;

import java.util.List;

import javax.annotation.Resource;

import model.dao.AnnouncementDAO;
import model.domain.AnnouncementBean;

public class AnnouncementService {
	@Resource(name="anDao")
	private AnnouncementDAO anDao;
	
	public List<AnnouncementBean> allAns(int an_pnum) {
		return anDao.allAns(an_pnum);
	}
	
	public int anWrite(AnnouncementBean ab) {
		return anDao.anWrite(ab);
	}
	
	public int anDelete(int annum) {
		return anDao.anDelete(annum);
	}
}
