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
import com.skilldistillery.organmatcher.entities.TransplantRequest;
import com.skilldistillery.organmatcher.entities.TransplantType;
import com.skilldistillery.organmatcher.services.PatientService;
import com.skilldistillery.organmatcher.services.TransplantTypeService;

@CrossOrigin({ "*", "http://localhost:4210" })
@RequestMapping("api")
@RestController
public class TransplantTypeController {

	@Autowired
	private TransplantTypeService tts;

	@Autowired
	private PatientService pSvc;

	@GetMapping("/transtype")
	public List<TransplantType> index() {
		return tts.index();

	}

	@GetMapping("/transtype/{id}")
	private TransplantType show(@PathVariable int id, HttpServletRequest req, HttpServletResponse res) {

		TransplantType transplantType = tts.show(id);
		if (transplantType == null) {
			res.setStatus(404);
		}
		return transplantType;
	}

	@PostMapping("/transtype")
	// public TransplantType createNewTransplantType(@RequestBody TransplantType
	// transplantType, HttpServletResponse response,
//			HttpServletRequest request, Principal principal) {
	public TransplantType createNewTransplantType(@RequestBody TransplantType transplantType,
			HttpServletResponse response, HttpServletRequest request) {
//		transplantType = tts.create(principal.getOrgan(), transplantType);
		transplantType = tts.create(transplantType);

//		if (transplantType == null) {
//			response.setStatus(404);
//		} else {
//			response.setStatus(201);
//			StringBuffer url = request.getRequestURL();
//			url.append("/").append(transplantType.getId());
//			response.setHeader("Location", url.toString());
//
//		}
		return transplantType;
	}

	@PostMapping("/donor/{patientId}/transtype/{transplantId}")
	public Patient addDonorRoleToPatient(@PathVariable int patientId, @PathVariable int transplantId,
			HttpServletResponse response) {
		if (tts.addingDonorRole(patientId, transplantId)) {
			return pSvc.patientById(patientId);
		}
		return null;

	}

	@DeleteMapping("/donor/{patientId}/transtype/{transplantId}")
	public Patient deleteDonorRoleOfPatient(@PathVariable int patientId, @PathVariable int transplantId,
			HttpServletResponse response) {
		try {
			if (tts.deleteDonorRole(patientId, transplantId)) {
				response.setStatus(204);
				return pSvc.patientById(patientId);
			} else {
				response.setStatus(404);
				return null;
			}
		} catch (Exception e) {
			// TODO: handle exception
			response.setStatus(400);
		}

		return null;
	}

	@PutMapping("/transtype/{id}")
	public TransplantType updateTransplantType(@RequestBody TransplantType transplantType, @PathVariable int id,
			HttpServletResponse response) {
		// @PutMapping("transplant/{id}")
		// public TransplantRequest updateTransplantRequest(@RequestBody TransplantType
		// transplantType, @PathVariable int id, HttpServletResponse response, Principal
		// principal) {
//			transplantType = tts.update(principal.getOrgan(), id, transplantType);
		transplantType = tts.update(transplantType, id);

		try {
			if (transplantType == null) {

				response.setStatus(404);
			}
		} catch (Exception e) {
			// TODO: handle exception
			response.setStatus(400);
			transplantType = null;
		}
		return transplantType;
	}

	@DeleteMapping("/transtype/{id}")
	public void delete(@PathVariable Integer id, HttpServletResponse response) {
		try {

			boolean deleted = tts.destroy(id);
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
