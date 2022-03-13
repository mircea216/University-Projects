package com.company.service;

import com.company.exceptions.UnauthorisedID;
import com.company.model.Appointment;
import com.company.model.Patient;

import java.time.LocalDateTime;
import java.util.List;

public interface AppointmentsService {
    void save(Integer ID, Integer patientID, LocalDateTime date, Integer duration) throws Exception;

    void remove(Integer ID) throws UnauthorisedID;

    List<Appointment> findAll();

    List<Appointment> sortAppointmentsByDuration();

}
