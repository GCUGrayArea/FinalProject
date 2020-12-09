package com.skilldistillery.organmatcher.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.organmatcher.entities.TransplantRequest;

public interface TransplantRequestRepository extends JpaRepository<TransplantRequest, Integer> {
public List<TransplantRequest> findByDonorIsNull();
public List<TransplantRequest> findByDonorIsNullAndOrganTypeId(int id);
public List<TransplantRequest> findByDonorIsNotNullAndApprovalStatusIsNull();
public List<TransplantRequest> findByDonorIsNotNullAndApprovalStatus( String status );
}