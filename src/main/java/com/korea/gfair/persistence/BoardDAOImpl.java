package com.korea.gfair.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.korea.gfair.domain.BoardDTO;
import com.korea.gfair.domain.BoardVO;
import com.korea.gfair.domain.Criteria;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@NoArgsConstructor
@Log4j2

@Repository("BoardDAO")
public class BoardDAOImpl 
			implements BoardDAO {

	@Setter(onMethod_=@Autowired)
	SqlSessionFactory sqlSessionFactory;
	
	private static final String NAMESPACE="BoardMapper";
	
	@Override
	public List<BoardVO> selectAllList(Criteria cri) throws Exception {
		log.debug("selectAllUsers() invoked.");
		
		SqlSession sqlSession = this.sqlSessionFactory.openSession();
		
		try(sqlSession){
			
			String sqlId		= "list";
			String sql 			=BoardDAOImpl.NAMESPACE+"."+sqlId;
			
			
			Map<String, Object> params = new HashMap<>();
			params.put("currPage", cri.getCurrPage());
			params.put("type", cri.getType());
			params.put("keyWord", cri.getKeyword());
			params.put("amount", cri.getAmount());
			params.put("bname", "question");
			
			//매개변수로 DTO 게시판 이름 전달하기. 
			List<BoardVO> boards=sqlSession.selectList(sql, params);
			
			return boards;
		}//try-with-resources
		
	}//selectAllList

	@Override
	public BoardVO selectOneList(BoardDTO dto) throws Exception {
		log.debug("selectOneList() invoked.");
		SqlSession sqlSession = this.sqlSessionFactory.openSession();
		
		try(sqlSession){
			
			String sqlId		= "select";
			String sql 			= BoardDAOImpl.NAMESPACE+"."+sqlId;
			
			BoardVO board=sqlSession.selectOne(sql, dto);
			//조회수 증가 
			sqlSession.update(BoardDAOImpl.NAMESPACE+".readcnt",board);
			
			return board;
		}//try-with-resources
		
	}//selectAllUsers

	@Override
	public boolean updateList(BoardDTO dto) throws Exception {
		log.debug("updateList() invoked.");
		SqlSession sqlSession = this.sqlSessionFactory.openSession();
		
		try(sqlSession){
			
			String sqlId		= "update";
			String sql 			= BoardDAOImpl.NAMESPACE+"."+sqlId;
			
			int affectedLine =sqlSession.update(sql, dto);
			
			if(affectedLine>0) {
				return true;
			}else {
				return false;
			}//if else
		}//try-with-resources
	
	}//update

	@Override
	public boolean delete(BoardDTO dto) throws Exception {
		log.debug("delete({}) invoked.", dto);
		SqlSession sqlSession = this.sqlSessionFactory.openSession();
		
		try(sqlSession){
			
			String sqlId		= "delete";
			String sql 			= BoardDAOImpl.NAMESPACE+"."+sqlId;
			
			int affectedLine =sqlSession.delete(sql, dto);
			
			if(affectedLine>0) {
				return true;
			}else {
				return false;
			}//if else
			
		}//try-with-resources
	}//deleteList
	

	@Override
	public boolean insert(BoardDTO dto) throws Exception {
		log.debug("insert({}) invoked.",dto);
		SqlSession sqlSession = this.sqlSessionFactory.openSession();
		
		try(sqlSession){
			//XXX Service 고치기 
			String sqlId		= "insert";
			String sql 			= BoardDAOImpl.NAMESPACE+"."+sqlId;
			
			int affectedLine =sqlSession.insert(sql, dto);
			
			if(affectedLine>0) {
				return true;
			}else {
				return false;
			}//if else
		}//try-with-resources
		
	}//deleteList

	@Override
	public boolean insertRetreive(BoardDTO dto) throws Exception {
		log.debug("insertRetreive({}) invoked.",dto);
		SqlSession sqlSession = this.sqlSessionFactory.openSession();
		
		try(sqlSession){
			
//			XXX service 고치기. 
			String sqlId		= "repInsert";
			String sql 			= BoardDAOImpl.NAMESPACE+"."+sqlId;
			
			int affectedLine =sqlSession.insert(sql, dto);
			
			if(affectedLine>0) {
				return true;
			}else {
				return false;
			}//if else
		}//try-with-resources
	}//insertRetreive

	@Override
	public int selectTotalCount(Criteria cri) throws Exception {
		log.debug("selectCount({})",cri);
		SqlSession sqlSession = this.sqlSessionFactory.openSession();

		try (sqlSession) {
			String sqlId ="totalCount";
			String sql=BoardDAOImpl.NAMESPACE+"."+sqlId;
			
			Map<String, Object> params = new HashMap<>();
			params.put("keyWord", cri.getKeyword());
			params.put("bname", "question");
			
			int count = sqlSession.selectOne(sql, params);
		
			return count;
		}//try- with- resources
	
	}//selectCount
	
	
	

}//end class
