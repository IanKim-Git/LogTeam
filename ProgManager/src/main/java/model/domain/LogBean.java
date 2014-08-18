package model.domain;

public class LogBean {
	private int lnum;		//not null
	private int l_pnum;		//not null
	private String l_uemail;	//not null
	private String ldata;		//not null
	private String ltext;
	private String lphoto;
	private String lfile;
	private int lpublic;		//not null
	private int ladmission;	//not null
	
	public LogBean() {}
	public LogBean(int lnum, int l_pnum, String l_uemail, String ldata, int lpublic, int ladmission) {
		this.lnum = lnum;
		this.l_pnum = l_pnum;
		this.l_uemail = l_uemail;
		this.ldata = ldata;
		this.lpublic = lpublic;
		this.ladmission = ladmission;
	}
	public LogBean(int lnum, int l_pnum, String l_uemail, String ldata, String ltext, int lpublic, int ladmission) {
		this.lnum = lnum;
		this.l_pnum = l_pnum;
		this.l_uemail = l_uemail;
		this.ldata = ldata;
		this.ltext = ltext;
		this.lpublic = lpublic;
		this.ladmission = ladmission;
	}
	public LogBean(int lnum, int l_pnum, String l_uemail, String ldata, String ltext, int lpublic, int ladmission, String lphoto) {
		this.lnum = lnum;
		this.l_pnum = l_pnum;
		this.l_uemail = l_uemail;
		this.ldata = ldata;
		this.ltext = ltext;
		this.lpublic = lpublic;
		this.ladmission = ladmission;
		this.lphoto = lphoto;
	}
	public LogBean(int lnum, int l_pnum, String l_uemail, String ldata, String ltext, String lphoto, int lpublic, int ladmission) {
		this.lnum = lnum;
		this.l_pnum = l_pnum;
		this.l_uemail = l_uemail;
		this.ldata = ldata;
		this.ltext = ltext;
		this.lphoto = lphoto;
		this.lpublic = lpublic;
		this.ladmission = ladmission;
	}
	public LogBean(int l_pnum, String l_uemail, String ltext) {
		this.l_pnum = l_pnum;
		this.l_uemail = l_uemail;
		this.ltext = ltext;
	}
	public LogBean(int l_pnum, String l_uemail, String ltext, int lpublic) {
		this.l_pnum = l_pnum;
		this.l_uemail = l_uemail;
		this.ltext = ltext;
		this.lpublic = lpublic;
	}
	public LogBean(int l_pnum, String l_uemail, String ltext, int lpublic, String lphoto) {
		this.l_pnum = l_pnum;
		this.l_uemail = l_uemail;
		this.ltext = ltext;
		this.lpublic = lpublic;
		this.lphoto = lphoto;
	}
	public LogBean(int l_pnum, String l_uemail, String ltext, int lpublic, String lphoto, String lfile) {
		this.l_pnum = l_pnum;
		this.l_uemail = l_uemail;
		this.ltext = ltext;
		this.lpublic = lpublic;
		this.lphoto = lphoto;
		this.lfile = lfile;
	}
	
	
	public LogBean(int lnum, String lphoto) {
		this.lnum = lnum;
		this.lphoto = lphoto;
	}
	
	public int getLnum() {
		return lnum;
	}
	public void setLnum(int lnum) {
		this.lnum = lnum;
	}
	public int getL_pnum() {
		return l_pnum;
	}
	public void setL_pnum(int l_pnum) {
		this.l_pnum = l_pnum;
	}
	public String getL_uemail() {
		return l_uemail;
	}
	public void setL_uemail(String l_uemail) {
		this.l_uemail = l_uemail;
	}
	public String getLdata() {
		return ldata;
	}
	public void setLdata(String ldata) {
		this.ldata = ldata;
	}
	public String getLtext() {
		return ltext;
	}
	public void setLtext(String ltext) {
		this.ltext = ltext;
	}
	public int getLpublic() {
		return lpublic;
	}
	public void setLpublic(int lpublic) {
		this.lpublic = lpublic;
	}
	public int getLadmission() {
		return ladmission;
	}
	public void setLadmission(int ladmission) {
		this.ladmission = ladmission;
	}
	public String getLphoto() {
		return lphoto;
	}
	public void setLphoto(String lphoto) {
		this.lphoto = lphoto;
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder("LogBean [lnum=");
		builder.append(lnum);
		builder.append(", l_pnum=");
		builder.append(l_pnum);
		builder.append(", l_uemail=");
		builder.append(l_uemail);
		builder.append(", ldata=");
		builder.append(ldata);
		builder.append(", ltext=");
		builder.append(ltext);
		builder.append(", lphoto=");
		builder.append(lphoto);
		builder.append(", lpublic=");
		builder.append(lpublic);
		builder.append(", ladmission=");
		builder.append(ladmission);
		builder.append("]");
		return builder.toString();
	}
}
