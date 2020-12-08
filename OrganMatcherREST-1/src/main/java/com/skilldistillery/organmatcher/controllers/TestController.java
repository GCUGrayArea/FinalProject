package com.skilldistillery.organmatcher.controllers;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
@CrossOrigin({ "*", "http://localhost:4210" })
@RequestMapping( "api" )
@RestController
public class TestController {
	
	@GetMapping("hello")
	public String ping() {
		return "pong";
	}

}
