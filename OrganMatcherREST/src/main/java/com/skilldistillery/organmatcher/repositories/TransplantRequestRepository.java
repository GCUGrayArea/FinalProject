package com.skilldistillery.organmatcher.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.organmatcher.entities.TransplantRequest;

public interface TransplantRequestRepository extends JpaRepository<TransplantRequest, Integer> {

}
