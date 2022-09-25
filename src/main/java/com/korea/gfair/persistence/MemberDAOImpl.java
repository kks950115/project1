package com.korea.gfair.persistence;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.korea.gfair.domain.MemberVO;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;


@Log4j2
@NoArgsConstructor

@Repository
public class MemberDAOImpl implements MemberDAO{

	
	@Setter(onMethod_= {@Autowired})
	private SqlSessionFactory sqlSessionfactory;
	
	
	@Override
	public boolean memberUpdate(MemberVO memberVO) throws Exception {
		log.debug("memberUpdate({}) invoked",memberVO);
		
		SqlSession sqlSession = sqlSessionfactory.openSession();
		
		try(sqlSession){
			
			String statement = "memberMapper.memberUpdate";
			
			int result = sqlSession.update(statement, memberVO);
			
			
			return result > 0;
		}//try-with-resource
	}//memberUpdate

	
	@Override
	public MemberVO getMember(String memberid) throws Exception {
		log.debug("getMember({}) invoked",memberid);
		
		SqlSession sqlSession = sqlSessionfactory.openSession();
		
		try(sqlSession){
			
			String statement = "memberMapper.getMember";
			
			
			MemberVO memverVO = (MemberVO)sqlSession.selectOne(statement, memberid);
			
			return memverVO;
		}//try-with-resource
	}//memberUpdate


	@Override
	public Integer checkInfoCount(MemberVO memberVO) throws Exception {
		log.debug("checkInfoCount(memberVO) invoked");

		SqlSession sqlSession = sqlSessionfactory.openSession();
		
		try(sqlSession){
			
			String statement = "memberMapper.checkInfoCount";
			
			Integer result = sqlSession.selectOne(statement, memberVO);
			
			return result;
		}//try-with-resource
	}//checkInfoCount
	
	
}//end class
