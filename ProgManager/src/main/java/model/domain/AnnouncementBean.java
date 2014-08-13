package model.domain;

public class AnnouncementBean {
	private int annum;
	private int an_pnum;
	private String andate;
	private String an_uemail;
	private String ancontent;
	private int animportance;
	
	public AnnouncementBean() {}

	public AnnouncementBean(int annum, int an_pnum, String andate, String an_uemail, String ancontent, int animportance) {
		this.annum = annum;
		this.an_pnum = an_pnum;
		this.andate = andate;
		this.an_uemail = an_uemail;
		this.ancontent = ancontent;
		this.animportance = animportance;
	}

	public AnnouncementBean(int an_pnum, String an_uemail, String ancontent, int animportance) {
		this.an_pnum = an_pnum;
		this.an_uemail = an_uemail;
		this.ancontent = ancontent;
		this.animportance = animportance;
	}

	public int getAnnum() {
		return annum;
	}
	public void setAnnum(int annum) {
		this.annum = annum;
	}
	public int getAn_pnum() {
		return an_pnum;
	}
	public void setAn_pnum(int an_pnum) {
		this.an_pnum = an_pnum;
	}
	public String getAndate() {
		return andate;
	}
	public void setAndate(String andate) {
		this.andate = andate;
	}
	public String getAn_uemail() {
		return an_uemail;
	}
	public void setAn_uemail(String an_uemail) {
		this.an_uemail = an_uemail;
	}
	public String getAncontent() {
		return ancontent;
	}
	public void setAncontent(String ancontent) {
		this.ancontent = ancontent;
	}
	public int getAnimportance() {
		return animportance;
	}
	public void setAnimportance(int animportance) {
		this.animportance = animportance;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder("AnnouncementBean [annum=");
		builder.append(annum);
		builder.append(", an_pnum=");
		builder.append(an_pnum);
		builder.append(", andate=");
		builder.append(andate);
		builder.append(", an_uemail=");
		builder.append(an_uemail);
		builder.append(", ancontent=");
		builder.append(ancontent);
		builder.append(", animportance=");
		builder.append(animportance);
		builder.append("]");
		return builder.toString();
	}
	
	
	
	
}
