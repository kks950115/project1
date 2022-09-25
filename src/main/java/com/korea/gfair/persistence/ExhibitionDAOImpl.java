package com.korea.gfair.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.ExhibitionDTO;
import com.korea.gfair.domain.ExhibitionVO;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;


@Log4j2
@NoArgsConstructor

@Repository
public class ExhibitionDAOImpl implements ExhibitionDAO {

	
	@Setter(onMethod_= {@Autowired})
	private SqlSessionFactory sqlSessionFactory;
	
	
	@Override
	public List<ExhibitionVO> visitList() {
		log.debug("visitList() invoked");
		
		SqlSession sqlSession = sqlSessionFactory.openSession();
		
		try(sqlSession){
			
			String statement = "exhibitionMapper.visitList";
			
			List<ExhibitionVO> visitList = sqlSession.selectList(statement);
			
			return visitList;
		}//try-with-resources
	}//visitList


	@Override
	public List<ExhibitionVO> exPagingList(Criteria cri) throws Exception {
		log.debug("exPagingList() invoked");
		
		SqlSession sqlSession = this.sqlSessionFactory.openSession();
		
		try(sqlSession){
			
			String Statement = "exhibitionMapper.exPagingList";
			
			List<ExhibitionVO> list = sqlSession.selectList(Statement,cri);
			
			return list;
		}//try-with-resources
	}//exPagingList
	
	
	@Override
	public ExhibitionVO schedule(Integer exno) throws Exception {
		log.debug("schedule() invoked");
		
		SqlSession sqlSession = this.sqlSessionFactory.openSession();
		
		try(sqlSession){
			
			String Statement = "exhibitionMapper.schedule";
			
			ExhibitionVO exVO = sqlSession.selectOne(Statement, exno);
			
			return exVO;
		}//try-with-resources
	}//schedule


	@Override
	public void insert(ExhibitionDTO exDTO) throws Exception {
		log.debug("insert() invoked");

		SqlSession sqlSession = this.sqlSessionFactory.openSession();
		
		try(sqlSession){
			
			String Statement = "exhibitionMapper.insert";
			
			sqlSession.insert(Statement,exDTO);
		}//try-with-resources
	}//insert


	@Override
	public void update(ExhibitionDTO exDTO) throws Exception {
		log.debug("update() invoked");
		
		SqlSession sqlSession = this.sqlSessionFactory.openSession();
		
		try(sqlSession){
			
			String Statement = "exhibitionMapper.update";
			
			sqlSession.update(Statement,exDTO);
		}//try-with-resources
	}//update


	@Override
	public void delete(List<Integer> exnoList) throws Exception {
		log.debug("delete() invoked");
		
		SqlSession sqlSession = this.sqlSessionFactory.openSession();
		
		try(sqlSession){
			
			String Statement = "exhibitionMapper.delete";
			Map<String, Object> param = new HashMap<>();
			param.put("exnoList", exnoList);
			
			sqlSession.delete(Statement,param);
		}//try-with-resources
	}//delete


	@Override
	public Integer totalCount(Criteria cri) throws Exception {
		log.debug("totalCount(cri) invoked");
		
		SqlSession sqlSession = this.sqlSessionFactory.openSession();
		
		try(sqlSession){
			
			String Statement = "exhibitionMapper.totalCount";
			
			Integer result = sqlSession.selectOne(Statement,cri);
			
			return result;
		}//try-with-resources
	}//totalCount


	@Override
	public List<ExhibitionVO> searchEx() throws Exception {
		log.debug("searchEx() invoked");
		
		SqlSession sqlSession = this.sqlSessionFactory.openSession();
		
		try(sqlSession){
			
			String Statement = "exhibitionMapper.searchEx";
			
			List<ExhibitionVO> result = sqlSession.selectList(Statement);
			
			return result;
		}//try-with-resources
	}//searchEx



}//end class
