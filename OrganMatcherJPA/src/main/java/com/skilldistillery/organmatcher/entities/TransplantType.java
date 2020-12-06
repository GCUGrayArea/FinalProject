package com.skilldistillery.organmatcher.entities;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Table(name="transplant_type")
@Entity
public class TransplantType {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String organ;
	@OneToMany(mappedBy = "organType")
	private List<TransplantRequest> transplantRequests;

	public TransplantType() {
		super();
	}

	public int getId() {
		return id;
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
