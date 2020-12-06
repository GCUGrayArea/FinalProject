package com.skilldistillery.organmatcher.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.organmatcher.entities.TransplantRequest;
import com.skilldistillery.organmatcher.repositories.TransplantRequestRepository;
import com.skilldistillery.organmatcher.services.TransplantRequestService;

@CrossOrigin({ "*", "http://localhost:4210" })
@RequestMapping( "api" )
@RestController
public class TransplantRequestController {
	@Autowired
	private TransplantRequestService trs;
	
@GetMapping("/transplant")
public List<TransplantRequest> index(){
	return trs.index();
	
}
@GetMapping("/transplant/organ")
public List<TransplantRequest> findUnmatched(){
	return null;
	
}
}
