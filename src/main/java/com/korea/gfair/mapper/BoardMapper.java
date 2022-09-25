package com.korea.gfair.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.korea.gfair.domain.BoardVO;
import com.korea.gfair.domain.Criteria;


public interface BoardMapper {

	
	public abstract List<BoardVO> list(@Param("cri")Criteria cri, @Param("bname")String bname);
	public abstract BoardVO select(Integer bno);			//공통
	
	public abstract boolean insert(BoardVO board);
	public abstract boolean delete(Integer bno);			//공통
	public abstract boolean update(BoardVO board);			//공통
	
	public abstract Integer totalCount(@Param("cri")Criteria cri, @Param("bname")String bname);
	public abstract boolean readcnt(Integer bno);
	
	public abstract void repStepUp(@Param("reproot")Integer reproot, @Param("repstep")Integer repstep);
	public abstract boolean repInsert(BoardVO board);
	
}// end interface
