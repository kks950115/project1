package com.korea.gfair.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.korea.gfair.domain.BoardReplyCountVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.persistence.MyBoardDAO;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Log4j2
@NoArgsConstructor

@Service
public class MyBoardServiceImpl implements MyBoardService {

	
	@Setter(onMethod_= {@Autowired})
	private MyBoardDAO myBoardDAO;
	
	 
	@Override
	public List<BoardReplyCountVO> getList(Criteria cri, String memberid) throws Exception {
		log.debug("getList() invoked");

		return this.myBoardDAO.list(cri, memberid);
	}//getList


	@Override
	public Integer getTotalCount(Criteria cri, String memberid) throws Exception {
		log.debug("getTotalCount() invoked");
		
		Integer count = this.myBoardDAO.totalCount(cri, memberid);
		
		return count;
	}//getTotalCount


	@Override
	public void selectAllRemove(List<Integer> bnoList, String memberid) throws Exception {
		log.debug("selectAllRemove({},{}) invoked",bnoList,memberid);
		
		this.myBoardDAO.delete(bnoList, memberid);
		
	}//selectAllRemove

}//end class
