package com.sbs.untact.dto;

public class Req {
	private Member loginedMember;

	public Req(Member loginedMember) {
		this.loginedMember = loginedMember;
	}

	public boolean isLogined() {
		return false;
	}

	public boolean isNotLogined() {
		return isLogined() == false;
	}

	public int getLoginedMemberId() {
		if (isNotLogined())
			return 0;

		return loginedMember.getId();
	}

	public Member getLoginedMember() {
		return loginedMember;
	}

	public String getLoginedMemberNickname() {
		if (isNotLogined())
			return "";

		return loginedMember.getNickname();
	}
}