package com.skilldistillery.organmatcher.services;

import java.util.List;

import java.util.Optional;
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
	

	@Override
	public List<TransplantRequest> findUnapprovedRequests() {
		return trRepo.findByDonorIsNotNullAndApprovalStatusIsNull();
	}
	
	@Override
	public List<TransplantRequest> findByApprovalStatus( String status ) {
		return trRepo.findByDonorIsNotNullAndApprovalStatus(status);
	}
	
	//SHOW
	@Override
	public TransplantRequest show(int id) {

		Optional<TransplantRequest> transplantRequestOpt= trRepo.findById(id);
		TransplantRequest transplantRequest = null;
		if(transplantRequestOpt.get() != null) {
			transplantRequest =transplantRequestOpt.get();
		}
		return transplantRequest;
		}
	

	@Override
	public TransplantRequest create(TransplantRequest transplantRequest) {
		trRepo.saveAndFlush(transplantRequest);
		return transplantRequest;
	}

	
	//UPDATE
	@Override
	public TransplantRequest update(TransplantRequest transplantRequest, int id) {
		// TODO Auto-generated method stub
		Optional<TransplantRequest> tRequestOpt = trRepo.findById(id);
		if (tRequestOpt != null) {
			TransplantRequest transplantRequestToUpdate = tRequestOpt.get();
			if(transplantRequest.getId() != 0) {transplantRequestToUpdate.setId(transplantRequest.getId());}
			if(transplantRequest.getRecipient() != null ) {transplantRequestToUpdate.setRecipient(transplantRequest.getRecipient());}
			if(transplantRequest.getDonor() !=null) {transplantRequestToUpdate.setDonor(transplantRequest.getDonor());}
			if(transplantRequest.getOrganType() != null) {transplantRequestToUpdate.setOrganType(transplantRequest.getOrganType());}
			if(transplantRequest.getCreatedAt() != null) {transplantRequestToUpdate.setCreatedAt(transplantRequest.getCreatedAt());}
			if(transplantRequest.getApprovalStatus() != null) {transplantRequestToUpdate.setApprovalStatus(transplantRequest.getApprovalStatus());}
			trRepo.saveAndFlush(transplantRequestToUpdate);
			return transplantRequestToUpdate;
		}
		return null;
	}
	
	//DELETE
	@Override
	public boolean destroy(int id) {
		boolean deleted =false;
		Optional<TransplantRequest> transplantRequestOpt =trRepo.findById(id);
		if(transplantRequestOpt != null) {
			TransplantRequest transplantRequest = transplantRequestOpt.get();
			trRepo.delete(transplantRequest);
		 deleted= true;
		}
	 return deleted;
	}
}

