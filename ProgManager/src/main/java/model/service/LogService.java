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
	
	//해당 프로젝트의 공개된 로그와 자신의 비공개 로그 출력 allSelectedLogs
	public List<LogBean> allSelectedLogs(LogBean lb) {
		return logDao.allSelectedLogs(lb);
	}
	
	//로그 삭제
	public int logDelete(int lnum){
		return logDao.logDelete(lnum);
	}
	
	//로그 작성 : only text
	public int logWrite(LogBean lb){
		return logDao.logWrite(lb);
	}
	
	//로그 작성 : with photo
	public int logWritePhoto(LogBean lb) {
		System.out.println("######################## service 이미지 : " + lb.getLphoto());
		return logDao.logWritePhoto(lb);
	}
	
	//로그 작성 : with file
	public int logWriteFile(LogBean lb) {
		System.out.println("######################## service 파일 : " + lb.getLfile());
		return logDao.logWriteFile(lb);
	}
	
	//로그 작성 : with file
	public int logWritePhotoFile(LogBean lb) {
		System.out.println("######################## service 이미지 : " + lb.getLphoto());
		System.out.println("######################## service 파일 : " + lb.getLfile());
		return logDao.logWritePhotoFile(lb);
	}
}
