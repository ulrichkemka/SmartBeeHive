package com.api.SmartBeehive.entity;

import java.util.UUID;

public class Product {

    private String id;
    private String name;
    private String description;

    public Product() {
        this.id = UUID.randomUUID().toString();
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setId(String id) {
        // Ne faites rien ici pour le rendre en lecture seule
    }
}