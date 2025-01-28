/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.api.SmartBeehive.controller;

/**
 *
 * @author czeed
 */
import com.google.api.core.ApiFuture;
import com.google.firebase.auth.FirebaseAuth;

import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.UserRecord;
import com.google.firebase.auth.UserRecord.CreateRequest;
import java.io.IOException;
import java.util.concurrent.ExecutionException;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@CrossOrigin
@RestController
@RequestMapping("/auth")
public class AuthController {

    

    @GetMapping("/{mail}")
    public String auth(@PathVariable String mail) throws FirebaseAuthException, InterruptedException, ExecutionException {
       FirebaseAuth mAuth = FirebaseAuth.getInstance();
       ApiFuture<UserRecord> future = mAuth.getUserByEmailAsync(mail);
       UserRecord user = future.get();
        if (user != null) {
            return user.getUid();
        } else {
            return "Not authenticated";
        }
    }
    
    
    @PostMapping("/create/{uid}/{mail}/{password}")
    public String auth2(@PathVariable String mail, @PathVariable String password,@PathVariable String uid) throws FirebaseAuthException, InterruptedException, ExecutionException {
       FirebaseAuth mAuth = FirebaseAuth.getInstance();
        CreateRequest createRequest = new CreateRequest();
        createRequest.setEmail(mail);
        createRequest.setPassword(password);
        createRequest.setUid(uid);
       ApiFuture<UserRecord> future = mAuth.createUserAsync(createRequest);
       UserRecord user = future.get();
        if (user != null) {
            return user.getUid();
        } else {
            return "Not authenticated";
        }
        
    }
    
     @PostMapping("/signIn/{mail}/{password}")
    public ResponseEntity<String> signInWithEmailAndPassword(@PathVariable String mail, @PathVariable String password) {
        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<String> request = new HttpEntity<>(
                "{\"email\":\"" + mail + "\",\"password\":\"" + password + "\",\"returnSecureToken\":true}", headers);

        String response = restTemplate.exchange(
                "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=" + "AIzaSyCSATNP9YA346NouFnDTwWEfDjU8yTRDFQ",
                HttpMethod.POST, request, String.class).getBody();

        return ResponseEntity.status(HttpStatus.OK).body(response);
    }
    
     @ExceptionHandler(IOException.class)
    public ResponseEntity<String> handleIOException(IOException e) {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Error: " + e.getMessage());
    }
    
}