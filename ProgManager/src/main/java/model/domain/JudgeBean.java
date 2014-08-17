package model.domain;

public class JudgeBean {
	private String j_uemail;
	private int j_lnum;
	private int jscore;
	private int j_l_pnum;
	
	public JudgeBean() {}
	public JudgeBean(String j_uemail, int j_lnum, int jscore, int j_l_pnum) {
		this.j_uemail = j_uemail;
		this.j_lnum = j_lnum;
		this.jscore = jscore;
		this.j_l_pnum = j_l_pnum;
	}
	
	public JudgeBean(int j_lnum, String j_uemail) {
		this.j_lnum = j_lnum;
		this.j_uemail = j_uemail;
	}
	public String getJ_uemail() {
		return j_uemail;
	}
	public void setJ_uemail(String j_uemail) {
		this.j_uemail = j_uemail;
	}
	public int getJ_lnum() {
		return j_lnum;
	}
	public void setJ_lnum(int j_lnum) {
		this.j_lnum = j_lnum;
	}
	public int getJscore() {
		return jscore;
	}
	public void setJscore(int jscore) {
		this.jscore = jscore;
	}
	public int getJ_l_pnum() {
		return j_l_pnum;
	}
	public void setJ_l_pnum(int j_l_pnum) {
		this.j_l_pnum = j_l_pnum;
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder("JudgeBean [j_uemail=");
		builder.append(j_uemail);
		builder.append(", j_lnum=");
		builder.append(j_lnum);
		builder.append(", jscore=");
		builder.append(jscore);
		builder.append(", j_l_pnum=");
		builder.append(j_l_pnum);
		builder.append("]");
		return builder.toString();
	}
}
