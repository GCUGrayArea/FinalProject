package com.skilldistillery.organmatcher.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Table(name="transplant_type")
@Entity
public class TransplantType {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String organ;
	@OneToMany(mappedBy = "organType")
	@JsonIgnore
	private List<TransplantRequest> transplantRequests;
	@ManyToMany( mappedBy="transplantTypes" )
	@JsonIgnore
	private List<Patient> donors;
	
	public TransplantType() {
		super();
	}

	public int getId() {
		return id;
	}

	public List<TransplantRequest> getTransplantRequests() {
		return transplantRequests;
	}

	public void setTransplantRequests(List<TransplantRequest> transplantRequests) {
		this.transplantRequests = transplantRequests;
	}

	public List<Patient> getDonors() {
		return donors;
	}

	public void setDonors(List<Patient> donors) {
		this.donors = donors;
	}
	
	public void addDonor( Patient donor ) {
		if ( donors == null ) { donors = new ArrayList<Patient>(); }
		
		if ( !donors.contains( donor ) ) {
			donors.add(donor);
			donor.addTransplantType( this );
		}
	}

	public void removeDonor( Patient donor ) {
		if ( donors != null && donors.contains( donor ) ) {
			donors.remove( donor );
			donor.removeTransplantType( this );
		}
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getOrgan() {
		return organ;
	}

	public void setOrgan(String organ) {
		this.organ = organ;
	}

	@Override
	public String toString() {
		return "TransplantType [id=" + id + ", organ=" + organ + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		TransplantType other = (TransplantType) obj;
		if (id != other.id)
			return false;
		return true;
	}

	
	
	
	
}
