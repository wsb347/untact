package com.sbs.untact.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.untact.dao.ArticleDao;
import com.sbs.untact.dao.MemberDao;
import com.sbs.untact.dto.Article;
import com.sbs.untact.dto.Member;
import com.sbs.untact.dto.ResultData;
import com.sbs.untact.util.Util;

@Service
public class MemberService {
	@Autowired
	private MemberDao memberDao;

	public ResultData memberJoin(Map<String, Object> param) {
		memberDao.memberJoin(param);
		
		return new ResultData("S-1", "성공하였습니다.");
	}

	public static Member doLogin(String loginId, String loginPW) {
		// TODO Auto-generated method stub
		return null;
	}
}
