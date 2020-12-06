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

import com.skilldistillery.organmatcher.entities.Patient;
import com.skilldistillery.organmatcher.entities.Patient;
import com.skilldistillery.organmatcher.entities.Patient;
import com.skilldistillery.organmatcher.services.PatientService;

@RestController
@CrossOrigin({ "*" , "http://localhost:4210" })
@RequestMapping("api")
public class PatientController {
	
	@Autowired
	private PatientService patientSvc;
	
	@GetMapping( "patients/all" )
	public List<Patient> allPatients() {
		return patientSvc.index();
	}
	
	@GetMapping("patients/{id}")
	public Patient patientById( @PathVariable int id, HttpServletResponse res ) {
		Patient patient = patientSvc.patientById( id );
		if ( patient == null ) {
			res.setStatus(404);
		}
		
		return patient;
	}
	
	@GetMapping( "patients/blood-type/{typeId}" )
	public List<Patient> patientsByBloodType( @PathVariable int typeId, HttpServletResponse res ) {
		List<Patient> resultList = patientSvc.patientsByBloodTypeId( typeId );
		if ( resultList.size() == 0 ) {
			res.setStatus(404);
		}
		return resultList;
	}
	
	@GetMapping( "patients/transplant-type/{organ}/blood-type/{bloodId}" )
	public List<Patient> patientsByBloodAndTransplantType( @PathVariable String organ , @PathVariable int bloodId, HttpServletResponse res ) {
		List<Patient> resultList = patientSvc.patientsByBloodAndTransplantType(bloodId, organ);
//		if ( resultList.size() == 0 ) {
//			res.setStatus(404);
//		}
		return resultList;
	}
	

	@PostMapping("/patients")
	//public Patient createNewPatient(@RequestBody Patient patient, HttpServletResponse response,
//			HttpServletRequest request, Principal principal) {
	public Patient createNewPatient(@RequestBody Patient patient, HttpServletResponse response,
			HttpServletRequest request) {
//		patient = trs.create(principal.getName(), patient);
		patient = patientSvc.create(patient);

		if (patient == null) {
			response.setStatus(404);
		} else {
			response.setStatus(201);
			StringBuffer url = request.getRequestURL();
			url.append("/").append(patient.getId());
			response.setHeader("Location", url.toString());

		}
		return patient;
	}
	
	@PutMapping("/patients/{id}")
	public Patient updatePatient(@RequestBody Patient patient, @PathVariable int id, HttpServletResponse response) {
	//@PutMapping("tr/{id}")
	//public Patient updatePatient(@RequestBody Patient patient, @PathVariable int id, HttpServletResponse response, Principal principal) {
//		patient = trs.update(principal.getName(), id, patient);
		patient = patientSvc.update(patient, id);

		try {
			if (patient == null) {

				response.setStatus(404);
			}
		} catch (Exception e) {
			// TODO: handle exception
			response.setStatus(400);
			patient = null;
		}
		return patient;
	}
	
	@DeleteMapping("/patients/{id}")
	public void deleteTodo(@PathVariable Integer id, HttpServletResponse response) {
		try {

			boolean deleted = patientSvc.destroy(id);
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
