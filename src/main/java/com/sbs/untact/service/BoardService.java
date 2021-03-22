package com.sbs.untact.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.untact.dao.BoardDao;
import com.sbs.untact.dto.Board;
import com.sbs.untact.dto.ResultData;
import com.sbs.untact.util.Util;

@Service
public class BoardService {
	@Autowired
	private BoardDao boardDao;

	public List<Board> getForPrintBoards(String searchKeywordType, String searchKeyword, int page, int itemsInAPage) {

		int limitStart = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;

		List<Board> boards = boardDao.getForPrintBoards(searchKeywordType, searchKeyword, limitStart, limitTake);

		return boards;
	}

	public ResultData modifyBoard(Map<String, Object> param) {
		boardDao.modifyBoard(param);

		int id = Util.getAsInt(param.get("id"), 0);

		return new ResultData("S-1", "게시판을 수정하였습니다.", "id", id);

	}

	public Board getForPrintBoard(Integer id) {
		return boardDao.getForPrintBoard(id);
	}

	public Board getBoard(Integer id) {
		return boardDao.getBoard(id);
	}

	public Board getMemberByName(String name) {
		return boardDao.getMemberByName(name);
	}
}
