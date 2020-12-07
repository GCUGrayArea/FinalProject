package com.skilldistillery.organmatcher.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Table( name = "blood_type" )
@Entity
public class BloodType {
	@Id
	@GeneratedValue( strategy = GenerationType.IDENTITY )
	private int id;
	@Column( name = "blood_group" )
	private char bloodGroup;
	private boolean rh;
	
	@JsonIgnore
	@OneToMany(mappedBy = "bloodType")
	private List<Patient> patients;
	
	public BloodType() {
		super();
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public char getBloodGroup() {
		return bloodGroup;
	}
	public void setBloodGroup(char bloodGroup) {
		this.bloodGroup = bloodGroup;
	}
	public boolean isRh() {
		return rh;
	}
	public void setRh(boolean rh) {
		this.rh = rh;
	}
	
	
	public List<Patient> getPatients() {
		return patients;
	}
	public void setPatients(List<Patient> patients) {
		this.patients = patients;
	}
	public boolean canAccept( BloodType other ) {
		//X (AB) can accept any group, but must match otherwise
		if ( this.bloodGroup != 'X' && this.bloodGroup != other.getBloodGroup() ) {
			return false;
		}
		//negative people can't accept positive blood
		if ( !this.isRh() && other.isRh() ) {
			return false;
		}

		return true; //if ABO and Rh haven't disqualified
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
		BloodType other = (BloodType) obj;
		if (id != other.id)
			return false;
		return true;
	}
	
	@Override
	public String toString() {
		return "BloodType [id=" + id + ", bloodGroup=" + bloodGroup + ", rh=" + rh + "]";
	}
	
	
}
