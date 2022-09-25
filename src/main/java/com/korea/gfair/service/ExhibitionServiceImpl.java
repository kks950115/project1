package com.korea.gfair.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.korea.gfair.mapper.ExhibitionMapper;

import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.ExhibitionDTO;
import com.korea.gfair.domain.ExhibitionVO;
import com.korea.gfair.domain.FullCalendarDTO;
import com.korea.gfair.persistence.ExhibitionDAO;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Log4j2
@NoArgsConstructor

@Service
public class ExhibitionServiceImpl implements ExhibitionService {

	
	@Setter(onMethod_= {@Autowired})
	private ExhibitionDAO exhibitionDAO;

	
	@Override
	public List<ExhibitionVO> getVisitList() throws Exception {
		log.debug("getVisitList() invoked");
		
		return this.exhibitionDAO.visitList();
	}//getVisitList


	@Override
	public List<ExhibitionVO> getExPagingList(Criteria cri) throws Exception {
		log.debug("getExPagingList() invoked");
		
		return this.exhibitionDAO.exPagingList(cri);
	}//getExPagingList
	
	
	@Override
	public List<FullCalendarDTO> getVisitPartList(List<ExhibitionVO> exList) {//부분만추출
		log.debug("getVisitPartList() invoked");
		
		//캘린더 객체 얻기
		Calendar cal = Calendar.getInstance();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		String url = "get?exno=";
		List<FullCalendarDTO> reExList = new ArrayList<>();
		
		exList.forEach(t -> {
			FullCalendarDTO dto = new FullCalendarDTO();
			
			dto.setUrl(url+t.getExno().toString());
			dto.setTitle(t.getExname());
			dto.setStart(sdf.format(t.getExstart()));
			
			//일정캘린더용으로 쓰려면 하루를 더해야한다!
			cal.setTime(t.getExend());//날짜를 넣어줌
			cal.add(Calendar.DATE,+1);//넣은 날짜 +1
			dto.setEnd(sdf.format(cal.getTime()));
			
			log.info("\t + 객체정보 :" +t);
			reExList.add(dto);
		});

		return reExList;
	}//getVisitPartList


	@Override
	public ExhibitionVO getSchedule(Integer exno) throws Exception {
		log.debug("getSchedule() invoked");
		
		return this.exhibitionDAO.schedule(exno);
	}//getSchedule


	@Override
	public void register(ExhibitionDTO exDTO) throws Exception {
		log.debug("register() invoked");
		
		this.exhibitionDAO.insert(exDTO);
	}//register


	@Override
	public void modify(ExhibitionDTO exDTO) throws Exception {
		log.debug("modify() invoked");
		
		this.exhibitionDAO.update(exDTO);
	}//modify


	@Override
	public void remove(List<Integer> exnoList) throws Exception {
		log.debug("remove() invoked");
		
		this.exhibitionDAO.delete(exnoList);
	}//remove


	@Override
	public Integer getTotalCount(Criteria cri) throws Exception {
		log.debug("getTotalCount() invoked");
		
		return this.exhibitionDAO.totalCount(cri);
	}//getTotalCount


	@Override
	public List<ExhibitionVO> getEx() throws Exception {
		log.debug("getEx() invoked");
		
		return this.exhibitionDAO.searchEx();
	}//getEx
	
	
	//--------------------- danny --------------------//
	@Setter(onMethod_= {@Autowired})
	private ExhibitionMapper mapper;

	@Override
	public ExhibitionVO get(Integer exno) {
		log.debug("get(exno) invoked.");
		log.info("\t+ exno: " + exno);
		
		Objects.requireNonNull(this.mapper);

		return this.mapper.get(exno);
	}

	@Override
	public List<ExhibitionVO> getList() {
		log.debug("getList() invoked.");
		
		Objects.requireNonNull(this.mapper);
		
		return this.mapper.getList();
	}//get()


}//end class
