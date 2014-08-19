package sub.controller;

import java.util.List;

import javax.annotation.Resource;

import model.domain.ProgUserBean;
import model.domain.ProjectBean;
import model.service.LogService;
import model.service.LogcommentService;
import model.service.ProgUserService;
import model.service.ProjectService;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ProjectInfoController {
	@Resource(name = "projectService")
	private ProjectService projectService;

	@Resource(name = "puService")
	private ProgUserService puService;

	@Resource(name = "lcService")
	private LogcommentService lcService;

	@Resource(name = "logService")
	private LogService logService;

	// 프로젝트 정보 변경
	@RequestMapping(value = "proUpdate.do", method = RequestMethod.POST)
	@ResponseBody
	public String updateUser(@RequestParam("pname") String pname,
			@RequestParam("ppw") String ppw,
			@RequestParam("pstart") String pstart,
			@RequestParam("pend") String pend,
			@RequestParam("pnum") String pnum, Model model) {
		String resultMsg = "signInFail";// 저장 실패시 응답되는 데이터
		int result = projectService.projectUpdateInfo(new ProjectBean(pname,
				ppw, pstart, pend, Integer.parseInt(pnum)));
		if (result > 0) {
			model.addAttribute("pname", pname);
			model.addAttribute("ppw", ppw);
			model.addAttribute("pstart", pstart);
			model.addAttribute("pend", pend);
			model.addAttribute("pend", pnum);
			resultMsg = "ok";// 정상 저장시 응답되는 데이터
		}
		return resultMsg;
	}

	// 프로젝트 삭제
	@RequestMapping(value = "deleteProject.do", method = RequestMethod.POST)
	public String deleteUser(@RequestParam("pnum") String pnum, Model model) {
		String resultMsg = "signInFail";// 저장 실패시 응답되는 데이터
		int result = projectService.projectDelete(Integer.parseInt(pnum));

		if (result > 0) {
			model.addAttribute("email2", pnum);
			// resultMsg = "ok";// 정상 저장시 응답되는 데이터
			return "successView";
		}
		return "failView";
	}
	
	// 버튼 비활성화 로직
		@RequestMapping(value = "getProjectLeader.do", method = RequestMethod.POST)
		@ResponseBody
		public String idPwCheck(@RequestParam("pnum") String pnum, Model model) {
			String pleader = null;
			
			model.addAttribute("pnum", pnum);
			
			//ProgUserBean pu = puService.userCheck(uemail, upw);
			pleader = projectService.getProjectLeader(Integer.parseInt(pnum));
			if (pleader != null) {
				model.addAttribute("pleader", pleader);
				return "ok";
			}
			return "signInFail";
		}
}
