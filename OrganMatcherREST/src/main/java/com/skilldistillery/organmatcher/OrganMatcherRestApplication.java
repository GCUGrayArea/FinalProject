package com.skilldistillery.organmatcher;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@SpringBootApplication
public class OrganMatcherRestApplication {

	public static void main(String[] args) {
		SpringApplication.run(OrganMatcherRestApplication.class, args);
	}
//	@Bean
//	public PasswordEncoder configurePasswordEncoder() {
//		return new BCryptPasswordEncoder();
//	}

}
