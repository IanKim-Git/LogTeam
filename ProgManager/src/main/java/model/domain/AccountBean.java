package model.domain;

public class AccountBean {
	private int ac_pnum;
	private int acnum;
	private int acplus;
	private int acminus;
	private String accontents;
	//private ? acphoto;
	
	public AccountBean() {}

	public AccountBean(int ac_pnum, int acnum, int acplus, int acminus, String accontents) {
		this.ac_pnum = ac_pnum;
		this.acnum = acnum;
		this.acplus = acplus;
		this.acminus = acminus;
		this.accontents = accontents;
	}

	public AccountBean(int ac_pnum, String accontents, int acplus, int acminus) {
		this.ac_pnum = ac_pnum;
		this.accontents = accontents;
		this.acplus = acplus;
		this.acminus = acminus;		
	}

	public int getAc_pnum() {
		return ac_pnum;
	}
	public void setAc_pnum(int ac_pnum) {
		this.ac_pnum = ac_pnum;
	}
	public int getAcnum() {
		return acnum;
	}
	public void setAcnum(int acnum) {
		this.acnum = acnum;
	}
	public int getAcplus() {
		return acplus;
	}
	public void setAcplus(int acplus) {
		this.acplus = acplus;
	}
	public int getAcminus() {
		return acminus;
	}
	public void setAcminus(int acminus) {
		this.acminus = acminus;
	}
	public String getAccontents() {
		return accontents;
	}
	public void setAccontents(String accontents) {
		this.accontents = accontents;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder("AccountBean [ac_pnum=");
		builder.append(ac_pnum);
		builder.append(", acnum=");
		builder.append(acnum);
		builder.append(", acplus=");
		builder.append(acplus);
		builder.append(", acminus=");
		builder.append(acminus);
		builder.append(", accontents=");
		builder.append(accontents);
		builder.append("]");
		return builder.toString();
	}
}
