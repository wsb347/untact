package com.sbs.untact.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.untact.dto.Board;
import com.sbs.untact.dto.Member;
import com.sbs.untact.service.BoardService;
import com.sbs.untact.util.Util;

@Controller
public class AdmBoardController extends BaseController {
	@Autowired
	private BoardService boardService;
	
	@RequestMapping("/adm/board/list")
	public String showList(HttpServletRequest req,
			String searchKeywordType, String searchKeyword, @RequestParam(defaultValue = "1") int page) {

		if (searchKeywordType != null) {
			searchKeywordType = searchKeywordType.trim();
		}

		if (searchKeywordType == null || searchKeywordType.length() == 0) {
			searchKeywordType = "nameAndCode";
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

		int itemsInAPage = 20;

		List<Board> boards = boardService.getForPrintBoards(searchKeywordType, searchKeyword, page,
				itemsInAPage);

		req.setAttribute("boards", boards);

		return "adm/board/list";
	}
	
	@RequestMapping("/adm/board/modify")
	public String showModify(Integer id, HttpServletRequest req) {
		if (id == null) {
			return msgAndBack(req, "id를 입력해주세요.");
		}

		Board board = boardService.getForPrintBoard(id);

		req.setAttribute("board", board);

		if (board == null) {
			return msgAndBack(req, "존재하지 않는 게시물번호 입니다.");
		}

		return "adm/board/modify";
	}

	@RequestMapping("/adm/board/doModify")
	public String doModify(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		int id = Util.getAsInt(param.get("id"), 0);

		if (id == 0) {
			return msgAndBack(req, "id를 입력해주세요.");
		}

		Board board = boardService.getBoard(id);

		if (board == null) {
			return msgAndBack(req, "해당 게시물은 존재하지 않습니다.");
		}

		boardService.modifyBoard(param);

		return msgAndReplace(req, String.format("%s 게시물이 수정되었습니다.", param.get("name")),
				"../board/list?id=" + id);
	}

}
