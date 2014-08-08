package model.domain;

public class ProgUserBean {
	private String uemail;
	private String uname;
	private String upw;
	private String uphone;
//	private ? uPhoto;
	private String uprocnt;
	
	public ProgUserBean() {}
	public ProgUserBean(String uemail, String upw) {
		this.uemail = uemail;
		this.upw = upw;
	}
	//uemail, uname, upw, uphone, uprocnt
	public ProgUserBean(String uemail, String uname, String upw, String uphone) {
		this(uemail, upw);
		this.uname = uname;
		this.uphone = uphone;
	}
	public ProgUserBean(String uemail, String uname, String upw, String uphone, String uprocnt) {
		this(uemail, uname, upw, uphone);
		this.uprocnt = uprocnt;
	}
	
	public String getUemail() {
		return uemail;
	}

	public void setUemail(String uemail) {
		this.uemail = uemail;
	}

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public String getUpw() {
		return upw;
	}

	public void setUpw(String upw) {
		this.upw = upw;
	}

	public String getUphone() {
		return uphone;
	}

	public void setUphone(String uphone) {
		this.uphone = uphone;
	}

	public String getUprocnt() {
		return uprocnt;
	}

	public void setUprocnt(String uprocnt) {
		this.uprocnt = uprocnt;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder("ProgUserBean [uemail=");
		builder.append(uemail);
		builder.append(", uname=");
		builder.append(uname);
		builder.append(", upw=");
		builder.append(upw);
		builder.append(", uphone=");
		builder.append(uphone);
		builder.append(", uprocnt=");
		builder.append(uprocnt);
		builder.append("]");
		return builder.toString();
	}
}
