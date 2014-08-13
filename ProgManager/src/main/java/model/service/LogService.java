package model.service;

import java.util.List;

import javax.annotation.Resource;

import model.dao.LogDAO;
import model.domain.LogBean;

public class LogService {
	@Resource(name="logDao")
	private LogDAO logDao;
	//해당 프로젝트의 모든 로그 목록
	public List<LogBean> allLogs(int l_pnum){
		return logDao.allLogs(l_pnum);
	}
	
	//로그 삭제
	public int logDelete(int lnum){
		return logDao.logDelete(lnum);
	}
	
	public int logWrite(LogBean lb){
		return logDao.logWrite(lb);
	}
}
