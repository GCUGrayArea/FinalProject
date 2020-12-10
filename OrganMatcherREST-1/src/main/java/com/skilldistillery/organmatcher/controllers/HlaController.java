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

import com.skilldistillery.organmatcher.entities.Hla;
import com.skilldistillery.organmatcher.services.HlaService;

@RestController
@CrossOrigin({ "*" , "http://localhost:4210" })
@RequestMapping("api")
public class HlaController {
	
	@Autowired
	private HlaService hlaSvc;
	
	
@GetMapping("/hla")
public List<Hla> show(){
	return hlaSvc.listAll();
	
}


@GetMapping("/hla/{id}")
public Hla findSingleHla(@PathVariable Integer id){
	return hlaSvc.show(id);
}


@PostMapping("patients/{patientId}/hla")
//public Hla createNewHla(@RequestBody Hla hla, HttpServletResponse response,
//		HttpServletRequest request, Principal principal) {
public Hla createNewHla( @PathVariable int patientId, @RequestBody Hla hla, HttpServletResponse response,
		HttpServletRequest request) {
//	hla = hlaSvc.create(principal.getName(), hla);
	hla = hlaSvc.create( hla , patientId );

	if (hla == null) {
		response.setStatus(404);
	} else {
		response.setStatus(201);
		StringBuffer url = request.getRequestURL();
		url.append("/").append(hla.getId());
		response.setHeader("Location", url.toString());

	}
	return hla;
}

@PostMapping("patients/{patientId}/hla/all")
public List<Hla> createNewHla( @PathVariable int patientId , @RequestBody List<Hla> hlaList , HttpServletResponse res ) {
	
	hlaList = hlaSvc.createList( hlaList , patientId );
	
	if (hlaList == null) {
		res.setStatus(404);
	} else {
		res.setStatus(201);
	}
	
	return hlaList;
}

@PutMapping("/hla/{id}")
public Hla updateHla(@RequestBody Hla hla, @PathVariable int id, HttpServletResponse response) {
//@PutMapping("tr/{id}")
//public Hla updateHla(@RequestBody Hla hla, @PathVariable int id, HttpServletResponse response, Principal principal) {
//	hla = hlaSvc.update(principal.getName(), id, hla);
	hla = hlaSvc.update(hla, id);

	try {
		if (hla == null) {

			response.setStatus(404);
		}
	} catch (Exception e) {
		// TODO: handle exception
		response.setStatus(400);
		hla = null;
	}
	return hla;
}

//@DeleteMapping("/hla/{id}")
//public void deleteTodo(@PathVariable Integer id, HttpServletResponse response, Principal principal) {
	
@DeleteMapping("/hla/{id}")
public void deleteHla(@PathVariable Integer id, HttpServletResponse response) {
	try {

		boolean deleted = hlaSvc.destroy(id);
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

	
