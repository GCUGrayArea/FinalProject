package com.skilldistillery.organmatcher.services;

import java.util.List;

import com.skilldistillery.organmatcher.entities.TransplantType;


public interface TransplantTypeService {

	List<TransplantType> index();
	TransplantType create(TransplantType transplantType);
	TransplantType update(TransplantType transplantType, int id);
	boolean destroy(int id);
	TransplantType show(int id);
	
}
