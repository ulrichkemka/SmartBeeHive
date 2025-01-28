/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.api.SmartBeehive.service;



import com.api.SmartBeehive.entity.Ruche;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ExecutionException;
import org.springframework.stereotype.Service;

/**
 *
 * @author czeed
 */
@Service
public class RucheService {
    
    public String saveRuche(Ruche ruche, String rucherId, String apiref) throws InterruptedException, ExecutionException{
         Firestore dbFirestore = FirestoreClient.getFirestore();
          
         ruche.setId(UUID.randomUUID().toString());
         ApiFuture<WriteResult> collectionApiFuture =  dbFirestore.collection("smartbeehive")
                 .document("app").collection("apiculteur")
                 .document(apiref).collection("rucher")
                 .document(rucherId).collection("Ruche")
                 .document(ruche.getId()).set(ruche);
         
          return collectionApiFuture.get().getUpdateTime().toString();
         
 }
    
    
     public String getRuchesByUserId(String userId,String rucherId) throws InterruptedException, ExecutionException, JsonProcessingException {
    Firestore dbFirestore = FirestoreClient.getFirestore();
    
    
    ApiFuture<QuerySnapshot> future = dbFirestore.collection("smartbeehive")
            .document("app")
            .collection("apiculteur")
            .document(userId)
            .collection("rucher")
            .document(rucherId)
            .collection("Ruche")
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
    
    public String getRucheByRucheId(String userId, String rucherId,String rucheId) throws InterruptedException, ExecutionException, JsonProcessingException {
    Firestore dbFirestore = FirestoreClient.getFirestore();
    
    ApiFuture<DocumentSnapshot> future = dbFirestore.collection("smartbeehive")
            .document("app")
            .collection("apiculteur")
            .document(userId)
            .collection("rucher")
            .document(rucherId)
            .collection("Ruche")
            .document(rucheId)
            .get();
    
  
        DocumentSnapshot documents =  future.get();
    
    // Convertir les documents en une liste de HashMap
  
        Map<String, Object> documentData = documents.getData();
        
    
    // Convertir la liste en JSON
    ObjectMapper objectMapper = new ObjectMapper();
    String json = objectMapper.writeValueAsString(documentData);
    
    return json;  
    
       
} 
     public String updateRuche(Ruche ruche, String rucheId,String rucherId, String apiref) throws InterruptedException, ExecutionException{
         Firestore dbFirestore = FirestoreClient.getFirestore();
         
         Map<String,Object> updatedData = new HashMap<>();
         updatedData.put("nom", ruche.getNom());
         updatedData.put("description", ruche.getDescription());
         updatedData.put("email", ruche.getEmail());
         
         ApiFuture<WriteResult> collectionApiFuture =  dbFirestore.collection("smartbeehive")
                 .document("app").collection("apiculteur")
                 .document(apiref).collection("rucher")
                 .document(rucherId).collection("Ruche")
                 .document(rucheId).update(updatedData);
         
         
        return collectionApiFuture.get().getUpdateTime().toString();
    }
     
     
    public String deleteRuche(String userId, String rucherId, String rucheId) throws InterruptedException, ExecutionException, JsonProcessingException {
    Firestore dbFirestore = FirestoreClient.getFirestore();
    ApiFuture<WriteResult> future = dbFirestore.collection("smartbeehive")
            .document("app")
            .collection("apiculteur")
            .document(userId)
            .collection("rucher")
            .document(rucherId)
            .collection("Ruche")
            .document(rucheId)
            .delete();
    
     return future.get().getUpdateTime().toString();
    
}
   

    
}
