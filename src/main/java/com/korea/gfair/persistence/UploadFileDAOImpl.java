package com.korea.gfair.persistence;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.korea.gfair.domain.UploadFileDTO;
import com.korea.gfair.domain.UploadFileVO;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@NoArgsConstructor
@Log4j2

@Repository("uploadFileDAO")
public class UploadFileDAOImpl implements UploadFileDAO {

	@Setter(onMethod_ = @Autowired)
	SqlSessionFactory sqlSessionFactory;
	
	private static final String namespace ="UploadFileMapper";
	
	@Override
	public int insertFile(UploadFileDTO dto) {
		log.debug("insertFile({}) invoked.", dto);
		
		SqlSession sqlSession =this.sqlSessionFactory.openSession();
		
		try(sqlSession){
			
			String sqlId = "insert";
			String sql =namespace+"."+sqlId;
			
			
			UploadFileVO vo = new UploadFileVO(null, dto.getFrename(), dto.getFpath(), dto.getForname());
			
			sqlSession.insert(sql, vo);
			
			return vo.getFid();
			
		}//try-with-resources
		
	}//insertFile



	@Override
	public UploadFileVO selectFile(UploadFileDTO dto) {
		SqlSession sqlSession =this.sqlSessionFactory.openSession();
		
		try(sqlSession){
			
			String sqlId = "fileByFid";
			String sql =namespace+"."+sqlId;
			
			UploadFileVO file=sqlSession.selectOne(sql,dto);
			
			return file;
		}//try-with-resources
	}//selectFile

	
}//end class
