/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.api.SmartBeehive.controller;

import com.api.SmartBeehive.service.SensorDataService;
import com.fasterxml.jackson.core.JsonProcessingException;
import java.util.concurrent.ExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author czeed
 */
@CrossOrigin
@RestController
@RequestMapping("/sensor_data")
public class SensorDataController {
    
     @Autowired
    private SensorDataService sensorSDataService;
     
     @GetMapping("/{userId}/{rucherId}/{rucheId}")
    public String getUserInfos(@PathVariable String userId,@PathVariable String rucherId,@PathVariable String rucheId) throws  ExecutionException, InterruptedException, JsonProcessingException {
        
        return sensorSDataService.getDataByRucheId(userId, rucherId, rucheId);
    }
    
}
