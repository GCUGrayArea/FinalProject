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

class TransplantTypeTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private TransplantType transplantType;

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
		transplantType = em.find(TransplantType.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		transplantType = null;
	}

	@Test
	void test() {
		assertNotNull(transplantType);
		
	}

}
