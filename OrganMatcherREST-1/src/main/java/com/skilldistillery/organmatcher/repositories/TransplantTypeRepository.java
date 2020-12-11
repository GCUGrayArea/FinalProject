package com.skilldistillery.organmatcher.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.organmatcher.entities.TransplantRequest;
import com.skilldistillery.organmatcher.entities.TransplantType;

public interface TransplantTypeRepository extends JpaRepository<TransplantType, Integer> {

	@Modifying
	@Query( value= "INSERT into donor_role (patient_id, transplant_type_id) VALUES (:patientId, :transplantTypeId)", 
		 nativeQuery=true)
	public boolean addDonorRole(@Param( "patientId")  int patientId, @Param("transplantTypeId") int transplantTypeId);

	
	@Modifying
	@Query( value= "DELETE from donor_role where patient_id = :patientId and transplant_type_id = :transplantTypeId", 
		 nativeQuery=true)
	public boolean removeDonorRole(@Param( "patientId")  int patientId, @Param("transplantTypeId") int transplantTypeId);

}
