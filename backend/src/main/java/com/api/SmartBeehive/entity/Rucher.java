/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.api.SmartBeehive.entity;

import java.util.UUID;

/**
 *
 * @author czeed
 */
public class Rucher {
    
  private String adresse;
  private String nom;
  private String description;
  private final String id;
  
   public Rucher() {
        this.id = UUID.randomUUID().toString();
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }


    public String getId() {
        return id;
    }

    public void setId(String id) {
       
    }
  
   
}
