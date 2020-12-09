package com.skilldistillery.organmatcher.services;

import com.skilldistillery.organmatcher.entities.User;

public interface AuthService {
	public User register( User user );
	public User getUser( String username );
}
