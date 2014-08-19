package model.domain;

public class ProjectBean {
	private int pnum;
	private String pname;
	private String ppw;
	private String pmento;
	private String pstart;
	private String pend;
	private String pleader;
	private int pterminate;
	
	public ProjectBean() {
		super();
	}
	
	public ProjectBean(int pnum, String ppw) {
		super();
		this.pnum = pnum;
		this.ppw = ppw;
	}
	
	public ProjectBean(String pname, String ppw, String pstart, String pend, int pnum) {
		super();
		this.pname = pname;
		this.ppw = ppw;
		this.pstart = pstart;
		this.pend = pend;
		this.pnum = pnum;
	}

	public ProjectBean(int pnum, String pname, String ppw, String pstart,
			String pleader, int pterminate) {
		super();
		this.pnum = pnum;
		this.pname = pname;
		this.ppw = ppw;
		this.pstart = pstart;
		this.pleader = pleader;
		this.pterminate = pterminate;
	}
	
	public ProjectBean(String pname, String ppw, String pmento, String pstart,
			String pend, String pleader, int pterminate) {
		super();
		this.pname = pname;
		this.ppw = ppw;
		this.pmento = pmento;
		this.pstart = pstart;
		this.pend = pend;
		this.pleader = pleader;
		this.pterminate = pterminate;
	}
	public ProjectBean(int pnum, String pname, String ppw, String pmento,
			String pstart, String pleader, int pterminate) {
		super();
		this.pnum = pnum;
		this.pname = pname;
		this.ppw = ppw;
		this.pmento = pmento;
		this.pstart = pstart;
		this.pleader = pleader;
		this.pterminate = pterminate;
	}
	public ProjectBean(String pname, int pnum, String ppw, String pstart,
			String pend, String pleader, int pterminate) {
		super();
		this.pnum = pnum;
		this.pname = pname;
		this.ppw = ppw;
		this.pstart = pstart;
		this.pend = pend;
		this.pleader = pleader;
		this.pterminate = pterminate;
	}
	public ProjectBean(int pnum, String pname, String ppw, String pmento,
			String pstart, String pend, String pleader, int pterminate) {
		super();
		this.pnum = pnum;
		this.pname = pname;
		this.ppw = ppw;
		this.pmento = pmento;
		this.pstart = pstart;
		this.pend = pend;
		this.pleader = pleader;
		this.pterminate = pterminate;
	}
	
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getPpw() {
		return ppw;
	}
	public void setPpw(String ppw) {
		this.ppw = ppw;
	}
	public String getPmento() {
		return pmento;
	}
	public void setPmento(String pmento) {
		this.pmento = pmento;
	}
	public String getPstart() {
		return pstart;
	}
	public void setPstart(String pstart) {
		this.pstart = pstart;
	}
	public String getPend() {
		return pend;
	}
	public void setPend(String pend) {
		this.pend = pend;
	}
	public String getPleader() {
		return pleader;
	}
	public void setPleader(String pleader) {
		this.pleader = pleader;
	}
	public int getPterminate() {
		return pterminate;
	}
	public void setPterminate(int pterminate) {
		this.pterminate = pterminate;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ProjectBean [pnum=");
		builder.append(pnum);
		builder.append(", pname=");
		builder.append(pname);
		builder.append(", ppw=");
		builder.append(ppw);
		builder.append(", pmento=");
		builder.append(pmento);
		builder.append(", pstart=");
		builder.append(pstart);
		builder.append(", pend=");
		builder.append(pend);
		builder.append(", pleader=");
		builder.append(pleader);
		builder.append(", pterminate=");
		builder.append(pterminate);
		builder.append("]");
		return builder.toString();
	}
	
}
