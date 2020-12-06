package com.skilldistillery.organmatcher.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.organmatcher.entities.Patient;
import com.skilldistillery.organmatcher.entities.TransplantRequest;

public interface TransplantRequestRepository extends JpaRepository<TransplantRequest, Integer> {
//	@Query("SELECT t from TransplantRequest t join fetch t.donor WHERE t.donor is null")
//	  List<TransplantRequest> queryByDonorIsNull();
public List<TransplantRequest> findByDonor(Patient patient);
//public List<TransplantRequest> findByDonorIsNullAndOrganTypeId();
//public List<TransplantRequest> findByDonorIsNotNullAndApprovalStatusIsNull();
}
