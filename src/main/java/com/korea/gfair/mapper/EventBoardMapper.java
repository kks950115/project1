package com.korea.gfair.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.EventDTO;
import com.korea.gfair.domain.EventVO;

public interface EventBoardMapper {
	
public abstract int insert(EventDTO dto);
	
	public abstract int insertSelectKey(@Param("dto")EventDTO dto);
	
	public abstract List<EventVO> getListWithPaging(Criteria cri);
	
	public abstract EventVO read(Integer bno);
	
	public abstract EventVO getWithFid(Integer fid);
	
	public abstract int update(EventDTO dto);
	
	public abstract int delete(Integer bno);
	
	public abstract int deleteWithFid(Integer fid);
	
	public abstract int getTotalCount(Criteria cri);
	
	public abstract boolean readcnt(Integer bno);
	
	public abstract boolean readcntWithFid(Integer fid);
}//end interface
