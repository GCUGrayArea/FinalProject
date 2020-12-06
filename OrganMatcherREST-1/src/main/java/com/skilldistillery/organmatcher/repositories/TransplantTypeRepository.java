package com.skilldistillery.organmatcher.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.organmatcher.entities.TransplantType;

public interface TransplantTypeRepository extends JpaRepository<TransplantType, Integer> {

}
