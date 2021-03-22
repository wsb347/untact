package com.sbs.untact.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.untact.dto.Member;

@Mapper
public interface MemberDao {
	void memberJoin(Map<String, Object> param);

	Member getMember(@Param(value = "id") int id);

	Member getMemberByLoginId(@Param(value = "loginId") String loginId);

	Member getMemberByNickname(@Param(value = "nickname") String nickname);

	void modifyMember(Map<String, Object> param);

	Member getMemberByAuthKey(@Param(value = "authKey") String authKey);

	List<Member> getMembers();

	List<Member> getForPrintMembers(Map<String, Object> param);

	Member getForPrintMember(@Param(value = "id") int id);

	void deleteMember(@Param(value = "id") Integer id);
}
