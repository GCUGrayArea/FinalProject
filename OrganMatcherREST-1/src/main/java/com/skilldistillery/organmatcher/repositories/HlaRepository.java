package com.skilldistillery.organmatcher.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.organmatcher.entities.Hla;

public interface HlaRepository extends JpaRepository<Hla, Integer> {

}
