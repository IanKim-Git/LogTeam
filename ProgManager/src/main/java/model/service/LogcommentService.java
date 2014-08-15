package model.service;

import java.util.List;

import javax.annotation.Resource;

import model.dao.LogcommentDAO;
import model.domain.LogcommentBean;

public class LogcommentService {
	@Resource(name="lcDao")
	private LogcommentDAO lcDao;
	
	public int lcWrite(LogcommentBean lcb){
		return lcDao.lcWrite(lcb);
	}
	
	public List<LogcommentBean> allLcs(LogcommentBean lcb){
		return lcDao.allLcs(lcb);
	}
	
	public List<LogcommentBean> allPlcs(int c_l_pnum){
		return lcDao.allPlcs(c_l_pnum);
	}
	
	public int lcDelete(int cnum){
		return lcDao.lcDelete(cnum);
	}
}
