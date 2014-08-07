package sub.controller;

import javax.annotation.Resource;

import model.domain.ProgUserBean;
import model.service.ProgUserService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ProgUserController {
	@Resource(name="puService")
	private ProgUserService puService;
	
	@RequestMapping(value="idPwCheck.do", method=RequestMethod.POST)
	public String idPwCheck(@RequestParam("email") String uemail, @RequestParam("pw") String upw, Model model){
		model.addAttribute("email", uemail);
		model.addAttribute("pw", upw);	
		System.out.println(uemail);
		System.out.println(upw);
		ProgUserBean pu = puService.userCheck(uemail, upw);
		System.out.println(pu);
		if(pu != null){
			model.addAttribute("name", pu.getUname());
			model.addAttribute("phone", pu.getUphone());
			return "successView";
		}
		return "failView";
	}
}
