package com.korea.gfair.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.korea.gfair.domain.ApplyDTO;
import com.korea.gfair.domain.ApplyFileVO;
import com.korea.gfair.domain.ApplyMemberFileVO;
import com.korea.gfair.domain.ApplyVO;
import com.korea.gfair.domain.BoothVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.ExhibitionVO;
import com.korea.gfair.domain.MemberDTO;
import com.korea.gfair.domain.MemberVO;
import com.korea.gfair.domain.PaymentVO;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@NoArgsConstructor
@Log4j2

@Repository("ApplyDAO")
public class ApplyDAOImpl implements ApplyDAO {

	@Setter(onMethod_=@Autowired)
	SqlSessionFactory sqlSessionFactory;
	
	public static final String namespace ="ApplyMapper";
	
	@Override
	public MemberVO selectMemberInfo(MemberDTO dto) throws Exception {
		log.debug("selectMemberInfo({}) invoked.", dto);
		
		String sqlId ="selectMemberInfo";
		String sql = namespace +"." +sqlId;
		
		SqlSession session=this.sqlSessionFactory.openSession();
		
		try(session;){
			MemberVO member =session.selectOne(sql,dto);

			return member;
		}//try-with-resources
		
	}//selectMemberInfo

	@Override
	public List<BoothVO> selectBooth() throws Exception {
		log.debug("selectBooth() invoked.");
		
		String sqlId ="selectBooth";
		String sql = namespace +"." +sqlId;
		
		SqlSession session=this.sqlSessionFactory.openSession();
		
		try(session;){
			List<BoothVO> booth=session.selectList(sql);
			
			return booth;
		}//try-with-resources
	}//selectBooth

	@Override
	public boolean insert(ApplyDTO dto) throws Exception {
		log.debug("insert({}) invoked.", dto);
		
		String sqlId ="insert";
		String sql = namespace +"." +sqlId;
		
		SqlSession session=this.sqlSessionFactory.openSession();
		
		try(session;){
			int affectedLines = session.insert(sql,dto);
		
			return affectedLines>0? true : false;
		}//try-with-resourecs
		
	}//selectBooth

	@Override
	public boolean updateBooth(ApplyDTO dto) throws Exception {
		log.debug("updateBooth({}) invoked.", dto);
		
		String sqlId ="updateBooth";
		String sql = namespace +"." +sqlId;
		
		SqlSession session=this.sqlSessionFactory.openSession();
		
		try(session;){
			int affectedLines = session.update(sql,dto);
		
			return affectedLines>0? true : false;
		}//try-with-resourecs
	}//selectBooth

	@Override
	public List<ApplyVO> selectApplyInfo(MemberVO vo) throws Exception {
		log.debug("selectApplyInfo({}) invoked.", vo);
		
		String sqlId ="selectApplyInfo";
		String sql = namespace +"." +sqlId;
		
		SqlSession session=this.sqlSessionFactory.openSession();
		
		try(session;){
			List<ApplyVO> applyInfo = session.selectList(sql,vo);
		
			return applyInfo;
		}//try-with-resourecs
	}//selectApplyInfo

	@Override
	public List<ExhibitionVO> selectExhibition() throws Exception {
		log.debug("selectExhibition() invoked.");
		
		String sqlId ="selectExhibition";
		String sql 	 =namespace+"."+sqlId;
		
		SqlSession session = this.sqlSessionFactory.openSession();
		
		try(session;){
			List<ExhibitionVO> exhibition =session.selectList(sql);
		
			return exhibition;
		}//try-with-resources
		
	}//selectApplyInfo

	@Override
	public PaymentVO selectPaymentInfo(Integer applyno) throws Exception {
		log.debug("selectPaymentInfo({}) invoked.", applyno);
		
		String sqlId ="selectPaymentInfo";
		String sql 	 =namespace+"."+sqlId;
		
		SqlSession session = this.sqlSessionFactory.openSession();
		
		try(session;){
			PaymentVO paymentInfo =session.selectOne(sql,applyno);
		
			return paymentInfo;
		}//try-with-resources
	}//selectPaymentInfo

	@Override
	public List<ApplyFileVO> applyList(Criteria cri, String applyname) throws Exception {
		log.debug("applyList() invoked.");
		
		String statement = namespace+".applyList";
		
		SqlSession sqlSession = sqlSessionFactory.openSession();
		
		try(sqlSession){
			Map<String, Object> param = new HashMap<>();
			param.put("amount", cri.getAmount());
			param.put("currPage", cri.getCurrPage());
			param.put("applyname", applyname);
			
			List<ApplyFileVO> list = sqlSession.selectList(statement, param);
		
			return list;
		}//try-with-resources
	}//ApplyList

	@Override
	public ApplyMemberFileVO applyGet(Integer applyno) throws Exception {
		log.debug("applyGet() invoked.");
		
		String statement = namespace+".applyGet";
		
		SqlSession sqlSession = sqlSessionFactory.openSession();
		
		try(sqlSession){
			
			ApplyMemberFileVO applyVO = sqlSession.selectOne(statement, applyno);
		
			return applyVO;
		}//try-with-resources
	}//ApplyGet

	@Override
	public Integer totalCount(String applyname) throws Exception {
		log.debug("totalCount() invoked.");
		
		String statement = namespace+".totalCount";
		
		SqlSession sqlSession = sqlSessionFactory.openSession();
		
		try(sqlSession){
			
			int count = sqlSession.selectOne(statement, applyname);
		
			return count;
		}//try-with-resources
	}//totalCount

}//end class
