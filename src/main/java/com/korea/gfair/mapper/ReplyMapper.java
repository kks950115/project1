package com.korea.gfair.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.ReplyDTO;
import com.korea.gfair.domain.ReplyVO;

public interface ReplyMapper {
	public abstract int insert(ReplyDTO dto);
	
	public abstract ReplyVO read(Integer bno);
	
	public abstract int delete(Integer reno);
	
	public abstract int update(ReplyDTO dto);
	
	public abstract List<ReplyVO> getListWithPaging(
				@Param("cri") Criteria cri,
				@Param("bno") Integer bno
		);
	public abstract int getCountByBno(Integer bno);
}//end inteface
