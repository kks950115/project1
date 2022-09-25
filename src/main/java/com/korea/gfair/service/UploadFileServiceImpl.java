package com.korea.gfair.service;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import com.korea.gfair.domain.AttachFileDTO;
import com.korea.gfair.domain.AttachFileVO;
import com.korea.gfair.domain.BoardDTO;
import com.korea.gfair.domain.BoardSearchFileVO;
import com.korea.gfair.domain.MemberDTO;
import com.korea.gfair.domain.UploadFileDTO;
import com.korea.gfair.domain.UploadFileVO;
import com.korea.gfair.mapper.UploadFileMapper;
import com.korea.gfair.persistence.UploadFileDAO;
import com.korea.gfair.util.UUIDGenerator;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;
import net.coobird.thumbnailator.Thumbnailator;


@Service
@NoArgsConstructor
@Log4j2
public class UploadFileServiceImpl implements UploadFileService {

	@Setter(onMethod_ = @Autowired)
	private UploadFileDAO dao;
	
	@Autowired private UploadFileMapper fileMapper;
	
	//private String imgFileName = "C:/opt/eclipse/eclipse-workspace/JEE/G-FAIR-BACKEND/src/main/webapp/resources/img";
	private String imgFileName = "C:/Users/u0909/Documents/Temp/upload/";
//	DTO받아서 파일insert
	@Override
	public Integer fileInsert(AttachFileDTO dto) throws Exception {
		log.debug("fileInsert(dto) invoked");
		
		UploadFileVO vo = new UploadFileVO
						(null,
						dto.getFrename(),
						dto.getFpath(),
						dto.getForname());
		
		Objects.nonNull(fileMapper);
		this.fileMapper.insert(vo);//selectKey로 property를 이용해서 vo객체에 fid값을 넣어준다.
		
		return vo.getFid();
	}//fileInsert
	
	
//	전송파일을 받아서 파일insert
	@Override
	public Integer fileInsert(MultipartFile uploadFile) throws Exception {
		log.info("fileInsert2(uploadFile) invoked",uploadFile);
		
		//--------------------------------폴더 지정----------------------------------------
		//업로드할 폴더 경로
		String uploadFolder = imgFileName;//+2021/08/18
		
		//지정된 경로+이름으로 폴더찾기??C:/Temp/upload + /2021/08/18
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("\t + **1. uploadPath : "+uploadPath);
		
		//만약에 폴더가 존재하지 않으면 uploadPath(yyyy/MM/dd) 이름으로 폴더 생성함
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}//if
		
		//--------------------------------------------------------------------------------
		
		//업로드한 파일을 꺼낸다.
	
		log.info("--------------------------------------------------------------------");
		log.info("File Name 0.: "+uploadFile.getName());
		log.info(">>>>>>>>>>>>>>>>>>>>upload File getSize: "+uploadFile.getSize());
		
		//파일 정보를 저장할 dto 생성
		AttachFileDTO dto = new AttachFileDTO();
		//---업로드경로 저장 2021/08/18
		dto.setFpath("/"+getFolder());
		
		//업로드할 파일이름의 풀네임을 얻어냄-->jsp관계.JPG 아래랑 같은데?,...
		String uploadFileFullName = uploadFile.getOriginalFilename();
		log.info("upload File Name 1.: "+uploadFileFullName);
		
		//파일 풀네임으로 파일명만 얻어냄-->jsp관계.JPG
		String uploadFileName = uploadFileFullName.substring(uploadFileFullName.lastIndexOf("\\")+1);
		log.info("only file Name 2. : "+uploadFileName);
		
		//---뽑아낸 파일명을 dto객체에 저장-->jsp관계.JPG
		dto.setForname(uploadFileName);
//=============================================================		
//			파일명 중복방지를 위해 uuid 생성
		UUID uuid = UUID.randomUUID();
		//---생성한 uuid를 dto객체에 저장
		dto.setFrename(uuid.toString());
//			dto.setUuid(str);
		
		//uuid+업로드한 파일명으로 교체
		String uploadFileUUIDName = uuid.toString() + "_" + uploadFileName;
//			String uploadFileUUIDName = str + "_" + uploadFileName;
//			
		//C:/Temp/upload+2021/08/18 +(uuid+업로드한 파일명)
		File saveFile = new File(uploadPath, uploadFileUUIDName);
		
		//위 경로로 파일을 전송함
		uploadFile.transferTo(saveFile);
		
