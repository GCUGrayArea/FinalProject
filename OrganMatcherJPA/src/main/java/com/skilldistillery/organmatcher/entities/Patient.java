package com.skilldistillery.organmatcher.entities;

import java.time.LocalDate;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Patient {

	@Id
	@GeneratedValue( strategy = GenerationType.IDENTITY )
	private int id;
	@Column(name = "first_name")
	private String firstName;
	@Column(name = "last_name")
	private String lastName;
	@Column( name = "birth_date" )
	private LocalDate birthDate;
	private String sex;
	@Column( name = "weight_kg")
	private int weightKg;
	@ManyToOne
	@JoinColumn( name = "blood_type_id" )
	private BloodType bloodType;
	@ManyToOne
	@JoinColumn( name = "address_id" )
	private Address address;
	@ManyToMany
	  @JoinTable(name="donor_role",
	    joinColumns=@JoinColumn(name="transplant_type_id"),
	    inverseJoinColumns=@JoinColumn(name="patient_id"))
	private List<TransplantType> transplantTypes;
	@OneToMany( mappedBy = "patient" )
	private List<Hla> hlaProteins;
	
	public Patient() {
		super();
	}
	private String notes;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public LocalDate getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(LocalDate birthDate) {
		this.birthDate = birthDate;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public int getWeightKg() {
		return weightKg;
	}
	public void setWeightKg(int weightKg) {
		this.weightKg = weightKg;
	}
	public BloodType getBloodType() {
		return bloodType;
	}
	public void setBloodType(BloodType bloodType) {
		this.bloodType = bloodType;
	}
	public Address getAddress() {
		return address;
	}
	public void setAddress(Address address) {
		this.address = address;
	}
	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
	}
	public List<TransplantType> getTransplantTypes() {
		return transplantTypes;
	}
	public void setTransplantTypes(List<TransplantType> transplantTypes) {
		this.transplantTypes = transplantTypes;
	}
	//TODO add ID field to HLA table in DB and to HLA class so we can test this
	public List<Hla> getHlaProteins() {
		return hlaProteins;
	}
	public void setHlaProteins(List<Hla> hlaProteins) {
		this.hlaProteins = hlaProteins;
	}
	
	public int hlaCompatibility( Patient other ) {
		int hlaMatches = 0;
		
		for ( Hla myHla : this.hlaProteins ) {
			for ( Hla theirHla : other.getHlaProteins() ) {
				if ( myHla.getProteinClass().equals( theirHla.getProteinClass() ) && myHla.getAllele() == theirHla.getAllele() ) {
					hlaMatches++;
					break;
					//breaks *INNER* loop as soon as it finds a match for a given protein
				}
			}
		}
		
		return hlaMatches;
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
		Patient other = (Patient) obj;
		if (id != other.id)
			return false;
		return true;
	}
	
	@Override
	public String toString() {
		return "Patient [id=" + id + ", firstName=" + firstName + ", lastName=" + lastName + ", birthDate=" + birthDate
				+ ", sex=" + sex + ", weightKg=" + weightKg + ", bloodType=" + bloodType + ", notes=" + notes + "]";
	}
	
}
