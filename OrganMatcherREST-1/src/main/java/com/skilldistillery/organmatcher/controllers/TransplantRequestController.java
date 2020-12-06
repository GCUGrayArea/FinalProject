package com.skilldistillery.organmatcher.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.organmatcher.entities.TransplantRequest;
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
@GetMapping("/transplant/unmatched")
public List<TransplantRequest> findUnmatched(){
	return trs.findByUnmatched();
	
}

@GetMapping("/transplant/unapproved")
public List<TransplantRequest> findUnapproved(){
	return trs.findUnapprovedRequests();
	
}

@GetMapping("/transplant/{id}")
public TransplantRequest findSingleTransplantRequest(@PathVariable Integer id){
	return trs.show(id);
}

@PostMapping("/transplant")
//public TransplantRequest createNewTransplantRequest(@RequestBody TransplantRequest transplantRequest, HttpServletResponse response,
//		HttpServletRequest request, Principal principal) {
public TransplantRequest createNewTransplantRequest(@RequestBody TransplantRequest transplantRequest, HttpServletResponse response,
		HttpServletRequest request) {
//	transplantRequest = trs.create(principal.getName(), transplantRequest);
	transplantRequest = trs.create(transplantRequest);

	if (transplantRequest == null) {
		response.setStatus(404);
	} else {
		response.setStatus(201);
		StringBuffer url = request.getRequestURL();
		url.append("/").append(transplantRequest.getId());
		response.setHeader("Location", url.toString());

	}
	return transplantRequest;
}

@PutMapping("/transplant/{id}")
public TransplantRequest updateTransplantRequest(@RequestBody TransplantRequest transplantRequest, @PathVariable int id, HttpServletResponse response) {
//@PutMapping("tr/{id}")
//public TransplantRequest updateTransplantRequest(@RequestBody TransplantRequest transplantRequest, @PathVariable int id, HttpServletResponse response, Principal principal) {
//	transplantRequest = trs.update(principal.getName(), id, transplantRequest);
	transplantRequest = trs.update(transplantRequest, id);

	try {
		if (transplantRequest == null) {

			response.setStatus(404);
		}
	} catch (Exception e) {
		// TODO: handle exception
		response.setStatus(400);
		transplantRequest = null;
	}
	return transplantRequest;
}

//@DeleteMapping("/transplant/{id}")
//public void deleteTodo(@PathVariable Integer id, HttpServletResponse response, Principal principal) {
	
@DeleteMapping("/transplant/{id}")
public void deleteTodo(@PathVariable Integer id, HttpServletResponse response) {
	try {

		boolean deleted = trs.destroy(id);
		if (deleted) {
			response.setStatus(204);
		} else {
			response.setStatus(404);
		}
	} catch (Exception e) {
		// TODO: handle exception
		response.setStatus(400);
	}

}




}
