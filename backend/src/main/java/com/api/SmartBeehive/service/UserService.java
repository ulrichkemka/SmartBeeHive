/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.api.SmartBeehive.service;


import com.api.SmartBeehive.entity.User;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.UserRecord;
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
public class UserService {
    
    public String saveUser(User user) throws InterruptedException, ExecutionException{
         Firestore dbFirestore = FirestoreClient.getFirestore();
         user.setId(UUID.randomUUID().toString());
         ApiFuture<WriteResult> collectionApiFuture =  dbFirestore.collection("smartbeehive")
                                                            .document("app")
                                                            .collection(user.role )
                                                            .document(user.getId())
                                                            .set(user);
         
          FirebaseAuth mAuth = FirebaseAuth.getInstance();
        UserRecord.CreateRequest createRequest = new UserRecord.CreateRequest();
        createRequest.setEmail(user.getEmail());
        createRequest.setPassword(user.getPassword());
        createRequest.setUid(user.getId());
       ApiFuture<UserRecord> future = mAuth.createUserAsync(createRequest);
       UserRecord newUser = future.get();
        if (newUser != null) {
             return collectionApiFuture.get().getUpdateTime().toString();
        } else {
            return "Not authenticated";
        }
        
    }
    
    public String getUserInfos(String userId) throws InterruptedException, ExecutionException, JsonProcessingException{
        Firestore dbFirestore = FirestoreClient.getFirestore();
        DocumentReference documentReference =  dbFirestore.collection("smartbeehive")
                                                            .document("app")
                                                            .collection("apiculteur")
                                                            .document(userId);
        
        DocumentReference documentReference_ =  dbFirestore.collection("smartbeehive")
                                                            .document("app")
                                                            .collection("administrateur")
                                                            .document(userId);
        
       ApiFuture<DocumentSnapshot> future = documentReference.get();
       ApiFuture<DocumentSnapshot> future_ = documentReference_.get();
       
      
       DocumentSnapshot document = future.get();
       DocumentSnapshot document_ = future_.get();

        if (document.exists()) {
             // Convertir les documents en une liste de HashMap
  
        Map<String, Object> documentData = document.getData();
        
        // Convertir la liste en JSON
        ObjectMapper objectMapper = new ObjectMapper();
        String json = objectMapper.writeValueAsString(documentData);
    
        return json;
            
        }
        
         if (document_.exists()) {
              // Convertir les documents en une liste de HashMap
  
        Map<String, Object> documentData = document_.getData();
        
        // Convertir la liste en JSON
        ObjectMapper objectMapper = new ObjectMapper();
        String json = objectMapper.writeValueAsString(documentData);
    
        return json;
          
        }
         

        return "no matching user";
        
   
   }
    
 
    public String getAllusers() throws InterruptedException, ExecutionException, JsonProcessingException {
    Firestore dbFirestore = FirestoreClient.getFirestore();
    
    
    ApiFuture<QuerySnapshot> future = dbFirestore.collection("smartbeehive")
            .document("app")
            .collection("apiculteur")
            .get();
    
    ApiFuture<QuerySnapshot> future_ = dbFirestore.collection("smartbeehive")
            .document("app")
            .collection("administrateur")
            .get();
    
    
       List<QueryDocumentSnapshot> documents = future.get().getDocuments();
    List<QueryDocumentSnapshot> documents_ = future_.get().getDocuments();
    
    // Convertir les documents en une liste de HashMap
    List<Map<String, Object>> documentList = new ArrayList<>();
    for (QueryDocumentSnapshot document : documents) {
        Map<String, Object> documentData = document.getData();
        String id = document.getReference().getId();
        if( !"init".equals(id))
        documentList.add(documentData);
    }
    
    for (QueryDocumentSnapshot document : documents_) {
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
  
 
   
   
public String updateUser(User user, String userId, String questSenderRole) throws InterruptedException, ExecutionException{
         Firestore dbFirestore = FirestoreClient.getFirestore();
         
         Map<String,Object> updatedData = new HashMap<>();
         updatedData.put("username", user.getUsername());
         updatedData.put("nom", user.getNom());
         updatedData.put("prenom", user.getPrenom());
         updatedData.put("adresse", user.getAdresse());
         updatedData.put("email", user.getEmail());
         updatedData.put("prenom", user.getPrenom());
         if(questSenderRole.equals("Administrateur")){
             updatedData.put("role", user.getRole());
         }
         
         ApiFuture<WriteResult> collectionApiFuture =  dbFirestore.collection("smartbeehive")
                 .document("app")
                 .collection(user.role)
                 .document(userId)
                 .update(updatedData);
         
         return collectionApiFuture.get().getUpdateTime().toString();
    }
    

     public String deleteUser(String userId) throws InterruptedException, ExecutionException, JsonProcessingException {
    Firestore dbFirestore = FirestoreClient.getFirestore();
    
    ApiFuture<WriteResult> future = dbFirestore.collection("smartbeehive")
            .document("app")
            .collection("apiculteur")
            .document(userId)
            .delete();
    
     return future.get().getUpdateTime().toString();
}
             
    
}
