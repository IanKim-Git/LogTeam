package model.domain;

import java.util.Date;

public class MeetingBean {
	int mnum;   //모임번호
	int mpnum;	//프로젝트번호
	String mdate;	//일시
	String mplace;	//장소명  => description
	String mLongi;
	String mLati;
	String mcontent;		//모임내용 => mtitle
	Date temp;
	public MeetingBean() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MeetingBean(int mnum, int mpnum, String mdate, String mplace,
			String mLongi, String mLati, String mcontent, Date temp) {
		super();
		this.mnum = mnum;
		this.mpnum = mpnum;
		this.mdate = mdate;
		this.mplace = mplace;
		this.mLongi = mLongi;
		this.mLati = mLati;
		this.mcontent = mcontent;
		this.temp = temp;
	}
	public int getMnum() {
		return mnum;
	}
	public void setMnum(int mnum) {
		this.mnum = mnum;
	}
	public int getMpnum() {
		return mpnum;
	}
	public void setMpnum(int mpnum) {
		this.mpnum = mpnum;
	}
	public String getMdate() {
		return mdate;
	}
	public void setMdate(String mdate) {
		this.mdate = mdate;
	}
	public String getMplace() {
		return mplace;
	}
	public void setMplace(String mplace) {
		this.mplace = mplace;
	}
	public String getmLongi() {
		return mLongi;
	}
	public void setmLongi(String mLongi) {
		this.mLongi = mLongi;
	}
	public String getmLati() {
		return mLati;
	}
	public void setmLati(String mLati) {
		this.mLati = mLati;
	}
	public String getMcontent() {
		return mcontent;
	}
	public void setMcontent(String mcontent) {
		this.mcontent = mcontent;
	}
	public Date getTemp() {
		return temp;
	}
	public void setTemp(Date temp) {
		this.temp = temp;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("MeetingBean [mnum=");
		builder.append(mnum);
		builder.append(", mpnum=");
		builder.append(mpnum);
		builder.append(", mdate=");
		builder.append(mdate);
		builder.append(", mplace=");
		builder.append(mplace);
		builder.append(", mLongi=");
		builder.append(mLongi);
		builder.append(", mLati=");
		builder.append(mLati);
		builder.append(", mcontent=");
		builder.append(mcontent);
		builder.append(", temp=");
		builder.append(temp);
		builder.append("]");
		return builder.toString();
	}
	

}