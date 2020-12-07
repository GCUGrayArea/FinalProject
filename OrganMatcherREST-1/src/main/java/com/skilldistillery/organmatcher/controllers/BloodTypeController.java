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

import com.skilldistillery.organmatcher.entities.BloodType ;
import com.skilldistillery.organmatcher.services.BloodTypeService;

@RestController
@CrossOrigin({ "*" , "http://localhost:4210" })
@RequestMapping("api")
public class BloodTypeController {
	
	@Autowired
	private BloodTypeService bSvc;
	
	
@GetMapping("/bloodType")
public List<BloodType > index(){
	return  bSvc.listAll();
	
}

@GetMapping("/bloodType/{id}")
public BloodType  findSingleBloodType (@PathVariable Integer id){
	return  bSvc.show(id);
}

@PostMapping("/bloodType")
//public BloodType  createNewBloodType (@ Body BloodType  bloodType , HttpServletResponse response,
//		HttpServlet  request, Principal principal) {
public BloodType  createNewBloodType (@RequestBody BloodType  bloodType , HttpServletResponse response,
		HttpServletRequest  request) {
//	bloodType  =  bSvc.create(principal.getName(), bloodType );
	bloodType  =  bSvc.create(bloodType );

	if (bloodType  == null) {
		response.setStatus(404);
	} else {
		response.setStatus(201);
		StringBuffer url = request.getRequestURL();
		url.append("/").append(bloodType .getId());
		response.setHeader("Location", url.toString());

	}
	return bloodType ;
}

@PutMapping("/bloodType/{id}")
public BloodType updateBloodType (@RequestBody BloodType  bloodType , @PathVariable int id, HttpServletResponse response) {
//@PutMapping("tr/{id}")
//public BloodType  updateBloodType (@ Body BloodType  bloodType , @PathVariable int id, HttpServletResponse response, Principal principal) {
//	bloodType  =  bSvc.update(principal.getName(), id, bloodType );
	bloodType  =  bSvc.update(bloodType, id);

	try {
		if (bloodType  == null) {

			response.setStatus(404);
		}
	} catch (Exception e) {
		// TODO: handle exception
		response.setStatus(400);
		bloodType  = null;
	}
	return bloodType ;
}

//@DeleteMapping("/bloodType/{id}")
//public void deleteTodo(@PathVariable Integer id, HttpServletResponse response, Principal principal) {
	
@DeleteMapping("/bloodType/{id}")
public void deleteTodo(@PathVariable Integer id, HttpServletResponse response) {
	try {

		boolean deleted =  bSvc.destroy(id);
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
