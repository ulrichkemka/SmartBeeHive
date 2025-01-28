/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.api.SmartBeehive.controller;


import com.api.SmartBeehive.entity.Rucher;
import com.api.SmartBeehive.service.RucherService;
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
@RequestMapping("user/rucher")
public class RucherController {
    @Autowired
    private RucherService rucherService;
    
       @GetMapping("/{userId}")
    public String getRuchersByUserId(@PathVariable String userId) throws  ExecutionException, InterruptedException, JsonProcessingException {
        
        return rucherService.getRuchersByUserId(userId);
    }
    
       @GetMapping("/{userId}/{rucherId}")
    public String getRucherByRucherId(@PathVariable String userId, @PathVariable String rucherId) throws  ExecutionException, InterruptedException, JsonProcessingException {
        
        return rucherService.getRucherByRucherId(userId,rucherId);
    }
    
    @PostMapping("/{userId}")
    public String saveProduct(@RequestBody Rucher rucher, @PathVariable String userId) throws  ExecutionException, InterruptedException {
        
        return rucherService.saveRucher(rucher,userId);
    }
    
    @PutMapping("/{userId}/{rucherId}")
    public String updateRucher(@RequestBody Rucher rucher,@PathVariable String rucherId, @PathVariable String userId ) throws  ExecutionException, InterruptedException {
        
        return rucherService.updateRucher(rucher,rucherId, userId);
    }
    
    @DeleteMapping("/{userId}/{rucherId}")
    public String deleteRucher(@PathVariable String userId, @PathVariable String rucherId ) throws  ExecutionException, InterruptedException, JsonProcessingException {
        
        return rucherService.deleteRucher(userId,rucherId);
    }
    
    
}
