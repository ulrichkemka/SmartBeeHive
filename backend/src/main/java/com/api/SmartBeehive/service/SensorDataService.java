/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.api.SmartBeehive.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.firebase.cloud.FirestoreClient;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import org.springframework.stereotype.Service;

/**
 *
 * @author czeed
 */
@Service
public class SensorDataService {
    
    public String getDataByRucheId(String userId,String rucherId,String rucheId) throws InterruptedException, ExecutionException, JsonProcessingException {
    Firestore dbFirestore = FirestoreClient.getFirestore();
    
    ApiFuture<QuerySnapshot> future = dbFirestore.collection("smartbeehive")
            .document("app")
            .collection("apiculteur")
            .document(userId)
            .collection("rucher")
            .document(rucherId)
            .collection("Ruche")
            .document(rucheId)
            .collection("sensor_data")
            .orderBy("date")
            .get();
    
   
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();
    
        // Convertir les documents en une liste de HashMap
        List<Map<String, Object>> documentList = new ArrayList<>();
        for (QueryDocumentSnapshot document : documents) {
            Map<String, Object> documentData = document.getData();
            String id = document.getReference().getId();
            if( !"init".equals(id))
            documentList.add(documentData);
        }

        // Convertir la liste en JSON
        ObjectMapper objectMapper = new ObjectMapper();
        String json = objectMapper.writeValueAsString(documentList);

        return json;
        
    
}
    
}
