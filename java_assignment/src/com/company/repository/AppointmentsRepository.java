package com.company.repository;

import com.company.exceptions.ValidationException;
import com.company.model.Appointment;

import java.util.List;

public interface AppointmentsRepository {
    void save(Appointment appointment) throws ValidationException;

    void remove(Integer appointmentID);

    List<Appointment> findAll();
}
