package com.skilldistillery.organmatcher.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.organmatcher.entities.BloodType;
import com.skilldistillery.organmatcher.repositories.BloodTypeRepository;

@Service
public class BloodTypeServiceImpl implements BloodTypeService {

	@Autowired
	private BloodTypeRepository bRepo;
	
	//LIST ALL
	@Override
	public List <BloodType> listAll() {
		// TODO Auto-generated method stub
		return bRepo.findAll();
	}
	
	//SHOW
	@Override
	public BloodType show(int id) {

		Optional<BloodType> bloodTypeOpt= bRepo.findById(id);
		BloodType bloodType = null;
		if(bloodTypeOpt.get() != null) {
			bloodType =bloodTypeOpt.get();
		}
		return bloodType;
		}


	@Override
	public BloodType create(BloodType bloodType) {
		bRepo.saveAndFlush(bloodType);
		return bloodType;
	}

	
	//UPDATE

	@Override
	public BloodType update(BloodType bloodType, int id) {
		// TODO Auto-generated method stub
		Optional<BloodType> bRequestOpt = bRepo.findById(id);
		if (bRequestOpt != null) {
			BloodType bloodTypeToUpdate = bRequestOpt.get();
			if(bloodType.getId() != 0) {bloodTypeToUpdate.setId(bloodType.getId());}
			if(bloodType.getBloodGroup() != '\u0000') {bloodTypeToUpdate.setBloodGroup(bloodType.getBloodGroup());}
			if(!bloodType.isRh()) {bloodTypeToUpdate.setRh(bloodType.isRh());}
//			if(bloodType.getPatients() != null) {bloodTypeToUpdate.setPatients(bloodType.getPatients());}
			bRepo.saveAndFlush(bloodTypeToUpdate);			
			return bloodTypeToUpdate;
		}
		return null;
		}
	
	
	//DELETE

	@Override
	public boolean destroy(int id) {
		boolean deleted =false;
		Optional<BloodType> bloodTypeOpt =bRepo.findById(id);
		if(bloodTypeOpt != null) {
			BloodType bloodType = bloodTypeOpt.get();
			bRepo.delete(bloodType);
		 deleted= true;
		}
	 return deleted;
	}
}
