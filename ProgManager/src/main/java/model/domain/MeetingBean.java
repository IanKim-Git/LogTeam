package model.domain;

public class MeetingBean {
	int mnum;   //모임번호
	int mpnum;	//프로젝트번호
	String mdate;	//일시
	String mplace;	//장소명  => description
	String mpoint;	//장소좌표 => null
	String mcontent;		//모임내용 => mtitle
	public MeetingBean() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MeetingBean(int mnum, int mpnum, String mdate, String mplace,
			String mpoint, String mcontent) {
		super();
		this.mnum = mnum;
		this.mpnum = mpnum;
		this.mdate = mdate;
		this.mplace = mplace;
		this.mpoint = mpoint;
		this.mcontent = mcontent;
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
	public String getMpoint() {
		return mpoint;
	}
	public void setMpoint(String mpoint) {
		this.mpoint = mpoint;
	}
	public String getMcontent() {
		return mcontent;
	}
	public void setMcontent(String mcontent) {
		this.mcontent = mcontent;
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
		builder.append(", mpoint=");
		builder.append(mpoint);
		builder.append(", mcontent=");
		builder.append(mcontent);
		builder.append("]");
		return builder.toString();
	}
	
	
}
