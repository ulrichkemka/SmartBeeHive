/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.api.SmartBeehive.controller;


import com.api.SmartBeehive.entity.Ruche;
import com.api.SmartBeehive.service.RucheService;
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
@RequestMapping("user/rucher/ruche")
public class RucheController {
    @Autowired
    private RucheService rucheService;
    
    @PostMapping("/{userId}/{rucherId}")
    public String saveRuche(@RequestBody Ruche ruche, @PathVariable String rucherId, @PathVariable String userId ) throws  ExecutionException, InterruptedException {
        
        return rucheService.saveRuche(ruche, rucherId, userId);
    }
    
     @GetMapping("/{userId}/{rucherId}")
    public String getRuchesByUserId(@PathVariable String userId,@PathVariable String rucherId) throws  ExecutionException, InterruptedException, JsonProcessingException {
        
        return rucheService.getRuchesByUserId(userId,rucherId);
    }
    
     @GetMapping("/{userId}/{rucherId}/{rucheId}")
    public String getRucheByRucheId(@PathVariable String userId,@PathVariable String rucherId,@PathVariable String rucheId) throws  ExecutionException, InterruptedException, JsonProcessingException {
        
        return rucheService.getRucheByRucheId(userId,rucherId,rucheId);
    }
    
    @PutMapping("/{userId}/{rucherId}/{rucheId}")
    public String updateRuche(@RequestBody Ruche ruche, @PathVariable String rucheId,@PathVariable String rucherId, @PathVariable String userId ) throws  ExecutionException, InterruptedException {
        
        return rucheService.updateRuche(ruche, rucheId ,rucherId, userId);
    }
    
     @DeleteMapping("/{userId}/{rucherId}/{rucheId}")
    public String deleteRuche(@PathVariable String rucheId,@PathVariable String rucherId, @PathVariable String userId ) throws  ExecutionException, InterruptedException, JsonProcessingException {
       
        return rucheService.deleteRuche(userId, rucherId ,rucheId);
    }
    
    
}