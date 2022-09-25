package com.korea.gfair.service;

import java.util.List;

import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.ExhibitionDTO;
import com.korea.gfair.domain.ExhibitionVO;
import com.korea.gfair.domain.FullCalendarDTO;


public interface ExhibitionService{
	
	public abstract List<ExhibitionVO> getVisitList() throws Exception;
	public abstract List<FullCalendarDTO> getVisitPartList(List<ExhibitionVO> exList) throws Exception;
	public abstract List<ExhibitionVO> getExPagingList(Criteria cri) throws Exception;

	public abstract ExhibitionVO getSchedule(Integer exno) throws Exception;
	
	public abstract void register(ExhibitionDTO exDTO) throws Exception;
	public abstract void modify(ExhibitionDTO exDTO) throws Exception;
	public abstract void remove(List<Integer> exnoList) throws Exception;
	
	public abstract Integer getTotalCount(Criteria cri) throws Exception;
	public abstract List<ExhibitionVO> getEx() throws Exception;

	//--------------------- danny --------------------//
	public abstract ExhibitionVO get(Integer exno);
	
	public abstract List<ExhibitionVO> getList();
}//end interface