		log.info(">>>>>>>DTO 객체 확인용 : "+dto);
		
		return this.fileInsert(dto);//selectKey를 이용해서 fid값 리턴
	}//uploadAjaxPost

	
	@Override
	public void fileModify(Integer fid, AttachFileDTO dto) throws Exception {
		log.debug("fileDelete(dto) invoked");
		
		UploadFileVO vo = new UploadFileVO(fid, dto.getFrename(), dto.getFpath(), dto.getForname());
		
		this.fileMapper.modify(vo);
	}//fileModify
	
	
	@Override
	public void fileModify(Integer fid, MultipartFile uploadFile) throws Exception {
		log.info("fileModify(uploadFile) invoked",uploadFile);
		
		//--------------------------------폴더 지정----------------------------------------
		//업로드할 폴더 경로
		String uploadFolder = imgFileName;//+2021/08/18
		
		//지정된 경로+이름으로 폴더찾기??C:/Temp/upload + /2021/08/18
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("\t + **1. uploadPath : "+uploadPath);
		
		//만약에 폴더가 존재하지 않으면 uploadPath(yyyy/MM/dd) 이름으로 폴더 생성함
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}//if
		
		//--------------------------------------------------------------------------------
		
		//업로드한 파일을 꺼낸다.
	
		log.info("--------------------------------------------------------------------");
		log.info("File Name 0.: "+uploadFile.getName());
		log.info(">>>>>>>>>>>>>>>>>>>>upload File getSize: "+uploadFile.getSize());
		
		//파일 정보를 저장할 dto 생성
		AttachFileDTO dto = new AttachFileDTO();
		//---업로드경로 저장 2021/08/18
		dto.setFpath("/"+getFolder());
		
		//업로드할 파일이름의 풀네임을 얻어냄-->jsp관계.JPG 아래랑 같은데?,...
		String uploadFileFullName = uploadFile.getOriginalFilename();
		log.info("upload File Name 1.: "+uploadFileFullName);
		
		//파일 풀네임으로 파일명만 얻어냄-->jsp관계.JPG
		String uploadFileName = uploadFileFullName.substring(uploadFileFullName.lastIndexOf("\\")+1);
		log.info("only file Name 2. : "+uploadFileName);
		
		//---뽑아낸 파일명을 dto객체에 저장-->jsp관계.JPG
		dto.setForname(uploadFileName);
//=============================================================		
//			파일명 중복방지를 위해 uuid 생성
		UUID uuid = UUID.randomUUID();
		//---생성한 uuid를 dto객체에 저장
		dto.setFrename(uuid.toString());
//			dto.setUuid(str);
		
		//uuid+업로드한 파일명으로 교체
		String uploadFileUUIDName = uuid.toString() + "_" + uploadFileName;
