package com.skilldistillery.organmatcher.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import com.skilldistillery.organmatcher.entities.*;

public interface UserRepository extends JpaRepository<User, Integer> {
	User findByUsername(String username);
}
