package sub.controller;

import java.util.List;

import javax.annotation.Resource;

import model.domain.ScheduleBean;
import model.service.ScheduleService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ScheduleController {
	@Resource(name="scheduleService")
	private ScheduleService scheduleService;
	
	@RequestMapping(value="sendSchedule.do", method=RequestMethod.POST)
	@ResponseBody
	public String sendSchedule(@RequestParam("pnum") int pnum, @RequestParam("sdate") String sdate, @RequestParam("edate") String edate, @RequestParam("stext") String stext,
			@RequestParam("stitle") String stitle){
		ScheduleBean scheBean = new ScheduleBean(pnum,0,sdate,edate,stext,stitle);
		System.out.println(scheBean.getPnum()+" : "+ scheBean.getStext());
		System.out.println("sendSchedule.do controller");
		
		if(scheduleService.sendSchedule(scheBean)==0){
			return "no";
		}
		return "ok";
	}
	
	@RequestMapping(value="getSchedule.do", method=RequestMethod.POST)
	public ModelAndView select(String pnum){
		System.out.println(pnum+"//////");
		System.out.println("getschedule.do controller");
		List<ScheduleBean> list = scheduleService.getProjectList(pnum);
		System.out.println(list.toString()+"/////");
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("list",list);
		mv.setViewName("scheduleJsonView");
		return mv;
	}

}







