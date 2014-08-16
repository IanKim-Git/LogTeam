package model.domain;

public class ProgUserPhotoBean {
	
	private String uemail;
	private String uphoto;
	public ProgUserPhotoBean() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ProgUserPhotoBean(String uemail, String uphoto) {
		super();
		this.uemail = uemail;
		this.uphoto = uphoto;
	}
	public String getUemail() {
		return uemail;
	}
	public void setUemail(String uemail) {
		this.uemail = uemail;
	}
	public String getuphoto() {
		return uphoto;
	}
	public void setuphoto(String uphoto) {
		this.uphoto = uphoto;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ProgUserPhotoBean [uemail=");
		builder.append(uemail);
		builder.append(", uPhoto=");
		builder.append(uphoto);
		builder.append("]");
		return builder.toString();
	}
	
	

}
