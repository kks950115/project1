package com.korea.gfair.persistence;

import java.util.List;

import com.korea.gfair.domain.ReplyDTO;
import com.korea.gfair.domain.ReplyVO;

public interface ReplyDAO {

	public List<ReplyVO> select(ReplyDTO dto) throws Exception;
	public boolean insert(ReplyDTO dto) throws Exception;
	public boolean delete(ReplyDTO dto) throws Exception;
}//end interface
