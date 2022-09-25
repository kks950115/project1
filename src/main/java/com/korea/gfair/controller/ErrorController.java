package com.korea.gfair.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.NoArgsConstructor;

@NoArgsConstructor

@RequestMapping("/error")
@Controller
public class ErrorController {
	
	@RequestMapping
	public String defaultError() {
		return "error/pageError";
	}

}//end class
