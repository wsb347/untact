package com.sbs.untact.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {
	private int id;
	private String regDate;
	private String updateDate;
	private String loginId;
	@JsonIgnore
	private String loginPw;
	@JsonIgnore
	private int authLevel;
	@JsonIgnore
	private String authKey;
	private String nickname;
	private String name;
	private String cellphoneNo;
	private String email;

	public String getAuthLevelName() {
		return "일반회원";
	}

}
