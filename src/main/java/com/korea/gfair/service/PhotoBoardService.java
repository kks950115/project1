package com.korea.gfair.service;

import java.io.File;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.PhotoDTO;
import com.korea.gfair.domain.PhotoVO;
import com.korea.gfair.domain.PhotoVO2;

public interface PhotoBoardService {
	
public abstract List<PhotoVO2> getList();                        //게시판 목록조회
	
	public abstract List<PhotoVO2> getListPerPage(Criteria cri);     //한 페이지 분량만큼만 목록조회
	
	public abstract boolean register(MultipartFile uploadFile);               //새로운 게시글 등록
	
	public abstract boolean modify(Integer fid, MultipartFile uploadFile);                 //기존 게시글 변경
	
	public abstract boolean remove(Integer fid);                    //기존 게시글 삭제
	
	public abstract PhotoVO read(Integer fid);                       //기존 게시글의 상세조회
	
	public abstract int getTotal(Criteria cri);                     //총 게시글 객수를 조회하여 반환

	public abstract boolean checkImageType(File file);

	public abstract String getFolder();
	
	public abstract ResponseEntity<byte[]> getFile(String fileName);

	public abstract void fileDelete(Integer fid);//db정보만 삭제하기

	public void imgFileDelete(Integer fid);//그림파일만 삭제하기


}//end interface
