package rereply;

import java.sql.Timestamp;

public class RereplyBean {
	private int idx;
	private int br_idx;
	private int rp_idx;
	private String content;
	private Timestamp regtime;
	private String id;
	private String nickname;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getBr_idx() {
		return br_idx;
	}
	public void setBr_idx(int br_idx) {
		this.br_idx = br_idx;
	}
	public int getRp_idx() {
		return rp_idx;
	}
	public void setRp_idx(int rp_idx) {
		this.rp_idx = rp_idx;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getRegtime() {
		return regtime;
	}
	public void setRegtime(Timestamp regtime) {
		this.regtime = regtime;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	} 
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
}
