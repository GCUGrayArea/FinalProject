package com.skilldistillery.organmatcher.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.organmatcher.entities.Patient;
import com.skilldistillery.organmatcher.entities.Patient;
import com.skilldistillery.organmatcher.entities.Patient;
import com.skilldistillery.organmatcher.entities.TransplantType;
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
//	public List<Patient> patientsByBloodAndTransplantType(int bloodId, String organ) {
//		return repo.findByBloodTypeAndOrganType(bloodId, organ);
//	}

	@Override
	public List<Patient> patientsByBloodAndTransplantType( int bloodId , String organ ) {
//		List<Patient> listToFilter = repo.findByBloodTypeId(bloodId);
//		List<Patient> resultList = new ArrayList<Patient>();
//		for ( Patient p : listToFilter ) {
//			for ( TransplantType t : p.getTransplantTypes() ) {
//				if ( t.getOrgan().equalsIgnoreCase( organ ) ) {
//					resultList.add(p);
//					break;
//				}
//			}
//		}
//		
//		return resultList;
		
		return repo.findByBloodTypeIdAndTransplantTypes_Organ(bloodId, organ);
		
	}
	

	@Override
	public Patient create(Patient patient) {
		repo.saveAndFlush(patient);
		return patient;
	}
	
	@Override
	public Patient update(Patient patient, int id) {
		// TODO Auto-generated method stub
		Optional<Patient> patientOpt = repo.findById(id);
		if (patientOpt != null) {
			Patient patientToUpdate = patientOpt.get();
			if(patient.getId() != 0) {patientToUpdate.setId(patient.getId());}
			if(patient.getFirstName() != null ) {patientToUpdate.setFirstName(patient.getFirstName());}
			if(patient.getLastName() != null ) {patientToUpdate.setLastName(patient.getLastName());}
			if(patient.getBirthDate() != null ) {patientToUpdate.setBirthDate(patient.getBirthDate());}
			if(patient.getSex() != null ) {patientToUpdate.setSex(patient.getSex());}
			if(patient.getWeightKg() != 0 ) {patientToUpdate.setWeightKg(patient.getWeightKg());}
			if(patient.getBloodType() !=null) {patientToUpdate.setBloodType(patient.getBloodType());}
			if(patient.getAddress() != null) {patientToUpdate.setAddress(patient.getAddress());}
//			if(patient.getTransplantTypes() != null) {patientToUpdate.setTransplantTypes(patient.getTransplantTypes());}
//			if(patient.getHla() != null) {patientToUpdate.setHla(patient.getHla());}
			repo.saveAndFlush(patientToUpdate);
			return patientToUpdate;
		}
		return null;
	}
	

	@Override
	public boolean destroy(int id) {
		boolean deleted =false;
		Optional<Patient> patientOpt =repo.findById(id);
		if(patientOpt != null) {
			Patient patient = patientOpt.get();
			repo.delete(patient);
		 deleted= true;
		}
	 return deleted;
	}

	
	
	
	

}
