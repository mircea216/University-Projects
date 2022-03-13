package com.company.model;

import java.time.LocalDateTime;

public class Appointment {
    private Integer ID;
    private Integer patientID;
    private LocalDateTime date;
    private Integer duration;

    public Appointment() {

    }

    public Appointment(Integer ID, Integer patientID, LocalDateTime date, Integer duration) {
        this.ID = ID;
        this.patientID = patientID;
        this.date = date;
        this.duration = duration;
    }

    public Integer getID() {
        return ID;
    }

    public Integer getPatientID() {
        return patientID;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setID(Integer ID) {
        this.ID = ID;
    }

    public void setPatientID(Integer patientID) {
        this.patientID = patientID;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public Integer getDuration() {
        return duration;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    @Override
    public String toString() {
        return "Appointment -> " +
                "ID: " + ID +
                ", Patient ID: " + patientID +
                ", DATE: " + date +
                ", DURATION: " + duration +
                '}';
    }
}
