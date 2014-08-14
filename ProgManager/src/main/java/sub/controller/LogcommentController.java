package sub.controller;

import javax.annotation.Resource;

import model.service.LogcommentService;

import org.springframework.stereotype.Controller;

@Controller
public class LogcommentController {
	@Resource(name="lcService")
	private LogcommentService lcService;
}
