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

class TransplantRequestTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private TransplantRequest tr;

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
		tr = em.find(TransplantRequest.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		tr = null;
	}

	@Test
	void test() {
		assertNotNull(tr);
		assertEquals(1, tr.getOrganType());
		assertNull( tr.getDonor());
	}


}
