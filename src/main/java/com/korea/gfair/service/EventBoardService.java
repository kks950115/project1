package com.korea.gfair.service;

import java.io.File;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.EventDTO;
import com.korea.gfair.domain.EventVO;

public interface EventBoardService {
	
public abstract List<EventVO> getListPerPage(Criteria cri);
	
	public abstract boolean register(String path, EventDTO dto, MultipartFile uploadFile);
	
	public abstract EventVO get(Integer bno);
	
	public abstract EventVO getWithFid(Integer fid);
	
	public abstract int modify(EventDTO boardDTO, MultipartFile uploadFile);
	
	public abstract boolean remove(Integer bno);
	
	public abstract boolean removeWithFid(Integer fid);
	
	public abstract int getTotal(Criteria cri);
	
	public abstract boolean checkImageType(File file);
	
	public abstract String getFolder();
	
	public abstract ResponseEntity<byte[]> getFile(String fileName);

	public abstract boolean readcnt(Integer bno);
	
	public abstract boolean readcntWithFid(Integer fid);
}//end interface
