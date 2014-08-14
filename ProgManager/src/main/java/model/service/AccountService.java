package model.service;

import java.util.List;

import javax.annotation.Resource;

import model.dao.AccountDAO;
import model.domain.AccountBean;

public class AccountService {
	@Resource(name="acDao")
	private AccountDAO acDao;
	
	public List<AccountBean> allAcs(int ac_pnum) {
		return acDao.allAcs(ac_pnum);
	}
	
	public int acTotal(int ac_pnum){
		return acDao.allAcplus(ac_pnum) - acDao.allAcminus(ac_pnum);
	}
	
	public int acWrite(AccountBean acb){
		return acDao.acWrite(acb);
	}
	
	public int acDelete(int acnum){
		return acDao.acDelete(acnum);
	}
}
