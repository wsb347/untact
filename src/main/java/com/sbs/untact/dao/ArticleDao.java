package com.sbs.untact.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.untact.dto.Article;
import com.sbs.untact.dto.Board;

@Mapper
public interface ArticleDao {
	Article getArticle(@Param(value = "id") int id);

	void addArticle(Map<String, Object> param);

	void deleteArticle(@Param(value = "id") int id);

	void modifyArticle(Map<String, Object> param);

	List<Article> getArticles(@Param(value = "searchKeywordType") String searchKeywordType,
			@Param(value = "searchKeyword") String searchKeyword);

	Article getForPrintArticle(@Param(value = "id") int id);

	List<Article> getForPrintArticles(@Param(value = "boardId") int boardId,
			@Param(value = "searchKeywordType") String searchKeywordType,
			@Param(value = "searchKeyword") String searchKeyword, @Param(value = "limitStart") int limitStart,
			@Param(value = "limitTake") int limitTake);

	Board getBoard(@Param(value = "id") Integer id);

	int getArticlesTotalCount(@Param(value = "boardId") Integer boardId,
			@Param(value = "searchKeywordType") String searchKeywordType,
			@Param(value = "searchKeyword") String searchKeyword);

}
