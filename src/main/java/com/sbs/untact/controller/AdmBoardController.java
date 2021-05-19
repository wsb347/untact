package com.sbs.untact.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartRequest;

import com.sbs.untact.dto.Board;
import com.sbs.untact.dto.Member;
import com.sbs.untact.dto.ResultData;
import com.sbs.untact.service.BoardService;
import com.sbs.untact.util.Util;

@Controller
public class AdmBoardController extends BaseController {
	@Autowired
	private BoardService boardService;
	
	@RequestMapping("/adm/board/detail")
	public String showDetail(HttpServletRequest req, Integer id) {
		Board board = boardService.getForPrintBoard(id);

		int totalItemsCount = boardService.getBoardTotalCount(id);

		req.setAttribute("totalItemsCount", totalItemsCount);
		
		
		req.setAttribute("board", board);
		
		if (board == null) {
			return msgAndBack(req, "존재하지 않는 번호입니다.");
		}

		return "adm/board/detail";
	}
	
	@RequestMapping("/adm/board/getNameDup")
	@ResponseBody
	public ResultData getNameDup(String name) {
		
		if(name == null) {
			return new ResultData("F-1", "name를 입력해주세요.");
		}
		
		if (Util.allNumberString(name)) {
			return new ResultData("F-3", "게시판이름은 숫자만으로 구성될 수 없습니다.");
		}

		if (name.length() > 20) {
			return new ResultData("F-6", "이름은 20자 이하로 입력해주세요.");
		}

		Board existingBoard = boardService.getMemberByName(name);

		if (existingBoard != null) {
			return new ResultData("F-2", String.format("%s(은)는 이미 사용중인 이름 입니다.", name));
		}
		
		return new ResultData("S-1", String.format("%s(은)는 사용 가능한 이름입니다.", name));
	}
	
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

		int itemsInAPage = 10;

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

		if (param.get("name") == null) {
			return msgAndBack(req, "name를 입력해주세요.");
		}
		
		System.out.println("id : " + param.get("id"));

		Board board = boardService.getBoard(id);

		if (board == null) {
			return msgAndBack(req, "해당 게시물은 존재하지 않습니다.");
		}

		boardService.modifyBoard(param);

		return msgAndReplace(req, id + "번 게시물이 수정되었습니다.",
				"../board/list");
	}

	@RequestMapping("/adm/board/add")
	public String showAdd(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		return "adm/board/add";
	}

	@RequestMapping("/adm/board/doAdd")
	public String doAdd(@RequestParam Map<String, Object> param, HttpServletRequest req,
			MultipartRequest multipartRequest) {
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");

		if (param.get("code") == null) {
			return msgAndBack(req, "code을 입력해주세요.");
		}

		if (param.get("name") == null) {
			return msgAndBack(req, "name를 입력해주세요.");
		}
		
		Board existingBoardByCode = boardService.getMemberByCode((String)param.get("code"));
		
		if (existingBoardByCode != null) {
			return msgAndBack(req, String.format("%s(은)는 이미 사용중인 코드 입니다.", (String)param.get("code")));
		}

		Board existingBoardByName = boardService.getMemberByName((String)param.get("name"));

		if (existingBoardByName != null) {
			return msgAndBack(req, String.format("%s(은)는 이미 사용중인 이름 입니다.", (String)param.get("name")));
		}

		param.put("memberId", loginedMemberId);

		boardService.addboard(param);

		int id = Util.getAsInt(param.get("id"), 0);

		return msgAndReplace(req, String.format("%d번 게시판이 작성되었습니다.", id),
				"../board/list");
	}
	
	@RequestMapping("/adm/board/doDelete")
	public String doDelete(Integer id, HttpServletRequest req) {
		if (id == null) {
			return msgAndBack(req, "id를 입력해주세요.");
		}

		Board board = boardService.getBoard(id);

		if (board == null) {
			return msgAndBack(req, "해당 게시판은 존재하지 않습니다.");
		}

		boardService.modifyBoardIdByArticle(id);
		boardService.deleteBoard(id);

		return msgAndReplace(req, String.format("%d번 게시판이 삭제되었습니다.", id), "../board/list?boardId=" + id);
	}
}
