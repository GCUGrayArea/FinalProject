package com.skilldistillery.organmatcher.services;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.hibernate.annotations.CreationTimestamp;
import org.springframework.beans.factory.annotation.Autowired;

import com.skilldistillery.organmatcher.entities.Patient;
import com.skilldistillery.organmatcher.repositories.TransplantRequestServiceRepository;

public class TransplantRequestServiceImpl implements TransplantRequestService {

	@Autowired
	private TransplantRequestServiceRepository trRepo;
	
	//LIST ALL
//	@Override
//	public Set<TransplantRequestService> list() {
//		// TODO Auto-generated method stub
//		return trRepo.findAll();
//	}
	
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

@GeneratedValue(strategy = GenerationType.IDENTITY)
private int id;
@ManyToOne
@JoinColumn(name = "recipient_id")
private Patient recipient;
@ManyToOne
@JoinColumn(name = "donor_id")
private Patient donor;
@Column(name = "organ_type_id")
private Integer organType;
@CreationTimestamp
@Column(name ="created_at")
private LocalDateTime createdAt;

