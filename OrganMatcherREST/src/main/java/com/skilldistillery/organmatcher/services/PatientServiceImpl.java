package com.skilldistillery.organmatcher.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.organmatcher.entities.Patient;
import com.skilldistillery.organmatcher.repositories.PatientRepository;

@Service
public class PatientServiceImpl implements PatientService {
	
	@Autowired
	private PatientRepository repo;
	
	@Override
	public List<Patient> index() {
		return repo.findAll();
	}

	@Override
	public Patient patientById(int id) {
		Optional<Patient> patientOpt = repo.findById(id);
		return patientOpt.isPresent() ? patientOpt.get() : null;
	}
	
	@Override
	public List<Patient> patientsByBloodTypeId( int id ) {
		return repo.findByBloodTypeId( id );
	}

//	@Override
//	public List<Patient> patientsByBloodAndTransplantType(int bloodId, int transplantId) {
//		return repo.findByBloodTypeAndOrganType(bloodId, transplantId );
//	}

	
	
	
	

}
