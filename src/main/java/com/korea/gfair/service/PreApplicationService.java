package com.korea.gfair.service;

import java.util.List;

import com.korea.gfair.domain.PreApplicationDTO;
import com.korea.gfair.domain.PreApplicationVO2;

public interface PreApplicationService {
	public abstract boolean register(PreApplicationDTO dto);
	public abstract List<PreApplicationVO2> getList(String memberid);
}//end inteface
