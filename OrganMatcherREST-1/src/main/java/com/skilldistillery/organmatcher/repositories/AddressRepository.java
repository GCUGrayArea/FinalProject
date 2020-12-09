package com.skilldistillery.organmatcher.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.organmatcher.entities.Address;

public interface AddressRepository extends JpaRepository<Address, Integer> {
	
}
