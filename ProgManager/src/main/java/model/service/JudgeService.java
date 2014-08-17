package model.service;

import java.util.List;

import javax.annotation.Resource;

import model.dao.JudgeDAO;
import model.domain.JudgeBean;

public class JudgeService {
	@Resource(name="judgeDao")
	private JudgeDAO judgeDao;
	
	public int evaluation(JudgeBean jb){
		return judgeDao.evaluation(jb);
	}
	
	public String dupCheck(JudgeBean jb){
		return judgeDao.dupCheck(jb);
	}
	
	public int getScores(String l_uemail){
		return judgeDao.getScores(l_uemail);
	}
	
	public List<Integer> dupJudgeCheck(JudgeBean jb){
		return judgeDao.dupJudgeCheck(jb);
	}
	
	public List<JudgeBean> judgeList(int j_l_pnum){
		return judgeDao.judgeList(j_l_pnum);
	}
}
