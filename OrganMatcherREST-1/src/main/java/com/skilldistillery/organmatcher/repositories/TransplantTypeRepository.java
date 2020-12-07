package com.skilldistillery.organmatcher.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.organmatcher.entities.TransplantRequest;
import com.skilldistillery.organmatcher.entities.TransplantType;

public interface TransplantTypeRepository extends JpaRepository<TransplantType, Integer> {

}
