package com.korea.gfair.persistence;

import com.korea.gfair.domain.UploadFileDTO;
import com.korea.gfair.domain.UploadFileVO;

public interface UploadFileDAO {
	
	public abstract int insertFile(UploadFileDTO dto);
	public abstract UploadFileVO selectFile(UploadFileDTO dto);
}//end interface
