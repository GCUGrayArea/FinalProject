package com.skilldistillery.organmatcher.services;

import com.skilldistillery.organmatcher.entities.Address;

public interface AddressService {
	public Address show( int id );
	public Address create( Address address );
	public Address update( Address address , int id );
	public boolean destroy( int id );
}
