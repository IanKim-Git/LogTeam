package model.domain;

public class UserProjectBean {
	private String up_uemail;
	private int up_pnum;
	private int upclick;
	public UserProjectBean() {
		super();
		// TODO Auto-generated constructor stub
	}
	public UserProjectBean(String up_uemail, int up_pnum) {
		super();
		this.up_uemail = up_uemail;
		this.up_pnum = up_pnum;
	}
	public UserProjectBean(String up_uemail, int up_pnum, int upclick) {
		super();
		this.up_uemail = up_uemail;
		this.up_pnum = up_pnum;
		this.upclick = upclick;
	}
	public String getUp_uemail() {
		return up_uemail;
	}
	public void setUp_uemail(String up_uemail) {
		this.up_uemail = up_uemail;
	}
	public int getUp_pnum() {
		return up_pnum;
	}
	public void setUp_pnum(int up_pnum) {
		this.up_pnum = up_pnum;
	}
	public int getUpclick() {
		return upclick;
	}
	public void setUpclick(int upclick) {
		this.upclick = upclick;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("UserProjectBean [up_uemail=");
		builder.append(up_uemail);
		builder.append(", up_pnum=");
		builder.append(up_pnum);
		builder.append(", upclick=");
		builder.append(upclick);
		builder.append("]");
		return builder.toString();
	}
	
	
}
