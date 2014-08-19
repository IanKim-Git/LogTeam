package sub.controller;

import java.util.List;

import javax.annotation.Resource;

import model.domain.ProjectBean;
import model.domain.ScheduleBean;
import model.service.ProgUserService;
import model.service.ProjectService;
import model.service.ScheduleService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ScheduleController {
	@Resource(name="scheduleService")
	private ScheduleService scheduleService;
	
	@RequestMapping(value="getSchedule.do", method=RequestMethod.POST)
	public ModelAndView select(String pnum){
		System.out.println(pnum+"//////");
		System.out.println("getschedule.do contorller");
		List<ScheduleBean> list = scheduleService.getProjectList(pnum);
		System.out.println(list.toString()+"/////");
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("list",list);
		mv.setViewName("scheduleJsonView");
		return mv;
	}

}







