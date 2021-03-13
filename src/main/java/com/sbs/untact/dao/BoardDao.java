package com.sbs.untact.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.untact.dto.Board;

@Mapper
public interface BoardDao {

	List<Board> getForPrintBoards(@RequestParam(value = "searchKeywordType") String searchKeywordType,
			@RequestParam(value = "searchKeyword") String searchKeyword,
			@RequestParam(value = "limitStart") int limitStart, @RequestParam(value = "limitTake") int limitTake);

}
