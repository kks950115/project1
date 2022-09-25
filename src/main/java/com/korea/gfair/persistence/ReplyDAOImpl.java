package com.korea.gfair.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.korea.gfair.domain.ReplyDTO;
import com.korea.gfair.domain.ReplyVO;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@NoArgsConstructor
@Log4j2

@Repository("ReplyDAO")
public class ReplyDAOImpl implements ReplyDAO {

	@Setter(onMethod_=@Autowired)
	SqlSessionFactory sqlSessionFactory;
	
	private static final String namespace="BoardReplyMapper";
	
	@Override
	public List<ReplyVO> select(ReplyDTO dto) throws Exception {
		log.debug("select({}) invoked.", dto);
		SqlSession sqlSession =this.sqlSessionFactory.openSession();
		
		try(sqlSession){
			String sql = ReplyDAOImpl.namespace+ ".replyList";
			
			List<ReplyVO> reply=sqlSession.selectList(sql,dto);
			
			return reply;
		}//try-with-resources

	}//select

	@Override
	public boolean insert(ReplyDTO dto) throws Exception {
		log.debug("insert({}) invoked.", dto);
		
		SqlSession sqlSession =this.sqlSessionFactory.openSession();
		
		try(sqlSession){
			String sql = ReplyDAOImpl.namespace+ ".replyInsert";
			
			int affectedLine =sqlSession.insert(sql,dto);
			if(affectedLine>0) {
				return true;
			}else {
				return false;
			}//if-else
		}//try-with-resources
	}//insert

	@Override
	public boolean delete(ReplyDTO dto) throws Exception {
		log.debug("delete({}) invoked.", dto);
		
		SqlSession sqlSession =this.sqlSessionFactory.openSession();
		
		try(sqlSession){
			String sql = ReplyDAOImpl.namespace+ ".replyDelete";
			
			int affectedLine =sqlSession.insert(sql,dto);
			if(affectedLine>0) {
				return true;
			}else {
				return false;
			}//if-else
		}//try-with-resources
	}//delete

}//end class
