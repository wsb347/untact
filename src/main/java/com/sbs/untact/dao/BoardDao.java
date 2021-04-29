package com.sbs.untact.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.untact.dto.Board;

@Mapper
public interface BoardDao {

	List<Board> getForPrintBoards(@RequestParam(value = "searchKeywordType") String searchKeywordType,
			@RequestParam(value = "searchKeyword") String searchKeyword,
			@RequestParam(value = "limitStart") int limitStart, @RequestParam(value = "limitTake") int limitTake);

	void modifyBoard(Map<String, Object> param);

	Board getForPrintBoard(@RequestParam(value = "id") Integer id);

	Board getBoard(@RequestParam(value = "id") Integer id);

	Board getMemberByName(@RequestParam(value = "name") String name);

	Board getMemberByCode(@RequestParam(value = "code") String code);

	void addBoard(Map<String, Object> param);

	int getBoardTotalCount(Integer id);

	void deleteBoard(Integer id);

	void modifyBoardIdByArticle(Integer id);

}
