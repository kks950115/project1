package com.korea.gfair.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.korea.gfair.domain.PreApplicationDTO;
import com.korea.gfair.domain.PreApplicationVO2;

public interface PreApplicationMapper {
	
	public abstract int insert(@Param("dto") PreApplicationDTO dto);
	public abstract List<PreApplicationVO2> getList(String memberid);
}//end interface
