package com.skilldistillery.organmatcher.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.skilldistillery.organmatcher.entities.User;
import com.skilldistillery.organmatcher.repositories.UserRepository;

@Service
public class AuthServiceImpl implements AuthService {

	@Autowired
	private PasswordEncoder encoder;
	
	@Autowired
	private UserRepository repo;
	
	@Override
	public User register( User user ) {
		System.out.println( user );
		System.out.println( user.getPassword() );
		user.setPassword( encoder.encode( user.getPassword() ) );
		user.setEnabled(true);
		user.setRole( "user" );
		repo.saveAndFlush( user );
		return user;
	}

	@Override
	public User getUser( String username ) {
		return repo.findByUsername( username ).isEnabled() ? repo.findByUsername(username) : null;
	}

}
