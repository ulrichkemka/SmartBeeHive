/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.api.SmartBeehive.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.google.firebase.auth.FirebaseAuth;
import java.util.concurrent.ExecutionException;

/**
 *
 * @author czeed
 */
public class AuthService {
    
     public String deleteUser(String userId) throws InterruptedException, ExecutionException, JsonProcessingException {
        FirebaseAuth mAuth;
        mAuth = FirebaseAuth.getInstance();
          
    
   // ApiFuture<UserRecord> future =  mAuth.createUserAsync("");
    
    return "future.get().getUpdateTime().toString()";
}
    
}


/*



*/