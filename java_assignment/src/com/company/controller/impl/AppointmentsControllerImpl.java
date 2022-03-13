package com.company.controller.impl;

import com.company.controller.AppointmentsController;
import com.company.exceptions.UnauthorisedID;
import com.company.model.Appointment;
import com.company.exceptions.ValidationException;
import com.company.service.AppointmentsService;

import java.time.LocalDateTime;
import java.util.ConcurrentModificationException;
import java.util.List;

public class AppointmentsControllerImpl implements AppointmentsController {
    private AppointmentsService appointmentsService;

    public AppointmentsControllerImpl(AppointmentsService appointmentsService) {
        this.appointmentsService = appointmentsService;
    }

    @Override
    public void save(Integer ID, Integer patientID, LocalDateTime date, Integer duration) throws Exception, ValidationException {
        appointmentsService.save(ID, patientID, date, duration);
    }

    @Override
    public void remove(Integer ID) throws UnauthorisedID, ConcurrentModificationException {
        appointmentsService.remove(ID);
    }

    @Override
    public List<Appointment> findAll() {
        return appointmentsService.findAll();
    }

    @Override
    public List<Appointment> sortAppointmentsByDuration() {
        return appointmentsService.sortAppointmentsByDuration();
    }
}
