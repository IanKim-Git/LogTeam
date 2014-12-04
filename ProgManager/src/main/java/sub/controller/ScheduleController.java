package sub.controller;

import java.util.Date;
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
	@RequestMapping(value="deleteMeeting.do", method=RequestMethod.POST)
	@ResponseBody
	public String deleteMeeting(@RequestParam("mnum") int mnum){
		if(meetingService.deleteMeeting(mnum)==0){
			return "no";
		}
		return "ok";
	}

	
	@RequestMapping(value="sendSchedule.do", method=RequestMethod.POST)
	@ResponseBody
	public String sendSchedule(@RequestParam("pnum") int pnum, @RequestParam("number") int number, @RequestParam("sdate") String sdate, @RequestParam("edate") String edate, @RequestParam("stext") String stext,
			@RequestParam("stitle") String stitle, @RequestParam("flag") String sflag, @RequestParam("lati") String lati, @RequestParam("longi") String longi){
		if(sflag.equals("schedule")){  // true => 스케줄 등록
			ScheduleBean scheBean = new ScheduleBean(pnum,number,sdate,edate,stext,stitle);
			if(number!=0){
			scheduleService.checkUpdate(scheBean);
			}
			if(scheduleService.sendSchedule(scheBean)==0){
				return "no";
			}
			return "ok";
		}
		else{	// 미팅 등록
			MeetingBean meetingBean = new MeetingBean(number,pnum,sdate,stext, lati,longi,stitle, new Date());
			if(number!=0){
				meetingService.checkUpdate(meetingBean);
			}
			if(meetingService.sendMeeting(meetingBean)==0){
				return "no";
			}
			return "ok";
		}
	}
	
	@RequestMapping(value="getSchedule.do", method=RequestMethod.POST)
	public ModelAndView selectSchedule(String pnum){
		List<ScheduleBean> list = scheduleService.getProjectList(pnum);
		ModelAndView mv = new ModelAndView();
		mv.addObject("list",list);
		mv.setViewName("scheduleJsonView");
		return mv;
	}
	@RequestMapping(value="getMeeting.do", method=RequestMethod.POST)
	public ModelAndView selectMeeting(String pnum){
		List<MeetingBean> list = meetingService.getProjectList(pnum);
		ModelAndView mv = new ModelAndView();
		mv.addObject("list",list);
		mv.setViewName("meetingJsonView");
		return mv;
	}
	@RequestMapping(value="updateSchedule.do", method=RequestMethod.POST)
	@ResponseBody
	public String updateSchedule(@RequestParam("pnum") int pnum, @RequestParam("number") int number, @RequestParam("sdate") String sdate, @RequestParam("edate") String edate, @RequestParam("stext") String stext,
			@RequestParam("stitle") String stitle, @RequestParam("flag") String sflag, @RequestParam("lati") String lati, @RequestParam("longi") String longi ){
		if(sflag.equals("schedule")){
			ScheduleBean scheBean = new ScheduleBean(pnum, number, sdate, edate, stext, stitle);
			if(scheduleService.updateSchedule(scheBean)==0){
				return "no";
			}
			return "ok";
		}else
		{
			MeetingBean meetingBean = new MeetingBean(number, pnum, sdate, stext, lati, longi, stitle, new Date());
			if(meetingService.updateMeeting(meetingBean)==0){
				return "no";
			}
			return "ok";
		}
	}
}