package com.korea.gfair.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.korea.gfair.domain.BoardReplyJoinVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.MemberDTO;
import com.korea.gfair.domain.MemberVO;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;


@NoArgsConstructor
@Log4j2

@Repository("MyPageDAO")
public class MyPageDAOImpl 
	implements MyPageDAO {

	public static String namespace = "MyPageMapper";
	
	@Setter(onMethod_=@Autowired)
	SqlSessionFactory sqlSessionFactory;
	
	@Override
	public boolean updatePassword(MemberDTO dto) throws Exception {
		log.debug("updatePassword({}) invoked.", dto);
		
		String sqlId ="updatePassword";
		String sql=MyPageDAOImpl.namespace+"."+sqlId;
		
		SqlSession session =this.sqlSessionFactory.openSession();
		
		try(session;){
			
			int affectedLines=session.update(sql,dto);
			
			return affectedLines>0 ? true : false;
		}//try-with-resources
		
		
	}//updatePassword

	@Override
	public boolean updateDrop(MemberVO vo) throws Exception {
		log.debug("updateDrop({}) invoked.", vo);
		
		String sqlId ="updateDrop";
		String sql=MyPageDAOImpl.namespace+"."+sqlId;
		
		SqlSession session =this.sqlSessionFactory.openSession();
		
		try(session;){
			int affectedLines =session.update(sql,vo);
			
			return affectedLines>0 ? true : false;
		}//try-with-resources
		
	}//updateDrop

	@Override
	public MemberVO selectEamil(MemberVO memberVO) throws Exception {
		log.debug("updateDrop({}) invoked.", memberVO);
		
		String sqlId ="selectEmail";
		String sql=MyPageDAOImpl.namespace+"."+sqlId;
		
		SqlSession session =this.sqlSessionFactory.openSession();
		
		try(session;){
			MemberVO vo=session.selectOne(sql,memberVO);
			
			return vo;
		}//try-with-resources
		
	}//selectEamil

	@Override
	public List<BoardReplyJoinVO> selectJoinReply(Criteria cri,MemberVO vo) throws Exception {
		log.debug("selectJoinReply({}) invoked.", vo);
		
		String sqlId ="selectJoinReply";
		String sql=MyPageDAOImpl.namespace+"."+sqlId;
		
		Map<String, Object> params= new HashMap<>();
		params.put("memberid", vo.getMemberid());
		params.put("amount", cri.getAmount());
		params.put("currPage", cri.getCurrPage());
		params.put("type", cri.getType());
		params.put("keyWord", cri.getKeyword());
		params.put("bname", cri.getBname());
		
		SqlSession session =this.sqlSessionFactory.openSession();
		
		try(session){
			List<BoardReplyJoinVO> replyList = session.selectList(sql,params);
		
			return replyList;
		}//try-with-resources
		
	}//selectEamil

	@Override
	public int selectReplyTotalCount(Criteria cri,MemberVO vo) throws Exception {
		log.debug("selectReplyTotalCount({}) invoked.", vo);
		
		String sqlId= "replyTotalCount";
		String sql=MyPageDAOImpl.namespace+"."+sqlId;
		
		SqlSession session =this.sqlSessionFactory.openSession();
		
		Map<String, Object> params= new HashMap<>();
		params.put("memberid", vo.getMemberid());
		params.put("type", cri.getType());
		params.put("keyWord", cri.getKeyword());
		params.put("bname", cri.getBname());
		
		try(session){
			int totalCount=session.selectOne(sql,params);
		
			return totalCount;
		}//try-with-resources
		
	}//selectReplyTotalCount

	@Override
	public boolean deleteReply(List<Integer> renoList) throws Exception {
		log.debug("deleteReply({}) invoked.",renoList);
		
		String sqlId= "deleteReply";
		String sql=MyPageDAOImpl.namespace+"."+sqlId;
		
		SqlSession session =this.sqlSessionFactory.openSession();
		
		try(session){
			int affectedLines=session.delete(sql,renoList);
		
			return affectedLines>0 ? true : false;
		}//try-with-resources
		
	}//deleteReply
	
	
}//end class
