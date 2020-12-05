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
		assertEquals( "Fred" , patient.getFirstName() );
		assertEquals( "Bob" , patient.getLastName() );
		assertNull( patient.getBirthDate() );
		assertEquals( "male" , patient.getSex() );
		assertEquals( 180 , patient.getWeightKg() );
		assertNotNull( patient.getBloodType() );
		assertEquals( 1 , patient.getBloodType().getId() );
		assertNotNull( patient.getAddress() );
		assertEquals( 1 , patient.getAddress().getId() );
	}

}
