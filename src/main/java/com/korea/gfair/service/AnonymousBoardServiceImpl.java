package com.korea.gfair.service;

import java.util.List;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Service;

import com.korea.gfair.domain.AttachFileDTO;
import com.korea.gfair.domain.BoardDTO;
import com.korea.gfair.domain.BoardSearchFileVO;
import com.korea.gfair.domain.BoardVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.mapper.BoardMapper;

import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j2;


@Log4j2
@NoArgsConstructor
@Service
public class AnonymousBoardServiceImpl implements AnonymousBoardService{

			
	@Autowired private BoardMapper mapper;
	@Autowired private UploadFileService fileService;
	
	
	@Override
	public List<BoardVO> getList(Criteria cri, String bname) throws Exception {
		log.debug("getList() invoked");

		Objects.nonNull(this.mapper);

		return this.mapper.list(cri, bname);
	}//getList

	
	@Override
	public BoardVO getSelect(Integer bno) throws Exception {
		log.debug("getSelect() invoked");
		
		Objects.nonNull(mapper);
		
		return this.mapper.select(bno);
	}//getSelect

	
	@Override
	public boolean register(BoardDTO dto, @Nullable AttachFileDTO fileDTO) throws Exception {
		log.debug("register({}) invoked",fileDTO);
		
		//매퍼확인
		Objects.nonNull(mapper);
		Objects.nonNull(fileService);
//		
		Integer fid = null;
		//전송받은 파일이 있을때만 파일insert
		if(!fileDTO.getFrename().equals("")) {
			
			fid = this.fileService.fileInsert(fileDTO);
		}//if
		
		log.info("갑자기 또 왜 안되냐 ㅋㅋ..fid : "+fid);
		
		//작성된 게시글 VO객체 생성
		BoardVO board = new BoardVO	(
				dto.getBno(), 
				dto.getReproot(),
				dto.getRepstep(), 
				dto.getRepindent(), 
				dto.getTitle(), 
				dto.getContent(), 
				dto.getMemberid(), 
				dto.getInsert_ts(), 
				dto.getUpdate_ts(), 
				dto.getReadcnt(), 
				dto.getBname(), 
				fid, 
				dto.getNotice_tf(), 
				dto.getPublic_tf(),
				dto.getReply_tf());	
		
		log.info("갑자기 또 왜 안되냐 ㅋㅋ.. board : "+board);
		
		return this.mapper.insert(board);
	}//register

	
	@Override
	public boolean remove(BoardDTO dto) throws Exception {
		log.debug("remove() invoked");
		
		Objects.nonNull(mapper);
		
		boolean result = this.mapper.delete(dto.getBno());
		
		if(dto.getFid() != null) {//파일정보가 있을 때 지워주기
			
			this.fileService.fileDelete(dto.getFid());
			this.fileService.imgFileDelete(dto.getFid());
		}//if
		
		return result;
	}//remove

		
	@Override
	public boolean modify(BoardDTO dto, @Nullable AttachFileDTO fileDTO) throws Exception {
		log.debug("modify({},{}) invoked",dto,fileDTO);
		
		//결과값 리턴
		boolean result = false;
		
		//매퍼확인
		Objects.nonNull(this.mapper);
		Objects.nonNull(this.fileService);
		
//		bno로 기존게시글+파일정보 1개 찾기
		BoardSearchFileVO boardSearchFileVO = this.fileService.getBoardFile(dto.getBno());
		
		//수정할 게시글의 파일id찾기
//		Integer fileFid = this.getSelect(dto.getBno()).getFid();
		Integer fileFid = boardSearchFileVO.getFid();
		
		
		//기존파일정보 유무에 따른 처리
		if(fileFid != null) {//게시글에 기존 파일정보가 있을 때
			log.info("<<<<<<<<<<<<<<<<<<<<<<<파일정보 있을 때>>>>>>>>>>>>>>>>>>>>>>>");
			
//			//	bno로 기존게시글+파일정보 1개 찾기
//			BoardSearchFileVO boardSearchFileVO = this.fileService.getBoardFile(dto.getBno());
			
			if(fileDTO.getFrename().equals("")) {//첨부된 파일이 없을 때(기존파일 있었음)
				
				//파일아이디 없애기
				fileFid = null;
				
				//--------------수정된 정보로 VO생성-------------------------------------------------
				BoardVO board = new BoardVO	(
						dto.getBno(), 
						dto.getReproot(),
						dto.getRepstep(), 
						dto.getRepindent(), 
						dto.getTitle(), 
						dto.getContent(), 
						dto.getMemberid(), 
						dto.getInsert_ts(), 
						dto.getUpdate_ts(), 
						dto.getReadcnt(), 
						dto.getBname(), 
						fileFid, 				//파일정보 없애기
						dto.getNotice_tf(), 
						dto.getPublic_tf(),
						dto.getReply_tf());	
				
				//변경된 정보로 파일업로드
				result = this.mapper.update(board);
				
				//기존 이미지파일+db정보 삭제하기
				this.fileService.imgFileDelete(boardSearchFileVO.getFid());//기존 이미지파일 삭제
				this.fileService.fileDelete(boardSearchFileVO.getFid());//기존 파일정보 삭제
				
				
				//--파일정보가 변경되었다면 파일정보 수정하기
			} else if( !fileDTO.getFrename().equals("") && boardSearchFileVO.getFrename() != fileDTO.getFrename()) {//첨부된 파일이 있을 때

				//기존 이미지파일만 삭제하기
				this.fileService.imgFileDelete(boardSearchFileVO.getFid());
				
				//FID는 놔두고 새 정보로 파일수정
				this.fileService.fileModify(boardSearchFileVO.getFid(),fileDTO);
				log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>확인용!!!!0826 : ");
			
				//--------------수정된 정보로 VO생성-------------------------------------------------
				BoardVO board = new BoardVO	(
						dto.getBno(), 
						dto.getReproot(),
						dto.getRepstep(), 
						dto.getRepindent(), 
						dto.getTitle(), 
						dto.getContent(), 
						dto.getMemberid(), 
						dto.getInsert_ts(), 
						dto.getUpdate_ts(), 
						dto.getReadcnt(), 
						dto.getBname(), 
						fileFid, 			//기존 fid
						dto.getNotice_tf(), 
						dto.getPublic_tf(),
						dto.getReply_tf());	
				
				//변경된 정보로 파일업로드
				result = this.mapper.update(board);
				
			}//if-else if
			
		} else {//기존 파일정보가 없을때 == null
			log.info("<<<<<<<<<<<<<<<<<<<<<<<파일정보 없을 때>>>>>>>>>>>>>>>>>>>>>>>");
			
			//전송받은 파일이 있을때만 파일insert
			if(!fileDTO.getFrename().equals("")) {
				log.info("------------------파일정보 있을 때------------------");
				fileFid = this.fileService.fileInsert(fileDTO);
				log.info("3. null값 진짜 지겨워죽겠다!!!!! 어휴 fileFid: "+fileFid);
			}//if
			
			//--------------수정된 정보로 VO생성-------------------------------------------------
			BoardVO board = new BoardVO	(
					dto.getBno(), 
					dto.getReproot(),
					dto.getRepstep(), 
					dto.getRepindent(), 
					dto.getTitle(), 
					dto.getContent(), 
					dto.getMemberid(), 
					dto.getInsert_ts(), 
					dto.getUpdate_ts(), 
					dto.getReadcnt(), 
					dto.getBname(), 
					fileFid, 			//새로 생성한 값으로 수정
					dto.getNotice_tf(), 
					dto.getPublic_tf(),
					dto.getReply_tf());	
			
			//변경된 정보로 파일업로드
			result = this.mapper.update(board);
		}//if-else
		return result;
	}//modify

	
	@Override
	public Integer getTotalCount(Criteria cri, String bname) throws Exception {
		log.debug("getTotalCount() invoked");
		
		Objects.nonNull(mapper);
	
		return this.mapper.totalCount(cri,bname);
	}

	
	@Override
	public boolean readCount(Integer bno) throws Exception {
		log.debug("readCount(dto) invoked");
		
		Objects.nonNull(mapper);
	
		boolean result = this.mapper.readcnt(bno);
		
		return result;
	}//readCount

	
	@Override
	public boolean retrieve(BoardDTO dto, @Nullable AttachFileDTO fileDTO) throws Exception {
		log.debug("repRegister(dto) invoked");
		
		Objects.nonNull(this.mapper);
		Objects.nonNull(this.fileService);
		
		this.mapper.repStepUp(dto.getReproot(),dto.getRepstep());
		
		Integer fid = null;
		//전송받은 파일이 있을때만 파일insert
		if(!fileDTO.getFrename().equals("")) {
			
			fid = this.fileService.fileInsert(fileDTO);
		}//if
		
		log.info(">>>>>>>>>>>>>>>>>>>>>>>>retrievefid : "+fid);
		
		
		BoardVO board = new BoardVO	(
				dto.getBno(), 
				dto.getReproot(),
				dto.getRepstep(), 
				dto.getRepindent(), 
				dto.getTitle(), 
				dto.getContent(), 
				dto.getMemberid(), 
				dto.getInsert_ts(), 
				dto.getUpdate_ts(), 
				dto.getReadcnt(), 
				dto.getBname(), 
				fid, 
				dto.getNotice_tf(), 
				dto.getPublic_tf(),
				dto.getReply_tf());	
		
		return this.mapper.repInsert(board);
	}//repInsert

	
}//end class
