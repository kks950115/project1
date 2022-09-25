package com.korea.gfair.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.korea.gfair.domain.ApplyVO;
import com.korea.gfair.domain.MemberVO;

import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j2;

@NoArgsConstructor
@Log4j2

@Repository("adminDAO")
public class AdminDAOImpl implements AdminDAO {

	@Autowired
	SqlSessionFactory sqlSessionFactory;
	
	public static final String namespace ="AdminMapper";
	
	@Override
	public List<ApplyVO> selectApply() throws Exception {
		log.debug("selectApply() invoked.");
		
		String sqlId ="selectApply";
		String sql	 =AdminDAOImpl.namespace+"."+sqlId;
		
		SqlSession session = this.sqlSessionFactory.openSession();
		
		try(session;){
			
			List<ApplyVO> applylist =session.selectList(sql);
			
			return applylist;
		}//try-with-resources
	}//selectApply()

	@Override
	public boolean updateApplyAgreeStatus(List<Integer> applynoList) throws Exception {
		log.debug("updateApplyAgreeStatus() invoked.");
		
		String sqlId ="updateApplyAgreeStatus";
		String sql	 =AdminDAOImpl.namespace+"."+sqlId;
		
		SqlSession session = this.sqlSessionFactory.openSession();
		
		try(session;){
			
			int affectedLines=session.update(sql,applynoList);
			
			return (affectedLines>0) ? true : false;
		}//try-with-resources
	}//updateApplyAgreeStatus

	@Override
	public boolean insertPayment(List<Integer> applynoList) throws Exception {
		log.debug("insertPayment() invoked.");
		
		String sqlId ="insertPayment";
		String sql	 =AdminDAOImpl.namespace+"."+sqlId;
		
		SqlSession session = this.sqlSessionFactory.openSession();
		
		try(session;){
			
			int affectedLines=session.insert(sql,applynoList);
			
			return (affectedLines>0) ? true : false;
		}//try-with-resources
		
	}//insertPayment

	@Override
	public boolean updateApplyPno(List<Integer> applynoList) throws Exception {
		log.debug("updateApplyPno({}) invoked.", applynoList);
		
		String sqlId = "updateApplyPno";
		String sql	 = AdminDAOImpl.namespace+"."+sqlId;
		
		SqlSession session = this.sqlSessionFactory.openSession();
		
		try(session;){
			
			int affectedLines=session.update(sql,applynoList);
			
			return (affectedLines>0) ? true : false;
		}//try-with-resources
	}//updateApplyPno

	@Override
	public boolean updatePaymentStatus(List<Integer> applynoList) throws Exception {
		log.debug("updatePaymentStatusAndPaymentTF({}) invoked.", applynoList);
		
		String sqlId ="UpdatePaymentPstatus";
		String sql	 =AdminDAOImpl.namespace+"."+sqlId;
		
		SqlSession session = this.sqlSessionFactory.openSession();
		
		try(session){
			
			int affectedLines = session.update(sql,applynoList);
			
			return (affectedLines >0) ? true : false;
		}//try-with-resources
		
	}//updateApplyPno

	@Override
	public boolean updateApplyPaymentTF(List<Integer> applynoList) throws Exception {
		
		String sqlId ="UpdateApplyPaymentTF";
		String sql	 =AdminDAOImpl.namespace+"."+sqlId;
		
		SqlSession session = this.sqlSessionFactory.openSession();
		
		try(session){
			
			int affectedLines = session.update(sql,applynoList);
			
			return (affectedLines >0) ? true : false;
		}//try-with-resources
		
	}//updateApplyPaymentTF
	
	//이진성 - 관리자페이지 > 회원관리
	@Override
	public List<MemberVO> selectMemberList(String membertype) {
		
		String sqlId = "selectMemberList";
		String sql = AdminDAOImpl.namespace+"."+sqlId;
		
		SqlSession session = this.sqlSessionFactory.openSession();
		
		try(session;) {
			List<MemberVO> applylist = session.selectList(sql, membertype);
			
			return applylist;
		}//try-with-resources
	}//selectMemberList
	
	@Override
	public void dropMember(List<Integer> mnoList) {
		String sqlId = "dropMember";
		String sql = AdminDAOImpl.namespace+"."+sqlId;
		
		SqlSession session = this.sqlSessionFactory.openSession();
		
		try(session;) {
			session.update(sql, mnoList);
		}//try-with-resources
	}//dropMember
	
	
	@Override
	public void rollbackMember(List<Integer> mnoList) {
		String sqlId = "rollbackMember";
		String sql = AdminDAOImpl.namespace+"."+sqlId;
		
		SqlSession session = this.sqlSessionFactory.openSession();
		
		try(session;) {
			session.update(sql, mnoList);
		}//try-with-resources
	}//rollbackMember
	
	@Override
	public void changeMemberType(Integer mno, String membertype) {
		String sqlId = "changeMemberType";
		String sql = AdminDAOImpl.namespace+"."+sqlId;
		
		SqlSession session = this.sqlSessionFactory.openSession();
		
		Map<String, Object> params= new HashMap<>();
		params.put("mno", mno);
		params.put("membertype", membertype);
		
		try(session;) {
			session.update(sql, params);
		}//try-with-resources
	}//changeMemberType

	@Override
	public MemberVO selectMember(Integer mno) {
		String sqlId = "selectMember";
		String sql = AdminDAOImpl.namespace+"."+sqlId;
		
		SqlSession session = this.sqlSessionFactory.openSession();
		
		try(session;) {
			MemberVO applylist = session.selectOne(sql, mno);
			
			return applylist;
		}//try-with-resources
	}

	@Override
	public Integer selectPaymentCheckInt(List<Integer> applynoList) throws Exception {
		String sqlId = "selectPaymentCheckInt";
		String sql = AdminDAOImpl.namespace+"."+sqlId;
		
		SqlSession session = this.sqlSessionFactory.openSession();
		
		try(session;) {
			Integer applylist = session.selectOne(sql, applynoList);
			
			return applylist;
		}//try-with-resources
	}


}//end class
