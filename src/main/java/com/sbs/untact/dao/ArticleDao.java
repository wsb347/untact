package com.sbs.untact.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.untact.dto.Article;
import com.sbs.untact.dto.Board;
import com.sbs.untact.dto.Reply;

@Mapper
public interface ArticleDao {
	public Article getArticle(@Param(value = "id") int id);

	public void addArticle(Map<String, Object> param);

	public void deleteArticle(@Param(value = "id") int id);

	public void modifyArticle(Map<String, Object> param);

	public List<Article> getArticles(@Param(value = "searchKeywordType") String searchKeywordType,
			@Param(value = "searchKeyword") String searchKeyword);

	public Article getForPrintArticle(@Param(value = "id") int id);

	public List<Article> getForPrintArticles(@Param(value = "boardId") int boardId, @Param(value = "searchKeywordType") String searchKeywordType,
			@Param(value = "searchKeyword") String searchKeyword, @Param(value = "limitStart") int limitStart,
			@Param(value = "limitTake") int limitTake);

	public Board getBoard(@Param(value = "id") Integer id);

}
