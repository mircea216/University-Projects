package com.company.repository.impl;

import com.company.exceptions.ValidationException;
import com.company.model.Appointment;
import com.company.model.validators.AppointmentValidator;
import com.company.model.validators.Validator;
import com.company.repository.AppointmentsRepository;

import java.util.ArrayList;
import java.util.ConcurrentModificationException;
import java.util.List;

public class AppointmentsRepositoryImpl implements AppointmentsRepository {
    private final Validator<Appointment> appointmentValidator;
    private final List<Appointment> storageOfAppointments;

    public AppointmentsRepositoryImpl(Validator<Appointment> appointmentValidator) {
        storageOfAppointments = new ArrayList<>();
        this.appointmentValidator = appointmentValidator;
    }

    @Override
    public void save(Appointment appointment) throws ValidationException {
        appointmentValidator.validate(appointment);
        storageOfAppointments.add(appointment);
    }

    @Override
    public void remove(Integer appointmentID) throws ConcurrentModificationException {
        for (Appointment appointment : findAll())
            if (appointment.getID().equals(appointmentID))
                storageOfAppointments.remove(appointment);
    }

    @Override
    public List<Appointment> findAll() {
        return storageOfAppointments;
    }
}
