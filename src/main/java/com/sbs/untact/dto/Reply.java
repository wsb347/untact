package com.sbs.untact.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Reply extends EntityDto{
	private int id;
	private String regDate;
	private String updateDate;
	private int memberId;
	private String body;
}
