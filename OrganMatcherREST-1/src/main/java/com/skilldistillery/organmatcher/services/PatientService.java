package com.skilldistillery.organmatcher.services;

import java.util.List;

import com.skilldistillery.organmatcher.entities.Patient;

public interface PatientService {
	public List<Patient> index();
	public Patient patientById( int id );
	public List<Patient> patientsByBloodTypeId( int id );
	public List<Patient> patientsByBloodAndTransplantType( int bloodId , String organ );
	Patient update(Patient patient, int id);
}
