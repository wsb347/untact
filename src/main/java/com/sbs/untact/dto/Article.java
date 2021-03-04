package com.sbs.untact.dto;

import java.util.HashMap;
import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Article {
	private int id;
	private int boardId;
	private String regDate;
	private String updateDate;
	private int memberId;
	private String title;
	private String body;
	
	private String extra_writer;
	private String extra_boardName;
	private String extra__thumbImg;
	
	private Map<String, Object> extra;

	public Map<String, Object> getExtraNotNull() {
		if ( extra == null ) {
			extra = new HashMap<String, Object>();
		}

		return extra;
	}

}
