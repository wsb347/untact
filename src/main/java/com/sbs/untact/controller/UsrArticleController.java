package com.sbs.untact.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartRequest;

import com.sbs.untact.dto.Article;
import com.sbs.untact.dto.Board;
import com.sbs.untact.dto.GenFile;
import com.sbs.untact.dto.Member;
import com.sbs.untact.dto.ResultData;
import com.sbs.untact.service.ArticleService;
import com.sbs.untact.service.BoardService;
import com.sbs.untact.service.GenFileService;
import com.sbs.untact.service.MemberService;
import com.sbs.untact.util.Util;

@Controller
public class UsrArticleController extends BaseController {
	@Autowired
	private ArticleService articleService;
	@Autowired
	private GenFileService genFileService;
	@Autowired
	private BoardService boardService;
	@Autowired
	private MemberService memberService;

	@RequestMapping("/usr/article/detail")
	public String showDetail(HttpServletRequest req, Integer id) {
		Article article = articleService.getForPrintArticle(id);

		List<GenFile> files = genFileService.getGenFiles("article", article.getId(), "common", "attachment");

		Map<String, GenFile> filesMap = new HashMap<>();

		for (GenFile file : files) {
			filesMap.put(file.getFileNo() + "", file);
		}

		article.getExtraNotNull().put("file__common__attachment", filesMap);
		req.setAttribute("article", article);

		if (article == null) {
			return msgAndBack(req, "존재하지 않는 번호입니다.");
		}

		return "usr/article/detail";

	}

	@RequestMapping("/usr/article/list")
	public String showList(HttpServletRequest req, Integer boardId, String searchKeywordType, String searchKeyword,
			@RequestParam(defaultValue = "1") Integer page) {

		Board board = boardService.getBoard(boardId);

		if (boardId == null) {
			boardId = -1;
		} else if (board == null) {
			return msgAndBack(req, "존재하지않은 게시판입니다.");
		}

		req.setAttribute("board", board);

		if (searchKeywordType != null) {
			searchKeywordType = searchKeywordType.trim();
		}

		if (searchKeywordType == null || searchKeywordType.length() == 0) {
			searchKeywordType = "titleAndBody";
		}

		if (searchKeyword != null && searchKeyword.length() == 0) {
			searchKeyword = null;
		}

		if (searchKeyword != null) {
			searchKeyword = searchKeyword.trim();
		}

		if (searchKeyword == null) {
			searchKeywordType = null;
		}

		int totalItemsCount = articleService.getArticlesTotalCount(boardId, searchKeywordType, searchKeyword);

		System.out.println("총 게시물 갯수 : " + totalItemsCount);

		int itemsInAPage = 10;
		int totalPage = (int) Math.ceil(totalItemsCount / (double) itemsInAPage);
		int pageMenuArmSize = 5;
		int pageMenuStart = page - pageMenuArmSize;

		if (pageMenuStart < 1) {
			pageMenuStart = 1;
		}

		int pageMenuEnd = page + pageMenuArmSize;
		if (pageMenuEnd > totalPage) {
			pageMenuEnd = totalPage;
		}

		List<Article> articles = articleService.getForPrintArticles(boardId, searchKeywordType, searchKeyword, page,
				itemsInAPage);

		req.setAttribute("totalItemsCount", totalItemsCount);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("page", page);
		req.setAttribute("articles", articles);
		req.setAttribute("pageMenuArmSize", pageMenuArmSize);
		req.setAttribute("pageMenuStart", pageMenuStart);
		req.setAttribute("pageMenuEnd", pageMenuEnd);

		return "usr/article/list";
	}

	@RequestMapping("/usr/article/add")
	public String showAdd(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		return "usr/article/add";
	}

	@RequestMapping("/usr/article/doAdd")
	public String doAdd(@RequestParam Map<String, Object> param, HttpServletRequest req,
			MultipartRequest multipartRequest) {
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");

		if (param.get("title") == null) {
			return msgAndBack(req, "title을 입력해주세요.");
		}

		if (param.get("body") == null) {
			return msgAndBack(req, "body를 입력해주세요.");
		}

		param.put("memberId", loginedMemberId);

		ResultData addArticleRd = articleService.addArticle(param);

		int newArticleId = (int) addArticleRd.getBody().get("id");

		return msgAndReplace(req, String.format("%d번 게시물이 작성되었습니다.", newArticleId),
				"../article/detail?id=" + newArticleId);
	}

	@RequestMapping("/usr/article/doDelete")
	public String doDelete(Integer id, HttpServletRequest req) {
		Member loginedMember = (Member) req.getAttribute("loginedMember");

		if (id == null) {
			return msgAndBack(req, "id를 입력해주세요.");
		}

		Article article = articleService.getArticle(id);

		if (article == null) {
			return msgAndBack(req, "해당 게시물은 존재하지 않습니다.");
		}

		if(loginedMember.getId() != article.getMemberId()) {
			return msgAndBack(req, "작성자만 가능합니다");
		}
		
		ResultData actorCanDeleteRd = articleService.getActorCanDeleteRd(article, loginedMember);

		if (actorCanDeleteRd.isFail()) {
			return msgAndBack(req, "관리자만 가능합니다");
		}

		int boardId = article.getBoardId();

		articleService.deleteArticle(id);

		return msgAndReplace(req, String.format("%d번 게시물이 삭제되었습니다.", id), "../article/list?boardId=" + boardId);
	}

	@RequestMapping("/usr/article/modify")
	public String showModify(Integer id, HttpServletRequest req) {
		if (id == null) {
			return msgAndBack(req, "id를 입력해주세요.");
		}

		Article article = articleService.getForPrintArticle(id);

		List<GenFile> files = genFileService.getGenFiles("article", article.getId(), "common", "attachment");

		Map<String, GenFile> filesMap = new HashMap<>();

		for (GenFile file : files) {
			filesMap.put(file.getFileNo() + "", file);
		}

		article.getExtraNotNull().put("file__common__attachment", filesMap);
		req.setAttribute("article", article);

		if (article == null) {
			return msgAndBack(req, "존재하지 않는 게시물번호 입니다.");
		}

		return "usr/article/modify";
	}

	@RequestMapping("/usr/article/doModify")
	public String doModify(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		Member loginedMember = (Member) req.getAttribute("loginedMember");

		int id = Util.getAsInt(param.get("id"), 0);

		if (id == 0) {
			return msgAndBack(req, "id를 입력해주세요.");
		}

		Article article = articleService.getArticle(id);

		if (article == null) {
			return msgAndBack(req, "해당 게시물은 존재하지 않습니다.");
		}

		ResultData actorCanModifyRd = articleService.getActorCanModifyRd(article, loginedMember);

		if (actorCanModifyRd.isFail()) {
			return msgAndBack(req, "관리자만 가능합니다");
		}

		if(loginedMember.getId() != article.getMemberId()) {
			return msgAndBack(req, "작성자만 가능합니다");
		}
		
		articleService.modifyArticle(param);

		return msgAndReplace(req, String.format("%d번 게시물이 수정되었습니다.", id),
				"../article/list?boardId=" + article.getBoardId());
	}

}
