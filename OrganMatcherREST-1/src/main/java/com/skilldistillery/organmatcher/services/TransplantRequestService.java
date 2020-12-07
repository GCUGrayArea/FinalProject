package com.skilldistillery.organmatcher.services;

import java.util.List;

import com.skilldistillery.organmatcher.entities.TransplantRequest;

public interface TransplantRequestService {

	List<TransplantRequest> index();

List<TransplantRequest> findByUnmatched();
List<TransplantRequest> findForOrgan(int id);
List<TransplantRequest> findUnapprovedRequests();
	TransplantRequest create(TransplantRequest transplantRequest);

	TransplantRequest update(TransplantRequest transplantRequest, int id);

	boolean destroy(int id);

	TransplantRequest show(int id);

}
