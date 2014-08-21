package model.domain;

public class ScheduleBean {
	int pnum;
	int snum;
	String sdate;
	String edate;
	String stext;
	String stitle;
	public ScheduleBean() {
		super();
		// TODO Auto-generated constructor stub
	}	
	
	public ScheduleBean(String sdate, String stext, String stitle) {
		super();
		this.sdate = sdate;
		this.stext = stext;
		this.stitle = stitle;
	}
	
	public ScheduleBean(int pnum, int snum, String sdate, String edate,
			String stext, String stitle) {
		super();
		this.pnum = pnum;
		this.snum = snum;
		this.sdate = sdate;
		this.edate = edate;
		this.stext = stext;
		this.stitle = stitle;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public int getSnum() {
		return snum;
	}
	public void setSnum(int snum) {
		this.snum = snum;
	}
	public String getSdate() {
		return sdate;
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}
	public String getEdate() {
		return edate;
	}
	public void setEdate(String edate) {
		this.edate = edate;
	}
	public String getStext() {
		return stext;
	}
	public void setStext(String stext) {
		this.stext = stext;
	}
	public String getStitle() {
		return stitle;
	}
	public void setStitle(String stitle) {
		this.stitle = stitle;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ScheduleBean [pnum=");
		builder.append(pnum);
		builder.append(", snum=");
		builder.append(snum);
		builder.append(", sdate=");
		builder.append(sdate);
		builder.append(", edate=");
		builder.append(edate);
		builder.append(", stext=");
		builder.append(stext);
		builder.append(", stitle=");
		builder.append(stitle);
		builder.append("]");
		return builder.toString();
	}
	
}
