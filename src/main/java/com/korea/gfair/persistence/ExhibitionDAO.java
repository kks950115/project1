package com.korea.gfair.persistence;

import java.util.List;

import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.ExhibitionDTO;
import com.korea.gfair.domain.ExhibitionVO;


public interface ExhibitionDAO {

	public abstract List<ExhibitionVO> visitList() throws Exception;
	public abstract List<ExhibitionVO> exPagingList(Criteria cri) throws Exception;
	public abstract ExhibitionVO schedule(Integer exno) throws Exception;
	
	public abstract void insert(ExhibitionDTO exDTO) throws Exception;
	public abstract void update(ExhibitionDTO exDTO) throws Exception;
	public abstract void delete(List<Integer> exnoList) throws Exception;
	
	public abstract Integer totalCount(Criteria cri) throws Exception;
	
	//최근6개월 전시목록. visitList는 전체기간. 나중에 합치던지 그대로 두던지
	public abstract List<ExhibitionVO> searchEx() throws Exception;
}//end interface
