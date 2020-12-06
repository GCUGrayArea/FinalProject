package com.skilldistillery.organmatcher.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.organmatcher.entities.Patient;

public interface PatientRepository extends JpaRepository<Patient, Integer> {
	public List<Patient> findByBloodTypeId( int typeId );
	@Query("SELECT * FROM Patient p JOIN FETCH p.transplantTypes t WHERE p.bloodType.id = :typeId AND :transplantId IN t.id")
	public List<Patient> findByBloodTypeAndOrganType( @Param("typeId") int typeId , @Param("organType") int transplantId );
}
