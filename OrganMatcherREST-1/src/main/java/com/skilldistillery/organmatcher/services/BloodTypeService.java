package com.skilldistillery.organmatcher.services;

import java.util.List;

import com.skilldistillery.organmatcher.entities.BloodType;

public interface BloodTypeService {

	List<BloodType> listAll();

	BloodType show(int id);

	BloodType create(BloodType bloodType);

	BloodType update(BloodType bloodType, int id);

	boolean destroy(int id);

}
