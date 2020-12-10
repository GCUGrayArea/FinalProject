package com.skilldistillery.organmatcher.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.organmatcher.entities.Hla;
import com.skilldistillery.organmatcher.entities.Patient;
import com.skilldistillery.organmatcher.repositories.HlaRepository;
import com.skilldistillery.organmatcher.repositories.PatientRepository;

@Service
public class HlaServiceImpl implements HlaService {

	@Autowired
	private HlaRepository hlaRepo;
	
	@Autowired
	private PatientRepository patientRepo;

	// LIST ALL
	@Override
	public List<Hla> listAll() {
		// TODO Auto-generated method stub
		return hlaRepo.findAll();
	}

	// SHOW
	@Override
	public Hla show(int id) {

		Optional<Hla> hlaOpt = hlaRepo.findById(id);
		Hla hla = null;
		if (hlaOpt.get() != null) {
			hla = hlaOpt.get();
		}
		return hla;
	}

	//CREATE
	@Override
	public Hla create( Hla hla, int patientId ) {
		Optional<Patient> patientOpt = patientRepo.findById( patientId );
		if ( patientOpt.isPresent() ) {
			hla.setPatient( patientOpt.get() );
			hlaRepo.saveAndFlush(hla);
			return hla;			
		} else {
			return null;
		}
	}
	
	@Override
	public List<Hla> createList(List<Hla> hlaList, int patientId ) {
		Optional<Patient> patientOpt = patientRepo.findById( patientId );
		if ( patientOpt.isPresent() ) {			
			for (Hla hla : hlaList) {
				hla = this.create( hla, patientId );
			}
			return hlaList;
		} else {
			return null;
		}
	}

	// UPDATE

	@Override
	public Hla update(Hla hla, int id) {
		// TODO Auto-generated method stub
		Optional<Hla> hRequestOpt = hlaRepo.findById(id);
		if (hRequestOpt != null) {
			Hla hlaToUpdate = hRequestOpt.get();
			if (hla.getId() != 0) {
				hlaToUpdate.setId(hla.getId());
			}
			if (hla.getProteinClass() != null) {
				hlaToUpdate.setProteinClass(hla.getProteinClass());
			}
			if (hla.getAllele() != 0) {
				hlaToUpdate.setAllele(hla.getAllele());
			}
			if (hla.getPatient() != null) {
				hlaToUpdate.setPatient(hla.getPatient());
			}
			hlaRepo.saveAndFlush(hlaToUpdate);
			return hlaToUpdate;
		}
		return null;
	}

	// DELETE
	@Override
	public boolean destroy(int id) {
		boolean deleted = false;
		Optional<Hla> hlaOpt = hlaRepo.findById(id);
		if (hlaOpt != null) {
			Hla hla = hlaOpt.get();
			hlaRepo.delete(hla);
			deleted = true;
		}
		return deleted;
	}
}
