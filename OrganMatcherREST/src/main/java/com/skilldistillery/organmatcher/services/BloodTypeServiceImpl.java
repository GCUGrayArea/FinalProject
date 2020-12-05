package com.skilldistillery.organmatcher.services;

import org.springframework.beans.factory.annotation.Autowired;

import com.skilldistillery.organmatcher.repositories.BloodTypeRepository;

public class BloodTypeServiceImpl implements BloodTypeService {

	@Autowired
	private BloodTypeRepository bRepo;
	
	//LIST ALL
//	@Override
//	public Set<BloodType> list() {
//		// TODO Auto-generated method stub
//		return bRepo.findAll();
//	}
	
	//SHOW
//	@Override
//	public BloodType show() {
//		return bRepo.findById(id);
//		
//	}

	//CREATE
//	@Override
//	public BloodType create(BloodType bloodType) {
//		brepo.saveAndFlush(bloodType);
//		return bloodType;
//	}

	
	//UPDATE
//	@Override
//	public BloodType update(BloodType bloodType, int id) {
//		// TODO Auto-generated method stub
//		BloodType bloodTypeToUpdate = bRepo.findById(id);
//		if (bloodTypeToUpdate != null) {
//			bloodTypeToUpdate.setTask(todo.getTask());
//			if(bloodType.getID() != null) {bloodTypeToUpdate.setID(bloodType.getID());}
//			if(bloodType.getBloodGroup() != null ) {bloodTypeToUpdate.setBloodGroup(bloodType.getBloodGroup());}
//			if(bloodType.getRh() !=null) {bloodTypeToUpdate.setRh(bloodType.getRh());}
//			if(bloodType.getPatients() != null) {bloodTypeToUpdate.setPatients(bloodType.getPatients());}
//			bRepo.saveAndFlush(bloodTypeToUpdate);
//		}
//		return bloodTypeToUpdate;
//	}
	
	//DELETE
//	@Override
//	public boolean destroy() {
//		boolean deleted =false;
//		BloodType bloodType =bRepo.findById(id);
//		if(bloodType != null) {
//			bRepo.delete(bloodType);
//		 deleted= true;
//		}
//	 return deleted;
//	}
}
