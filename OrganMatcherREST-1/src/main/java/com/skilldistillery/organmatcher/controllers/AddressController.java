package com.skilldistillery.organmatcher.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.organmatcher.entities.Address;
import com.skilldistillery.organmatcher.services.AddressService;

@CrossOrigin({ "*", "http://localhost:4210" })
@RequestMapping( "api" )
@RestController
public class AddressController {
	
	@Autowired
	private AddressService svc;
	
	@GetMapping("/address/{id}")
	public Address show( @PathVariable int id ) {
		return svc.show( id );
	}
	
	@PutMapping("/address/{id}")
	public Address update( @PathVariable int id, @RequestBody Address address ) {
		return svc.update( address , id );
	}
	
	@PostMapping("/address")
	public Address create( @RequestBody Address address ) {
		return svc.create( address );
	}
	
	@DeleteMapping("/address/{id}")
	public boolean delete( @PathVariable int id ) {
		return svc.destroy( id );
	}
	
}
