package com.sbs.untact.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sbs.untact.dto.Article;
import com.sbs.untact.service.ArticleService;

@Controller
public class UsrHomeController {
	@Autowired
	private ArticleService articleService;

	@RequestMapping("/usr/home/main")
	public String showMain(HttpServletRequest req) {
		
		int boardId = -1;
		String searchKeywordType = null;
		String searchKeyword = null;
		int page = 1;
		int itemsInAPage = 10;
		
		List<Article> articles = articleService.getForPrintArticles(boardId, searchKeywordType, searchKeyword, page,
				itemsInAPage);

		req.setAttribute("articles", articles);
		
		return "usr/home/main";
	}
}
