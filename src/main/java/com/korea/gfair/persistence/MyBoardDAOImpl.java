package com.korea.gfair.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.korea.gfair.domain.BoardReplyCountVO;
import com.korea.gfair.domain.Criteria;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;


@Log4j2
@NoArgsConstructor

@Repository
public class MyBoardDAOImpl implements MyBoardDAO {
	
	
	@Setter(onMethod_= {@Autowired})
	private SqlSessionFactory sqlSessionFactory;
	

	@Override
	public List<BoardReplyCountVO> list(Criteria cri, String memberid) throws Exception {
		log.debug("list(cri, memberid) invoked");
		
		Objects.nonNull(sqlSessionFactory);
		SqlSession sqlSession = sqlSessionFactory.openSession();
		
		try(sqlSession){
			
			String statement = "myBoardMapper.list";
			
			Map<String, Object> param = new HashMap<>();
			param.put("memberid", memberid);
			param.put("bname", cri.getBname());
//			param.put("bnameKeyWord", cri.getBnameKeyWord());
			param.put("type", cri.getType());
			param.put("keyWord", cri.getKeyword());
			param.put("currPage", cri.getCurrPage());
			param.put("amount", cri.getAmount());
			
			List<BoardReplyCountVO> list = sqlSession.selectList(statement, param);
			
			return list;
		}//try-with-resource
	}//list


	@Override
	public Integer totalCount(Criteria cri, String memberid) throws Exception {
		log.debug("totalCount(cri, memberid) invoked");
		
		SqlSession sqlSession = sqlSessionFactory.openSession();
		
		try(sqlSession){
			
			String statement = "myBoardMapper.totalCount";
			
			Map<String, Object> param = new HashMap<>();
			param.put("memberid", memberid);
			param.put("bname", cri.getBname());
			param.put("type", cri.getType());
			param.put("keyWord", cri.getKeyword());
			param.put("currPage", cri.getCurrPage());
			param.put("amount", cri.getAmount());
			
			log.info("param : "+param);
			
			Integer result = sqlSession.selectOne(statement, param);
			
			return result;
		}//try-with-resource
	}//totalCount



	@Override
	public void delete(List<Integer> bnoList, String memberid) throws Exception {
		log.debug("delete(bnoList, memberid) invoked");
		
		SqlSession sqlSession = sqlSessionFactory.openSession();
		
		try(sqlSession){
			
			String statement = "myBoardMapper.delete";
			
			Map<String, Object> param = new HashMap<>();
			
			param.put("bnoList", bnoList);
			param.put("memberid", memberid);
			
			int result = sqlSession.delete(statement, param);
			
			log.info("삭제된 행의 개수 : {}",result);
		}//try-with-resource
	}//delete
	
}//end class
