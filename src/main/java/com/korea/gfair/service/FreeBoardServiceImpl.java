package com.korea.gfair.service;

import java.util.List;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.korea.gfair.domain.BoardDTO;
import com.korea.gfair.domain.BoardVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.mapper.FreeBoardMapper;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;


@Log4j2
@NoArgsConstructor

@Service
public class FreeBoardServiceImpl implements FreeBoardService {

	@Setter(onMethod_= @Autowired)
	private FreeBoardMapper mapper;
	

	
	@Override
	public List<BoardVO> getListPerPage(Criteria cri,String bname) {
		log.debug("getListPerPage({}) invoked.",cri,bname);
		
		Objects.requireNonNull(mapper);
		
		return mapper.getListWithPaging(cri,bname);
	}//getListPerPage
	
	
	@Override
	public int getTotal(Criteria cri,String bname) {
		log.debug("getListPerPage({}) invoked.",cri);
		
		Objects.requireNonNull(mapper);
		
		return mapper.getTotalCount(cri,bname);
		
	}//getTotal
	
	@Override
	public BoardVO read(BoardDTO dto) {
		log.debug("read() invoked.");
		
		readcnt(dto);
		BoardVO read = mapper.select(dto);
		
		return read;

	}//readcnt

	@Override
	public boolean write(BoardVO vo) {

		log.debug("write() invoked.");
		
		boolean write = mapper.insert(vo);
		
		if(write) {
			return true;
		}else {
			return false;
		}//if-else
		
	}//write

	@Override
	public boolean modify(BoardDTO dto) {
		
		log.debug("modify() invoked.");
		
		boolean modify = mapper.update(dto);
		
		return modify;
		
	}//modify

	@Override
	public boolean remove(Integer bno) {

		log.debug("remove() invoked.");
		
		boolean remove = mapper.delete(bno);
		
		if(remove) {
			return true;
		}else {
			return false;
		}//if-else
		
	}//remove

	@Override
	public void readcnt(BoardDTO dto) {
		
		log.debug("readcnt() invoked.");
		
		mapper.readcnt(dto);
		
		
	}





	
	
}//end class
