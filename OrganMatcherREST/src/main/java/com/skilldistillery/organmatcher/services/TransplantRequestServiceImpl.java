package com.skilldistillery.organmatcher.services;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.organmatcher.entities.TransplantRequest;
import com.skilldistillery.organmatcher.repositories.TransplantRequestRepository;
@Service
public class TransplantRequestServiceImpl implements TransplantRequestService {

	@Autowired
	private TransplantRequestRepository trRepo;
	
	//LIST ALL
	@Override
	public List<TransplantRequest> index() {
		return trRepo.findAll();
	}

	@Override
	public List<TransplantRequest> findByUnmatched() {
		return trRepo.findByDonorIsNull();
	}

	@Override
	public List<TransplantRequest> findForOrgan(int id) {
		return trRepo.findByDonorIsNullAndOrganTypeId(id);
	}
	
	//SHOW
//	@Override
//	public TransplantRequestService show() {
//		return trRepo.findById(id);
//		
//	}

	//CREATE
//	@Override
//	public TransplantRequestService create(TransplantRequestService transplantRequestService) {
//		brepo.saveAndFlush(transplantRequestService);
//		return transplantRequestService;
//	}

	
	//UPDATE
//	@Override
//	public TransplantRequestService update(TransplantRequestService transplantRequestService, int id) {
//		// TODO Auto-generated method stub
//		TransplantRequestService transplantRequestServiceToUpdate = trRepo.findById(id);
//		if (transplantRequestServiceToUpdate != null) {
//			if(transplantRequestService.getID() != null) {transplantRequestServiceToUpdate.setID(transplantRequestService.getID());}
//			if(transplantRequestService.getPatient() != null ) {transplantRequestServiceToUpdate.setPatient(transplantRequestService.getPatient());}
//			if(transplantRequestService.getDonor() !=null) {transplantRequestServiceToUpdate.setDonor(transplantRequestService.getDonor());}
//			if(transplantRequestService.getOrganType() != null) {transplantRequestServiceToUpdate.setOrganType(transplantRequestService.getOrganType());}
//			if(transplantRequestService.getCreatedAt() != null) {transplantRequestServiceToUpdate.setCreatedAt(transplantRequestService.getCreatedAt());}
//			trRepo.saveAndFlush(transplantRequestServiceToUpdate);
//		}
//		return transplantRequestServiceToUpdate;
//	}
	
	//DELETE
//	@Override
//	public boolean destroy() {
//		boolean deleted =false;
//		TransplantRequestService transplantRequestService =trRepo.findById(id);
//		if(transplantRequestService != null) {
//			trRepo.delete(transplantRequestService);
//		 deleted= true;
//		}
//	 return deleted;
//	}
}

