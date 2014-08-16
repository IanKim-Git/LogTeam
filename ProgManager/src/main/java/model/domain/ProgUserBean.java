package model.domain;

public class ProgUserBean {
	private String uemail;
	private String uname;
	private String upw;
	private String uphone;
	private String uPhoto;
	private String uprocnt;
	
	public ProgUserBean() {}
	public ProgUserBean(String uemail, String upw) {
		this.uemail = uemail;
		this.upw = upw;
	}
	public ProgUserBean(String uemail, String uname, String upw) {
		this(uemail, upw);
		this.uname = uname;
	}	
	public ProgUserBean(String uemail, String uname, String upw, String uphone) {
		this(uemail, uname, upw);
		this.uphone = uphone;
	}	
	public ProgUserBean(String uemail, String uname, String upw, String uphone, String uprocnt) {
		this(uemail, uname, upw, uphone);
		this.uprocnt = uprocnt;
	}
	
	public ProgUserBean(String uemail, String uname, String upw, String uphone,
			String uPhoto, String uprocnt) {
		super();
		this.uemail = uemail;
		this.uname = uname;
		this.upw = upw;
		this.uphone = uphone;
		this.uPhoto = uPhoto;
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
	public String getuPhoto() {
		return uPhoto;
	}
	public void setuPhoto(String uPhoto) {
		this.uPhoto = uPhoto;
	}
	public String getUprocnt() {
		return uprocnt;
	}
	public void setUprocnt(String uprocnt) {
		this.uprocnt = uprocnt;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ProgUserBean [uemail=");
		builder.append(uemail);
		builder.append(", uname=");
		builder.append(uname);
		builder.append(", upw=");
		builder.append(upw);
		builder.append(", uphone=");
		builder.append(uphone);
		builder.append(", uPhoto=");
		builder.append(uPhoto);
		builder.append(", uprocnt=");
		builder.append(uprocnt);
		builder.append("]");
		return builder.toString();
	}
	
	
}
