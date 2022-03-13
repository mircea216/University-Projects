package com.company.model;

public class Patient {
    private Integer ID;
    private String name;
    private String dentistName;
    private String affection;
    private Integer age;

    public Patient() {
    }

    public Patient(Integer ID, String name, String dentistName, String affection, Integer age) {
        this.ID = ID;
        this.name = name;
        this.dentistName = dentistName;
        this.affection = affection;
        this.age = age;
    }

    public Integer getID() {
        return ID;
    }

    public String getName() {
        return name;
    }

    public String getDentistName() {
        return dentistName;
    }

    public String getAffection() {
        return affection;
    }

    public Integer getAge() {
        return age;
    }

    public void setID(Integer ID) {
        this.ID = ID;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDentistName(String dentistName) {
        this.dentistName = dentistName;
    }

    public void setAffection(String affection) {
        this.affection = affection;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    @Override
    public String toString() {
        return "Patient -> " +
                "ID: " + ID.toString() +
                ", NAME: '" + name + '\'' +
                ", DENTIST: '" + dentistName + '\'' +
                ", AFFECTION: '" + affection + '\'' +
                ", AGE: " + age.toString();
    }
}

