package com.skilldistillery.organmatcher.entities;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

@Table(name="transplant_request")
@Entity
public class TransplantRequest {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@ManyToOne
	@JoinColumn(name = "recipient_id")
	private Patient recipient;
	@ManyToOne
	@JoinColumn(name = "donor_id")
	private Patient donor;
	
	@ManyToOne
	@JoinColumn(name = "organ_type_id")
	private TransplantType organType;
	@CreationTimestamp
	@Column(name ="created_at")
	private LocalDateTime createdAt;
	
	@Column(name= "approval_status")
	private String approvalStatus;
	
	
	
	public TransplantRequest() {
		super();
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public Patient getRecipient() {
		return recipient;
	}


	public void setRecipient(Patient recipient) {
		this.recipient = recipient;
	}


	public Patient getDonor() {
		return donor;
	}


	public void setDonor(Patient donor) {
		this.donor = donor;
	}




	public String getApprovalStatus() {
		return approvalStatus;
	}


	public void setApprovalStatus(String approvalStatus) {
		this.approvalStatus = approvalStatus;
	}


	public LocalDateTime getCreatedAt() {
		return createdAt;
	}


	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}





	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}


	@Override
	public String toString() {
		return "TransplantRequest [id=" + id + ", recipient=" + recipient + ", donor=" + donor + ", organType="
				+ organType + ", createdAt=" + createdAt + ", approvalStatus=" + approvalStatus + "]";
	}


	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		TransplantRequest other = (TransplantRequest) obj;
		if (id != other.id)
			return false;
		return true;
	}


	public TransplantType getOrganType() {
		return organType;
	}


	public void setOrganType(TransplantType organType) {
		this.organType = organType;
	}

}
