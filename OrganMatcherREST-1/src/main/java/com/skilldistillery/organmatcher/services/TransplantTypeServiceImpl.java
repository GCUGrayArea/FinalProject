package com.skilldistillery.organmatcher.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.organmatcher.entities.TransplantRequest;
import com.skilldistillery.organmatcher.entities.TransplantType;
import com.skilldistillery.organmatcher.repositories.TransplantTypeRepository;

@Service
public class TransplantTypeServiceImpl implements TransplantTypeService {

	@Autowired
	private TransplantTypeRepository ttRepo;
	
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

	
}
