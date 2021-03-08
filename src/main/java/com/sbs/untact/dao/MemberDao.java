package com.sbs.untact.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.untact.dto.Member;

@Mapper
public interface MemberDao {
	public void memberJoin(Map<String, Object> param);

	public Member getMember(@Param(value = "id") int id);

	public Member getMemberByLoginId(@Param(value = "loginId") String loginId);

	public Member getMemberByNickname(@Param(value = "nickname") String nickname);

	public void modifyMember(Map<String, Object> param);

	public Member getMemberByAuthKey(@Param(value = "authKey") String authKey);

	public List<Member> getMembers();

	public List<Member> getForPrintMembers(Map<String, Object> param);

	public Member getForPrintMember(@Param(value = "id") int id);
}
