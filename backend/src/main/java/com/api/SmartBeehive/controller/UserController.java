/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.api.SmartBeehive.controller;



import com.api.SmartBeehive.entity.User;
import com.api.SmartBeehive.service.UserService;
import com.fasterxml.jackson.core.JsonProcessingException;
import java.util.concurrent.ExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;




/**
 *
 * @author czeed
 */
@CrossOrigin
@RestController
@RequestMapping("/user")
public class UserController {
    
    @Autowired
    private UserService userService;
    
    @PostMapping("/")
    public String saveProduct(@RequestBody User user) throws  ExecutionException, InterruptedException {
         
        return userService.saveUser(user);
    }
    
     @GetMapping("/{userId}")
    public String getUserInfos(@PathVariable String userId) throws  ExecutionException, InterruptedException, JsonProcessingException {
        
        return userService.getUserInfos(userId);
    }
    
     @GetMapping("/")
    public String getAllUserInfos() throws  ExecutionException, InterruptedException, JsonProcessingException {
        
        return userService.getAllusers();
    }
    
    @PutMapping("/{userId}/{userRole}")
    public String updateUserInfos(@RequestBody User user,@PathVariable String userId,@PathVariable String userRole) throws  ExecutionException, InterruptedException, JsonProcessingException {
        
        return userService.updateUser(user, userId, userRole);
    }
    
      @DeleteMapping("/{userId}")
    public String deleteRucher(@PathVariable String userId ) throws  ExecutionException, InterruptedException, JsonProcessingException {
        
        return userService.deleteUser(userId);
    }
}
