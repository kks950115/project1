package com.korea.gfair.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.korea.gfair.domain.AttachFileDTO;
import com.korea.gfair.service.UploadFileService;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;


@Log4j2
@NoArgsConstructor

@RequestMapping("/file/")
@Controller
public class UploadController {

	
	@Setter(onMethod_=@Autowired)
	private UploadFileService service;
	

	@PostMapping(value="uploadAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody                                                                                                                                                                                                                                                                                                                                                                                                        
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) throws Exception{
		log.debug("uploadAjaxPost(uploadFile) invoked");
		
		//List<AttachFileDTO>객체를 바디안에 담아서 넘겨줌
		return this.service.upload(uploadFile);
	}//uploadAjaxPost
	
	
	@GetMapping("display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String forname) throws Exception{
		log.debug("getFile(fileName) invoked");
		
		//byte[]를 바디안에 담아서 넘겨줌
		return this.service.getFile(forname);
	}//getFile
	
	
	@GetMapping(path="download", produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(String forname) throws Exception{
		log.debug("fileName({}) invoked",forname);
		
		return this.service.downloadFile(forname);
	}//downloadFile
	
	
	@PostMapping("deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String forname, String type) throws Exception{
		log.debug("deleteFile({},{}) invoked",forname,type);
		
		return this.service.delete(forname, type);
	}//deleteFile

}//end class
