package com.skilldistillery.organmatcher.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table( name = "blood_type" )
@Entity
public class BloodType {
	@Id
	@GeneratedValue( strategy = GenerationType.IDENTITY )
	private int id;
	@Column( name = "blood_group" )
	private char bloodGroup;
	private boolean rh;
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
