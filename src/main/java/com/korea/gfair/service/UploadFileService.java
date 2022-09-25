package com.korea.gfair.service;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import com.korea.gfair.domain.AttachFileDTO;
import com.korea.gfair.domain.AttachFileVO;
import com.korea.gfair.domain.BoardDTO;
import com.korea.gfair.domain.BoardSearchFileVO;
import com.korea.gfair.domain.MemberDTO;
import com.korea.gfair.domain.UploadFileDTO;
import com.korea.gfair.domain.UploadFileVO;


public interface UploadFileService {


	public abstract Integer fileInsert(AttachFileDTO dto) throws Exception;//db에 넣기
	public abstract Integer fileInsert(MultipartFile uploadFile) throws Exception;//첨부파일 하나 찾기
	
	public abstract void fileDelete(Integer fid) throws Exception;//db정보만 삭제하기
	
	public abstract void fileModify(Integer fid, AttachFileDTO dto) throws Exception;//db에서 수정하기
	public abstract void fileModify(Integer fid, MultipartFile uploadFile) throws Exception;//db에서 수정하기
	
	public abstract UploadFileVO fileByFid(Integer fid) throws Exception;//첨부파일 하나 찾기
	public abstract BoardSearchFileVO getBoardFile(Integer bno) throws Exception;
	//글번호로 첨부파일 찾기(게시글,첨부파일 게시판 조인)
	
	public void imgFileDelete(Integer fid) throws Exception;//그림파일만 삭제하기
	public abstract String getFolder() throws Exception;//날마다의 폴더경로얻기
	public abstract boolean checkImageType(File file) throws Exception;//이미지파일인지 체크
	
	public ResponseEntity<List<AttachFileDTO>> upload(MultipartFile[] uploadFile) throws Exception;//파일 업로드시키기
	public ResponseEntity<byte[]> getFile(String fileName) throws Exception;//업로드된 파일 지정폴더에 저장하기
	public ResponseEntity<Resource> downloadFile(String fileName) throws Exception;//브라우저에서 다운로드 처리
	public ResponseEntity<String> delete(String fileName, String type) throws Exception;//썸네일 x눌렀을때

	
//	--------------------------다은---------------------------------------------------
	public abstract int uploadFile(MultipartFile file) throws Exception;
	public abstract UploadFileVO getFile(UploadFileDTO dto) throws Exception;
	
	
	//--------------------이진성-----------------------------//
	//FILE 처리 
	public abstract void uploadFile(AttachFileDTO dto);
	public abstract void addFileId(BoardDTO dto);
	public abstract AttachFileVO getFileById(BoardDTO dto);
	public abstract AttachFileVO getFileById(Integer fid);
	
	public abstract void updateFile(AttachFileDTO dto);
	
	public abstract void removeExistFileFromBoard(BoardDTO dto);
	
	public abstract void load_img(BoardDTO dto, AttachFileVO file, HttpServletResponse response);
	public abstract void uploadFileByModify(BoardDTO dto, MultipartFile file) throws Exception;
	public abstract void uploadFileByWrite(BoardDTO dto, MultipartFile file) throws Exception;
	
	
	public abstract void uploadFileByRegister(MemberDTO dto, MultipartFile file) throws Exception;
	
}//end interface
