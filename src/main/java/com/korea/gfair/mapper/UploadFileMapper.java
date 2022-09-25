package com.korea.gfair.mapper;

import com.korea.gfair.domain.AttachFileDTO;
import com.korea.gfair.domain.AttachFileVO;
import com.korea.gfair.domain.BoardDTO;
import com.korea.gfair.domain.BoardSearchFileVO;
import com.korea.gfair.domain.UploadFileVO;

public interface UploadFileMapper {
	//나현아
	public abstract Integer insert(UploadFileVO fildVO);
	public abstract void delete(Integer fid);
	public abstract void modify(UploadFileVO fileVO);//첨부파일값 수정하기
	public abstract BoardSearchFileVO boardFile(Integer bno);
	//글번호로 첨부파일 찾기(게시글,첨부파일 게시판 조인)
	
	public abstract UploadFileVO fileByFid(Integer fid);//첨부파일 하나 찾기
	
	public abstract UploadFileVO fileByBno(Integer bno);
	
	//====================================================
	
	//이진성
	public abstract void insertFile(AttachFileDTO dto);
	public abstract void updateFileId(BoardDTO dto);
	public abstract AttachFileVO selectFileById(BoardDTO dto);
	public abstract AttachFileVO selectFileById(Integer fid);
	
	public abstract void updateFile(AttachFileDTO dto);
	
	public abstract void updateExistFileFromBoard(BoardDTO dto);
	public abstract void deleteExistFile(BoardDTO dto);
	

	
}
