package com.korea.gfair.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.ReplyPageDTO;
import com.korea.gfair.mapper.ReplyMapper;

import com.korea.gfair.domain.ReplyDTO;
import com.korea.gfair.domain.ReplyVO;
import com.korea.gfair.persistence.ReplyDAO;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;


@Log4j2
@NoArgsConstructor

@Service
public class ReplyServiceImpl implements ReplyService {

	@Setter(onMethod_= @Autowired)
	ReplyDAO dao;
	
	@Override
	public List<ReplyVO> getReply(ReplyDTO dto) throws Exception {
		log.debug("getReply({}) invoked.", dto);
		
		List<ReplyVO> reply =this.dao.select(dto);
		
		return reply;
	}//getReply

	@Override
	public boolean registerReply(ReplyDTO dto) throws Exception {
		log.debug("registerReply({}) invoked.", dto);
		
		return this.dao.insert(dto);
	}//registerReply

	@Override
	public boolean removeReply(ReplyDTO dto) throws Exception {
		log.debug("removeReply({}) invoked.", dto);
		return this.dao.delete(dto);
	}//removeReply

	
	//-------------- danny ----------------//
	@Setter(onMethod_= {@Autowired})
	private ReplyMapper replyMapper;
	
	
	//=========================== 1. register ==========================//
	@Override
	public int register(ReplyDTO dto) {
		log.debug("register(dto) invoked.");
		log.info("\t+ dto: " + dto);
		
		return this.replyMapper.insert(dto);
	}//register()

	
	
	//=========================== 2. get ==========================//
	@Override
	public ReplyVO get(Integer reno) {
		log.debug("get(reno) invoked.");
		log.info("\t+ dto: " + reno);
		
		return this.replyMapper.read(reno);
	}//get()
	
	
	
	//=========================== 3. modify ==========================//
	@Override
	public int modify(ReplyDTO dto) {
		log.debug("modify(reno) invoked.");
		log.info("\t+ dto: " + dto);
		
		return this.replyMapper.update(dto);
	}//modify()
	
	
	
	//=========================== 4. remove ==========================//
	@Override
	public int remove(Integer reno) {
		log.debug("remove(dto) invoked.");
		log.info("\t+ dto: " + reno);
		
		return this.replyMapper.delete(reno);
	}//remove()
	
	
	
	//=========================== 5. getList ==========================//
	@Override
	public List<ReplyVO> getList(Criteria cri, Integer bno) {
		log.debug("getList(cri, bno) invoked.");
		log.info("\t+ cri: {}, bno: {} " + cri, bno);
		
		
		return this.replyMapper.getListWithPaging(cri, bno);
	}



	//=========================== 5. getListPerPage ==========================//
	@Override
	public ReplyPageDTO getListPerPage(Criteria cri, Integer bno) {
		log.debug("getListPerPage(cri, bno) invoked.");
		log.info("\t+ cri: {}, bno: {}", cri, bno);
		
		return new ReplyPageDTO(
				this.replyMapper.getCountByBno(bno),
				this.replyMapper.getListWithPaging(cri, bno)
			);
	}//getList()
}//end class
