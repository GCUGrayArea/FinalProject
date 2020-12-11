package com.skilldistillery.organmatcher.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.organmatcher.entities.Patient;
import com.skilldistillery.organmatcher.entities.TransplantType;
import com.skilldistillery.organmatcher.repositories.PatientRepository;
import com.skilldistillery.organmatcher.repositories.TransplantTypeRepository;

@Service
public class TransplantTypeServiceImpl implements TransplantTypeService {

	@Autowired
	private TransplantTypeRepository ttRepo;
	
	@Autowired
	private PatientRepository patientRepo;
	
	@Override
	public List<TransplantType> index() {
		return ttRepo.findAll();
	}

	@Override
	public TransplantType create(TransplantType transplantType) {
		ttRepo.saveAndFlush(transplantType);
		return transplantType;
	}

	@Override
	public TransplantType update(TransplantType transplantType, int id) {
		Optional<TransplantType> tTypeOpt = ttRepo.findById(id);
		if (tTypeOpt != null) {
			TransplantType transplantTypeToUpdate = tTypeOpt.get();
			if(transplantType.getId() != 0) {transplantTypeToUpdate.setId(transplantType.getId());}
			if(transplantType.getOrgan() != null ) {transplantTypeToUpdate.setOrgan(transplantType.getOrgan());}
			ttRepo.saveAndFlush(transplantTypeToUpdate);
			return transplantTypeToUpdate;
		}
		return null;
	}

	@Override
	public boolean destroy(int id) {
		boolean deleted =false;
		Optional<TransplantType> transplantTypeOpt =ttRepo.findById(id);
		if(transplantTypeOpt != null) {
			TransplantType transplantType = transplantTypeOpt.get();
			ttRepo.delete(transplantType);
		 deleted= true;
		}
		return deleted;
	}

	@Override
	public TransplantType show(int id) {
		
		Optional<TransplantType> transplantTypeOpt= ttRepo.findById(id);
		TransplantType transplantType = null;
		if(transplantTypeOpt.get() != null) {
			transplantType =transplantTypeOpt.get();
		}
		return transplantType;
	}
	
	@Override 
	public boolean addingDonorRole(int pid, int tid) {
//		return ttRepo.addDonorRole(pid, tid);
		Optional<Patient> donorOpt = patientRepo.findById( pid );
		Patient donor;
		Optional<TransplantType> roleOpt = ttRepo.findById( tid );
		TransplantType role;
		if ( donorOpt.isPresent() && roleOpt.isPresent() ) {
			donor = donorOpt.get();
			role = roleOpt.get();
			role.addDonor(donor);
			donor.addTransplantType(role);
			ttRepo.saveAndFlush(role);
			return true;
		} else {
			return false;
		}
		
	}
	

	@Override 
	public boolean deleteDonorRole(int pid, int tid) {
//		return ttRepo.removeDonorRole(pid, tid);
//		return deleteDonor;
		Optional<Patient> donorOpt = patientRepo.findById( pid );
		Patient donor;
		Optional<TransplantType> roleOpt = ttRepo.findById( tid );
		TransplantType role;
		if ( donorOpt.isPresent() && roleOpt.isPresent() ) {
			donor = donorOpt.get();
			role = roleOpt.get();
			role.removeDonor(donor);
			donor.removeTransplantType(role);
			ttRepo.saveAndFlush(role);
			return true;
		} else {
			return false;
		}
	}
	
}
