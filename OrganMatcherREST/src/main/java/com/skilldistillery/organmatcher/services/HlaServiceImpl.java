package com.skilldistillery.organmatcher.services;

import org.springframework.beans.factory.annotation.Autowired;

import com.skilldistillery.organmatcher.repositories.HlaRepository;

public class HlaServiceImpl implements HlaService {

	@Autowired
	private HlaRepository hlaRepo;
	
	//LIST ALL
//	@Override
//	public Set<Hla> list() {
//		// TODO Auto-generated method stub
//		return bRepo.findAll();
//	}
	
	//SHOW
//	@Override
//	public Hla show() {
//		return bRepo.findById(id);
//		
//	}

	//CREATE
//	@Override
//	public Hla create(Hla hla) {
//		brepo.saveAndFlush(hla);
//		return hla;
//	}

	
	//UPDATE
//	@Override
//	public Hla update(Hla hla, int id) {
//		// TODO Auto-generated method stub
//		Hla hlaToUpdate = bRepo.findById(id);
//		if (hlaToUpdate != null) {
//			if(hla.getId() != null) {hlaToUpdate.setID(hla.getID());}
//			if(hla.getProteinClass() != null ) {hlaToUpdate.setProteinClass(hla.getProteinClass());}
//			if(hla.getAllele() !=null) {hlaToUpdate.setAllele(hla.getAllele());}
//			bRepo.saveAndFlush(hlaToUpdate);
//		}
//		return hlaToUpdate;
//	}
	
	//DELETE
//	@Override
//	public boolean destroy() {
//		boolean deleted =false;
//		Hla hla =bRepo.findById(id);
//		if(hla != null) {
//			bRepo.delete(hla);
//		 deleted= true;
//		}
//	 return deleted;
//	}
}


