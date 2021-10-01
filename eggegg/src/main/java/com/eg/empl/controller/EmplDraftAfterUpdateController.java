package com.eg.empl.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eg.empl.service.EmplService;
import com.eg.gnfd.dao.GnfdDAO;
import com.eg.vo.OfficialOrderVO;

@EnableScheduling
@Controller
public class EmplDraftAfterUpdateController {

	@Inject
	private GnfdDAO gnfdDao;
	@Inject
	private EmplService emplService;
	
	@RequestMapping(value="/empl/emplDraftAfter.do")
	@Scheduled(cron="0 0 0 * * *")
	public void emplDraftAfter() throws Exception {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		
		Date today = new Date();
		System.out.println(today);
		
		List<OfficialOrderVO> gnfdList = gnfdDao.selectGnfdDraftAfter();
		OfficialOrderVO gnfd = new OfficialOrderVO();
		for(int i = 0; i < gnfdList.size(); i++) {
			gnfd = gnfdList.get(i);
			Date gnfdDe = format.parse(gnfd.getGnfdDe());
			if(gnfdDe.equals(today) || gnfd.getDraft().getDraftProgress().equals("결재완료")) {
				emplService.modifyEmplDraftAfter(gnfd);
			} else if(gnfdDe.before(today)) {
				int draftNo = gnfd.getDraftNo();
				emplService.modifyEmplDraftReturn(draftNo);
			}
			
		}
	}
	
}
