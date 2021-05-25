package com.sbs.untact.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.untact.dto.Reply;

@Mapper
public interface ReplyDao {
	int getLastInsertId();

	List<Reply> getForPrintRepliesByRelTypeCodeAndRelId(@Param("relTypeCode") String relTypeCode,
			@Param("relId") int relId);

	Reply getReply(@Param("relTypeCode") String relTypeCode, @Param("id") int id);

	void deleteReply(@Param("id") int id);

	void modifyReply(@Param("id") int id, @Param("body") String body);

	void addReply(Map<String, Object> param);
}