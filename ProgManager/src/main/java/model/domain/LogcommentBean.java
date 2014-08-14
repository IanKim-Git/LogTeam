package model.domain;

public class LogcommentBean {
	private int c_lnum;
	private int cnum;
	private String cdate;
	private String c_uemail;
	private String ctext;
	private int c_l_pnum;
	
	public LogcommentBean() {}
	public LogcommentBean(int c_lnum, int c_l_pnum) {
		this.c_lnum = c_lnum;
		this.c_l_pnum = c_l_pnum;
	}
	public LogcommentBean(int c_lnum, int cnum, String cdate, String c_uemail, String ctext, int c_l_pnum) {
		this.c_lnum = c_lnum;
		this.cnum = cnum;
		this.cdate = cdate;
		this.c_uemail = c_uemail;
		this.ctext = ctext;
		this.c_l_pnum = c_l_pnum;
	}
	
	public LogcommentBean(int c_lnum, String c_uemail, String ctext, int c_l_pnum) {
		this.c_lnum = c_lnum;
		this.c_uemail = c_uemail;
		this.ctext = ctext;
		this.c_l_pnum = c_l_pnum;
	}
	public int getC_lnum() {
		return c_lnum;
	}
	public void setC_lnum(int c_lnum) {
		this.c_lnum = c_lnum;
	}
	public int getCnum() {
		return cnum;
	}
	public void setCnum(int cnum) {
		this.cnum = cnum;
	}
	public String getCdate() {
		return cdate;
	}
	public void setCdate(String cdate) {
		this.cdate = cdate;
	}
	public String getC_uemail() {
		return c_uemail;
	}
	public void setC_uemail(String c_uemail) {
		this.c_uemail = c_uemail;
	}
	public String getCtext() {
		return ctext;
	}
	public void setCtext(String ctext) {
		this.ctext = ctext;
	}
	public int getC_l_num() {
		return c_l_pnum;
	}
	public void setC_l_pnum(int c_l_pnum) {
		this.c_l_pnum = c_l_pnum;
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder("LogcommentBean [c_lnum=");
		builder.append(c_lnum);
		builder.append(", cnum=");
		builder.append(cnum);
		builder.append(", cdate=");
		builder.append(cdate);
		builder.append(", c_uemail=");
		builder.append(c_uemail);
		builder.append(", ctext=");
		builder.append(ctext);
		builder.append(", c_l_pnum=");
		builder.append(c_l_pnum);
		builder.append("]");
		return builder.toString();
	}
}
