package com.skilldistillery.organmatcher.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class PatientTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Patient patient;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("OrganMatcherPU");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		patient = em.find(Patient.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		patient = null;
	}
	
	@Test
	void testMappings() {
		assertEquals( "Terry" , patient.getFirstName() );
		assertEquals( "GOLDEN" , patient.getLastName() );
		assertEquals( "M" , patient.getSex() );
		assertEquals( 55 , patient.getWeightKg() );
		assertNotNull( patient.getBloodType() );
		assertEquals( 1 , patient.getBloodType().getId() );
		assertNotNull( patient.getAddress() );
		assertEquals( 1 , patient.getAddress().getId() );
		assertEquals( 0, patient.getTransplantTypes().size() );
		assertEquals( 6, patient.getHlaProteins().size() );
	}

}
