package com.skilldistillery.organmatcher.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.organmatcher.entities.BloodType;

public interface BloodTypeRepository extends JpaRepository<BloodType, Integer> {

}