//			String uploadFileUUIDName = str + "_" + uploadFileName;
//			
		//C:/Temp/upload+2021/08/18 +(uuid+업로드한 파일명)
		File saveFile = new File(uploadPath, uploadFileUUIDName);
		
		//위 경로로 파일을 전송함
		uploadFile.transferTo(saveFile);
		
		log.info(">>>>>>>DTO 객체 확인용 : "+dto);
		
		
		UploadFileVO vo = new UploadFileVO(
				fid, 
				dto.getFrename(),
				dto.getFpath(),
				dto.getForname());
		
		this.fileMapper.modify(vo);
	}//fileModify
	
	
	@Override
	public void fileDelete(Integer fid) throws Exception {//db정보만 삭제하기
		log.debug("fileDelete({}) invoked",fid);
		
		//파일삭제매퍼 호출
		this.fileMapper.delete(fid);
	}//delete
	
	
	@Override
	public void imgFileDelete(Integer fid) throws Exception {//그림파일만 삭제하기
		log.debug("imgFileDelete({}) invoked",fid);
		
		//fid로 파일정보 불러오기
		UploadFileVO fileVO = this.fileByFid(fid);
		
		//기존파일정보로 파일부터 삭제하기(무조건 그림파일)
		String fileName = fileVO.getFpath()+"/s_"+fileVO.getFrename()+"_"+fileVO.getForname();
		
		//업로드할 폴더 경로
		String uploadFolder = this.imgFileName;
		
		File file = new File(uploadFolder+fileName);
		file.delete();
		
		//섬넬이미지까지 삭제
		String largeFileName = file.getAbsolutePath().replace("s_","");
	
		log.info("\t +largeFileName : "+largeFileName);
		
		file = new File(largeFileName);
		file.delete();
	}//imgFileDelete

	
	@Override
	public UploadFileVO fileByFid(Integer fid) throws Exception {
		log.debug("fileDelete(dto) invoked");
		
		Objects.nonNull(fileMapper);
		
		return this.fileMapper.fileByFid(fid);
	}//fileByFid
	
	

	@Override
	public String getFolder() throws Exception {
		log.debug("getFolder() invoked");
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		log.info("\t +SimpleDateFormat : "+sdf);
		
		Date date = new Date();
		log.info("\t +date : "+date);
		
		String str = sdf.format(date);
		log.info("\t +str : "+str);
		
		return str;
//		return str.replace("-", File.separator);
	}//getFolder
	


	@Override
	public boolean checkImageType(File file) throws Exception {
		log.debug("checkImageType() invoked");
		
		//파일의 type을 리턴받는다.
		String contentType = Files.probeContentType(file.toPath());
		log.info("contentType : "+contentType);
		
		//이미지 파일이라면?
		if(contentType.startsWith("image")) {
			return true;
		}//if
		
		return false;
		
	}//checkImageType

	@Override
	public ResponseEntity<List<AttachFileDTO>> upload(MultipartFile[] uploadFile) throws Exception {
		log.info("uploadAjaxPost() invoked");
		
		//반환할 리스트를 생성
		List<AttachFileDTO> list = new ArrayList<>();
		
		//--------------------------------폴더 지정----------------------------------------
		//업로드할 폴더 경로
		String uploadFolder = this.imgFileName;//+2021/08/18
		
		//지정된 경로+이름으로 폴더찾기??C:/Temp/upload + /2021/08/18
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("\t + **1. uploadPath : "+uploadPath);
		
		//만약에 폴더가 존재하지 않으면 uploadPath(yyyy/MM/dd) 이름으로 폴더 생성함
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}//if
		
		//--------------------------------------------------------------------------------
		
		//업로드한 파일을 꺼낸다.
		for(MultipartFile multipartFile : uploadFile) {
			log.info("--------------------------------------------------------------------");
			log.info("File Name 0.: "+multipartFile.getName());
			log.info(">>>>>>>>>>>>>>>>>>>>upload File getSize: "+multipartFile.getSize());
			
			//파일 정보를 저장할 dto 생성
			AttachFileDTO dto = new AttachFileDTO();
			//---업로드경로 저장 2021/08/18
			dto.setFpath("/"+getFolder());
			
			//업로드할 파일이름의 풀네임을 얻어냄-->jsp관계.JPG 아래랑 같은데?,...
			String uploadFileFullName = multipartFile.getOriginalFilename();
			log.info("upload File Name 1.: "+uploadFileFullName);
			
			//파일 풀네임으로 파일명만 얻어냄-->jsp관계.JPG
			String uploadFileName = uploadFileFullName.substring(uploadFileFullName.lastIndexOf("\\")+1);
			log.info("only file Name 2. : "+uploadFileName);
			
			//---뽑아낸 파일명을 dto객체에 저장-->jsp관계.JPG
			dto.setForname(uploadFileName);
	//=============================================================		
//			파일명 중복방지를 위해 uuid 생성
			UUID uuid = UUID.randomUUID();
			//---생성한 uuid를 dto객체에 저장
			dto.setFrename(uuid.toString());
//			dto.setUuid(str);
			
			
			//uuid+업로드한 파일명으로 교체
			String uploadFileUUIDName = uuid.toString() + "_" + uploadFileName;
//			String uploadFileUUIDName = str + "_" + uploadFileName;
//			
			//C:/Temp/upload+2021/08/18 +(uuid+업로드한 파일명)
			File saveFile = new File(uploadPath, uploadFileUUIDName);
			
			//위 경로로 파일을 전송함
			multipartFile.transferTo(saveFile);
			
			if(checkImageType(saveFile)) {//생성할 파일이 이미지라면
				//이미지파일일때 dto객체에 결과값 저장
//				dto.setFiletype(true);
				
				//s_로 구분된 파일명으로 지정하고 그걸로 파일 출력스트림을 만든다.
				FileOutputStream thumbnail = 
						new FileOutputStream(//C:/Temp/upload+2021/08/18 +s_ + uuid~
								new File(uploadPath, "s_"+uploadFileUUIDName));
				BufferedOutputStream thumbnailbuf = new BufferedOutputStream(thumbnail);
				
				try(thumbnail;thumbnailbuf){
					
					//메이븐을 이용해서 썸네일을 생성한다.
					//multipartFile의 인풋스트림을 사용하여 이미지를 받고, 아웃풋스트림으로 해당파일을 출력한다. 뒤엔 크기지정
					Thumbnailator.createThumbnail(multipartFile.getInputStream(),thumbnailbuf, 100, 100);
					
					thumbnailbuf.flush();
				}//try-with-resources
			}//if
			
			log.info(">>>>>>>DTO 객체 확인용 : "+dto);
			
			list.add(dto);
		}//enhanced for
		
		return new ResponseEntity<>(list, HttpStatus.OK);//json데이터로 만들어서 반환
	}//uploadAjaxPost

	
	@Override
	public ResponseEntity<byte[]> getFile(String fileName) throws Exception {
		log.debug("getFile({}) invoked",fileName);
		
		String uploadFolder = this.imgFileName;//+2021/08/18
		
		//fileName --> 이 파일이 존재하는 경로
		File file = new File(uploadFolder,fileName);
		log.info("\t + >>getFile>>>>>>>>>file : "+file);
		log.info("\t + >>getFile>>>>>>>>>file.toPath() : "+file.toPath());
		
		ResponseEntity<byte[]> result = null;
		
		//헤더 조작 추가
		HttpHeaders header = new HttpHeaders();
		
		//헤더에 추가. 키밸류로 이름과 그 값(파일의 mime타입을 알아서 정해주는 메소드를 이용)을 지정.
		header.add( "content-Type", 
					Files.probeContentType(file.toPath()));
		
		//유틸기능으로 파일의 바이트배열을 카피해서 바디에 넣고, 헤더와 상태코드를 같이 넣어서 생성자 호출한다.
		result = new ResponseEntity<>(
				FileCopyUtils.copyToByteArray(file),
				header, 
				HttpStatus.OK);
		
		return result;
	}//getFile

	@Override
	public ResponseEntity<Resource> downloadFile(String fileName) throws Exception {
		log.debug("fileName({}) invoked",fileName);
		
		//업로드할 폴더 경로
		String uploadFolder = "C:/Users/u0909/Documents/Temp/upload/";
		
		//파일에 관한 소스 얻기(해당 파일에 대한 풀경로를 얻는다)
		Resource resource = new FileSystemResource(uploadFolder+fileName);
		log.info("resource : "+resource);
		
		//소스에서 파일명만 추출한다.
		String resourceName = resource.getFilename();
		log.info(resourceName);
		
		//파일명 변환후 전송을 위해 헤더에 넣는다
		HttpHeaders headers = new HttpHeaders();
		headers.add( "content-Disposition",
		"attachment; filename="
		+new String(resourceName.getBytes("utf-8"),"iso-8859-1"));
	
		
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}//downloadFile

	
	@Override
	public ResponseEntity<String> delete(String fileName, String type) throws Exception {
		log.debug("delete({},{}) invoked",fileName,type);
		
		//업로드할 폴더 경로
		String uploadFolder = this.imgFileName;
		
		File file = new File(uploadFolder+URLDecoder.decode(fileName, "utf-8"));
		file.delete();
		
		
		if(type.equals("image")) {//썸넬이미지까지 삭제
			
			String largeFileName = file.getAbsolutePath().replace("s_","");
		
			log.info("\t +largeFileName : "+largeFileName);
			
			file = new File(largeFileName);
			file.delete();
		}//if
		
		return new ResponseEntity<String>("deleted",HttpStatus.OK);
	}//delete


	@Override
	public BoardSearchFileVO getBoardFile(Integer bno) throws Exception {
		log.debug("getBoardFile({}) invoked",bno);
		
		return this.fileMapper.boardFile(bno);
	}//getBoardFile


	//=============================다은=============================
	
	@Override
	public int uploadFile(MultipartFile file) throws Exception {
		
		log.debug("=====================================================");
		log.debug("uploadFile({})");
		log.debug("=====================================================");

		//----------------------------------------------
		//1.사용자가 첨부한 file을 저장할 fileDTO 객체 생성.
		//----------------------------------------------
		
		UploadFileDTO dto = new UploadFileDTO();
		
		//----------------------------------------------
		//2.UUID 생성
		//----------------------------------------------
		UUID uuid = UUIDGenerator.generateType1UUID();
		
		//----------------------------------------------
		//2-1. file 이름 변경
		//----------------------------------------------
		
		String frename =uuid+file.getOriginalFilename();
		
		//----------------------------------------------
		//3.file 저장경로 생성 
		//----------------------------------------------
//		LocalDate todaysDate = LocalDate.now(); // 현재 날짜 얻기. 
        SimpleDateFormat sdf= new SimpleDateFormat("yyyy/MM/dd");
        Date date = new Date();
        String todaysDate =sdf.format(date);
        String filePath = todaysDate+"/";   //날짜별로 저장할 폴더 경로
        String fullPath=imgFileName+filePath; 
       
        File dir = new File(fullPath); //fullPath로 파일 객체 생성

        if(!dir.isDirectory()){    //만약 경로에 지정된 폴더가 없으면
        	dir.mkdirs();          //폴더 새로 만들기 
        	log.debug("*****************mkdirs invoked.");
        }//if
		
        log.info("\t+ fullPath :{}", fullPath);
        //----------------------------------------------
		//4. file 저장. 
        //----------------------------------------------
			
		log.info("\t+ contentType: "+ file.getContentType());
		log.info("\t+ filename: "+ file.getOriginalFilename());
		log.info("\t+ filesize: "+ file.getSize());
		log.info("======================================");
		
	
		try {
			
			byte[] fileData = file.getBytes();		//바가지
														//생성자의 매개변수로 반드시 출력할 파일 경로를 지정해줘야한다. 
			FileOutputStream fos = new FileOutputStream(fullPath + frename);
			BufferedOutputStream bos = new BufferedOutputStream(fos);
			
			try(fos; bos;){
				
				//바가지 통째로 출력 버퍼로 쓰겠다. 모든 파일의 데이터가 바가지 안에 들어있기 때문. 
				bos.write(fileData);
				
				bos.flush();
			
			}//try-with-resources 
	
		}catch(IOException e) {
			e.printStackTrace();
		}//try-catch
		
		//----------------------------------------------
		//5. DTO 객체에 file name저장
		//----------------------------------------------
		
		dto.setForname(file.getOriginalFilename());
		dto.setFpath(filePath);
		dto.setFrename(frename);
		
		int fid =this.dao.insertFile(dto);
		
		log.info("*****fid :{} ******", fid);
		
		return fid;
	}//uploadFile

	@Override
	public UploadFileVO getFile(UploadFileDTO dto) throws Exception {
		log.debug("getFile({}) invoked.", dto);
		
		
		return this.dao.selectFile(dto);
	}//getFile
	
	
	//=============================================================//
	//================이진성=============//
	//================이진성=============//
	//================이진성=============//
	//================이진성=============//
	//FILE 처리 
	@Override
	public void uploadFile(AttachFileDTO dto) {
		this.fileMapper.insertFile(dto);
		
	}

	@Override
	public void addFileId(BoardDTO dto) {
		this.fileMapper.updateFileId(dto);
		
	}

	@Override
	public AttachFileVO getFileById(BoardDTO dto) {
		
		AttachFileVO file = this.fileMapper.selectFileById(dto);
		
		return file;
	}

	@Override
	public AttachFileVO getFileById(Integer fid) {
		AttachFileVO file = this.fileMapper.selectFileById(fid);
		return file;
	}//overLOADING

	@Override
	public void updateFile(AttachFileDTO dto) {
		this.fileMapper.updateFile(dto);
		
	}

	@Override
	public void removeExistFileFromBoard(BoardDTO dto) {
		this.fileMapper.updateExistFileFromBoard(dto);
		this.fileMapper.deleteExistFile(dto);
		
	}

	
	
	
	
	@Override
	public void load_img(BoardDTO dto, AttachFileVO file, HttpServletResponse response) {

		String path = imgFileName + file.getFpath() + "/";
		String fileReName = file.getFrename();
		
		File img = new File(path + fileReName);
		
		
		try {
			
			FileInputStream fis = new FileInputStream(img);
			OutputStream out = response.getOutputStream();
			
			
			byte[] buffer = new byte[1024];
			
			try(out; fis;) {
				
				int data;
				while ( (data = fis.read(buffer)) != -1) {
					out.write(buffer, 0, data);
				}//while
				
			}//try-with-resource
			
		} catch (Exception e) {
			
		}//try-catch
		
	}

	//글수
	@Override
	public void uploadFileByModify(BoardDTO dto, MultipartFile file) throws Exception {
		AttachFileDTO attachDTO = new AttachFileDTO();
		
		
		//String uploadDir = "/Users/jinsung/Desktop/temp/upload/";
		String uploadBaseDir = imgFileName;
		File uploadPath = new File(uploadBaseDir, getFolder());
		
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		
		if(file.getSize() > 0) {
			try {
				
				String uuidFile = UUID.randomUUID().toString();
				
				byte[] fileData = file.getBytes();
				FileOutputStream fos = new FileOutputStream(uploadPath + "/" + uuidFile + "_" + file.getOriginalFilename());
				BufferedOutputStream bos = new BufferedOutputStream(fos);
				
				try(fos; bos;) {
					attachDTO.setFpath("/"+getFolder());
					attachDTO.setForname(file.getOriginalFilename());
					attachDTO.setFrename(uuidFile + "_" + file.getOriginalFilename());
					
					bos.write(fileData);
					if(dto.getFid() != null) { //만약 기존 게시글의 파일이있는데 첨부파일 변경을 할때,
						attachDTO.setFid(dto.getFid()); //파일DTO의 FID값을 기존 게시글의 FID값으로 대치하고
						updateFile(attachDTO); //기존 파일테이블의 기존FID의 파일정보를 새로 첨부한 파일로 업데이트   
					} else { //만약 기존 게시글의 첨부된 파일이 없었는데 파일 첨부를 한다면,
						uploadFile(attachDTO); //새로운 파일테이블의 파일 업로드 
						addFileId(dto); //새로 작성한 게시글의 fid정보 업데이트
					}

				}//try-with-resources
				
			} catch (Exception e) {
				// TODO: handle exception
			}//try-catch
		}//if

		
	}

	
	//글쓸때
	@Override
	public void uploadFileByWrite(BoardDTO dto, MultipartFile file) throws Exception {
		AttachFileDTO attachDTO = new AttachFileDTO();
		
		
		//String uploadDir = "/Users/jinsung/Desktop/temp/upload/";
		String uploadBaseDir = imgFileName;
		File uploadPath = new File(uploadBaseDir, getFolder());
		
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		
		if(file.getSize() > 0) {
			try {
				
				String uuidFile = UUID.randomUUID().toString();
				 
				byte[] fileData = file.getBytes();
				FileOutputStream fos = new FileOutputStream(uploadPath + "/" + uuidFile + "_" + file.getOriginalFilename());
				BufferedOutputStream bos = new BufferedOutputStream(fos);
				
				try(fos; bos;) {
					attachDTO.setFpath("/"+getFolder());
					attachDTO.setForname(file.getOriginalFilename());
					attachDTO.setFrename(uuidFile + "_" + file.getOriginalFilename());
					
					bos.write(fileData);
					
					uploadFile(attachDTO);
					addFileId(dto);
				}//try-with-resources
				
			} catch (Exception e) {
				// TODO: handle exception
			}//try-catch
		}//if
		
	}

	//회원가입할때
	@Override
	public void uploadFileByRegister(MemberDTO dto, MultipartFile file) throws Exception {
		AttachFileDTO attachDTO = new AttachFileDTO();
		
		
		//String uploadDir = "/Users/jinsung/Desktop/temp/upload/";
		String uploadBaseDir = imgFileName;
		File uploadPath = new File(uploadBaseDir, getFolder());
		
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		
		if(file.getSize() > 0) {
			try {
				
				String uuidFile = UUID.randomUUID().toString();
				
				byte[] fileData = file.getBytes();
				FileOutputStream fos = new FileOutputStream(uploadPath + "/" + uuidFile + "_" + file.getOriginalFilename());
				BufferedOutputStream bos = new BufferedOutputStream(fos);
				
				try(fos; bos;) {
					attachDTO.setFpath("/"+getFolder());
					attachDTO.setForname(file.getOriginalFilename());
					attachDTO.setFrename(uuidFile + "_" + file.getOriginalFilename());
					
					bos.write(fileData);
					
					uploadFile(attachDTO);
				}//try-with-resources
				
			} catch (Exception e) {
				// TODO: handle exception
			}//try-catch
		}//if
		
	}

	//================================================================//
}//end class
