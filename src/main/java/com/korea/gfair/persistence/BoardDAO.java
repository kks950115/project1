package com.korea.gfair.persistence;

import java.util.List;

import com.korea.gfair.domain.BoardDTO;
import com.korea.gfair.domain.BoardVO;
import com.korea.gfair.domain.Criteria;

public interface BoardDAO {

	public List<BoardVO> selectAllList(Criteria cri) throws Exception ;
	public BoardVO selectOneList(BoardDTO dto) throws Exception ;
	public int selectTotalCount (Criteria cri) throws Exception ;
	public boolean updateList(BoardDTO dto) throws Exception ;
	
	public boolean delete(BoardDTO dto) throws Exception;
	
	public boolean insert(BoardDTO dto) throws Exception;
	public boolean insertRetreive(BoardDTO dto) throws Exception;
	
}//end interface
