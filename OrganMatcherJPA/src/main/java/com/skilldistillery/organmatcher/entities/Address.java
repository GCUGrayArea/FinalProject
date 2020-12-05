package com.skilldistillery.organmatcher.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Address {
	@Id
	@GeneratedValue( strategy = GenerationType.IDENTITY )
	private int id;
	private String street1;
	private String street2;
	private String city;
	private String state;
	private String zip;

}
