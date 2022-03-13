package com.company.service.impl;

import com.company.exceptions.UnauthorisedID;
import com.company.exceptions.ValidationException;
import com.company.model.Appointment;
import com.company.model.Patient;
import com.company.model.comparators.AppointmentComparator;
import com.company.repository.AppointmentsRepository;
import com.company.repository.PatientsRepository;
import com.company.service.AppointmentsService;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

public class AppointmentsServiceImpl implements AppointmentsService {
    private PatientsRepository patientsRepository;
    private AppointmentsRepository appointmentsRepository;

    public AppointmentsServiceImpl(PatientsRepository patientsRepository, AppointmentsRepository appointmentsRepository) {
        this.patientsRepository = patientsRepository;
        this.appointmentsRepository = appointmentsRepository;
    }


    @Override
    public void save(Integer ID, Integer patientID, LocalDateTime date, Integer duration) throws Exception, ValidationException {
        boolean found = false;
        for (Patient patient : patientsRepository.findAll())
            if (patient.getID().equals(patientID)) {
                found = true;
                break;
            }
        if (!found)
            throw new Exception("There is no patient with the ID:" + patientID.toString());
        Appointment appointment = new Appointment(ID, patientID, date, duration);
        appointmentsRepository.save(appointment);
    }

    @Override
    public void remove(Integer ID) throws UnauthorisedID, ConcurrentModificationException {
        boolean found = false;
        for (Appointment appointment : appointmentsRepository.findAll())
            if (appointment.getID().equals(ID)) {
                found = true;
                break;
            }
        if (!found)
            throw new UnauthorisedID("There is no appointment with the ID: " + ID.toString() + " !");
        appointmentsRepository.remove(ID);
    }

    @Override
    public List<Appointment> findAll() {
        return appointmentsRepository.findAll();
    }

    @Override
    public List<Appointment> sortAppointmentsByDuration() {
        List<Appointment> sortedAppointments = appointmentsRepository.findAll();
        sortedAppointments.sort(new AppointmentComparator());
        return sortedAppointments;
    }

}
