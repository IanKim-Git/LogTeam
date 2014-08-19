package model.domain;

public class ScheduleBean {
	int pnum;
	int snum;
	String sdate;
	String stext;
	
	public ScheduleBean() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ScheduleBean(int pnum, int snum, String sdate, String stext) {
		super();
		this.pnum = pnum;
		this.snum = snum;
		this.sdate = sdate;
		this.stext = stext;
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

	public String getStext() {
		return stext;
	}

	public void setStext(String stext) {
		this.stext = stext;
	}

	@Override
	public String toString() {
		return "ScheduleBean [pnum=" + pnum + ", snum=" + snum + ", sdate="
				+ sdate + ", stext=" + stext + "]";
	}
	
	
}
