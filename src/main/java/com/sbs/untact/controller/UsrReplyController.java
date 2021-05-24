package com.sbs.untact.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.untact.dto.Article;
import com.sbs.untact.dto.Member;
import com.sbs.untact.dto.Reply;
import com.sbs.untact.dto.ResultData;
import com.sbs.untact.service.ArticleService;
import com.sbs.untact.service.ReplyService;

@Controller
public class UsrReplyController extends BaseController {
	@Autowired
	private ReplyService replyService;
	@Autowired
	private ArticleService articleService;

	@RequestMapping("/usr/reply/doAdd")
	public String doAdd(@RequestParam Map<String, Object> param, HttpServletRequest req, String redirectUrl) {
		int loginedMemberId = (int) req.getAttribute("loginedMemberId");
		Member loginedMember = (Member) req.getAttribute("loginedMember");
		
		if (param.get("body") == null) {
			return msgAndBack(req, "body를 입력해주세요.");
		}

		if (loginedMember == null) {
			return msgAndBack(req, "작성자만 가능합니다");
		}
		
		param.put("memberId", loginedMemberId);

		ResultData addReplyRd = replyService.addReply(param);

		return msgAndReplace(req, addReplyRd.getMsg(), redirectUrl);
	}

	@RequestMapping("/usr/reply/list")
	@ResponseBody
	public ResultData showList(String relTypeCode, Integer relId) {
		if (relTypeCode == null) {
			return new ResultData("F-1", "relTypeCode를 입력해주세요.");
		}
		
		if (relId == null) {
			return new ResultData("F-1", "relId를 입력해주세요.");
		}

		if (relTypeCode.equals("article")) {
			Article article = articleService.getArticle(relId);

			if (article == null) {
				return new ResultData("F-1", "존재하지 않는 게시물 입니다.");
			}
		}

		List<Reply> replies = replyService.getForPrintRepliesByRelTypeCodeAndRelId(relTypeCode, relId);

		return new ResultData("S-1", "성공", "replies", replies);
	}

	@RequestMapping("/usr/reply/doDelete")
	public String doDelete(HttpServletRequest req, Integer id, String redirectUrl) {
		Member loginedMember = (Member) req.getAttribute("loginedMember");

		if (id == null) {
			return msgAndBack(req, "id를 입력해주세요.");
		}

		Reply reply = replyService.getReply(id);

		if (reply == null) {
			return msgAndBack(req, "해당 댓글은 존재하지 않습니다.");
		}
		
		if(reply.getMemberId() != loginedMember.getId()) {
			return msgAndBack(req, "본인 댓글만 가능합니다.");	
		}
		
		ResultData deleteReply = replyService.deleteReply(id);
		return msgAndReplace(req, deleteReply.getMsg(), redirectUrl);
	}

	@RequestMapping("/usr/reply/doModify")
	@ResponseBody
	public String doModify(Integer id, String body, HttpServletRequest req) {
		if (id == null) {
			return msgAndBack(req, "id를 입력해주세요.");
		}

		if (body == null) {
			return msgAndBack(req, "body를 입력해주세요.");
		}

		Reply reply = replyService.getReply(id);

		if (reply == null) {
			return msgAndBack(req, "해당 댓글은 존재하지 않습니다.");
		}

		String redirectUrl = "";
		
		ResultData modifyReply = replyService.modifyReply(id, body);
		return msgAndReplace(req, modifyReply.getMsg(), redirectUrl);
	}
}
