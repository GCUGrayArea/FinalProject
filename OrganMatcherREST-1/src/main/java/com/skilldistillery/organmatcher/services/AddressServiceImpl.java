package com.skilldistillery.organmatcher.services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.organmatcher.entities.Address;
import com.skilldistillery.organmatcher.repositories.AddressRepository;

@Service
public class AddressServiceImpl implements AddressService {
	@Autowired
	private AddressRepository repo;

	@Override
	public Address show(int id) {
		Optional<Address> addressOpt= repo.findById(id);
		Address address = null;
		if(addressOpt.get() != null) {
			address = addressOpt.get();
		}
		return address;
	}

	@Override
	public Address create(Address address) {
		repo.saveAndFlush(address);
		return address;
	}

	@Override
	public Address update( Address address , int id ) {
		Optional<Address> addressOpt = repo.findById(id);
		if (addressOpt != null) {
			Address addressToUpdate = addressOpt.get();
			if( address.getStreet1() != null ) {addressToUpdate.setStreet1(address.getStreet1());}
			if( address.getStreet2() !=null ) {addressToUpdate.setStreet2(address.getStreet2());}
			if( address.getCity() != null ) {addressToUpdate.setCity(address.getCity());}
			if( address.getState() != null ) {addressToUpdate.setState(address.getState());}
			if( address.getZip() != null ) {addressToUpdate.setZip(address.getZip());}
			repo.saveAndFlush(addressToUpdate);
			return addressToUpdate;
		}
		return null;
	}

	@Override
	public boolean destroy( int id ) {
			boolean deleted = false;
			Optional<Address> addressOpt = repo.findById( id );
			if(addressOpt != null) {
				repo.deleteById( id );
			 deleted= true;
			}
		 return deleted;
	}
}