package com.skilldistillery.organmatcher.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Table( name = "protein_class")
@Entity
public class ProteinClass {

	@Id
	@GeneratedValue( strategy = GenerationType.IDENTITY )
	private int id;
	@Column( name = "protein_class" )
	private String proteinClass;
	private String description;
	@OneToMany( mappedBy = "proteinClass" )
	private List<Hla> hlaList;
	
	public ProteinClass() {
		super();
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getProteinClass() {
		return proteinClass;
	}
	public void setProteinClass(String proteinClass) {
		this.proteinClass = proteinClass;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
		ProteinClass other = (ProteinClass) obj;
		if (id != other.id)
			return false;
		return true;
	}
	
	@Override
	public String toString() {
		return "ProteinClass [id=" + id + ", proteinClass=" + proteinClass + ", description=" + description + "]";
	}
	
}
