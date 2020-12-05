package com.skilldistillery.organmatcher.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.organmatcher.entities.Patient;

public interface PatientRepository extends JpaRepository<Patient, Integer> {

}
