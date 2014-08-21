package sub.controller;

import java.util.List;

import javax.annotation.Resource;

import model.domain.MeetingBean;
import model.domain.ScheduleBean;
import model.service.MeetingService;
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
	
	
	@Resource(name="meetingService")
	private MeetingService meetingService;
	
	@RequestMapping(value="checkUpdate.do", method=RequestMethod.POST)
	@ResponseBody
	public String checkUpdate(@RequestParam("snum") int snum, @RequestParam("stext") String stext,
			@RequestParam("stitle") String stitle, @RequestParam("sdate") String sdate, @RequestParam("edate") String edate){
		ScheduleBean scheBean= new ScheduleBean(0,snum,sdate, edate, stext, stitle);
		if(scheduleService.checkUpdate(scheBean)==0){
			return "ok";
		}
		return "no";
	}
	
	@RequestMapping(value="deleteSchedule.do", method=RequestMethod.POST)
	@ResponseBody
	public String deleteSchedule(@RequestParam("snum") int snum){
		if(scheduleService.deleteSchedule(snum)==0){
			return "no";
		}
		return "ok";
	}
	
	@RequestMapping(value="sendSchedule.do", method=RequestMethod.POST)
	@ResponseBody
	public String sendSchedule(@RequestParam("pnum") int pnum, @RequestParam("sdate") String sdate, @RequestParam("edate") String edate, @RequestParam("stext") String stext,
			@RequestParam("stitle") String stitle, @RequestParam("flag") boolean sflag){
		if(sflag){  // true => 스케줄 등록
			ScheduleBean scheBean = new ScheduleBean(pnum,0,sdate,edate,stext,stitle);
			System.out.println(scheBean.getPnum()+" : "+ scheBean.getStext());
			System.out.println("sendSchedule.do controller");
			
			if(scheduleService.sendSchedule(scheBean)==0){
				return "no";
			}
			return "ok";
			
		}
		else{	// 미팅 등록
			MeetingBean meetingBean = new MeetingBean(0,pnum,sdate,stext, null,stitle);
			if(meetingService.sendMeeting(meetingBean)==0){
				return "no";
			}
			return "ok";
		}
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







