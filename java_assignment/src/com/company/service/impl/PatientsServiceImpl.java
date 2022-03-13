package com.company.service.impl;

import com.company.model.Patient;
import com.company.exceptions.ValidationException;
import com.company.repository.PatientsRepository;
import com.company.service.PatientsService;

import java.util.List;
import java.util.stream.Collectors;

public class PatientsServiceImpl implements PatientsService {
    private PatientsRepository patientsRepository;

    public PatientsServiceImpl(PatientsRepository patientsRepository) {
        this.patientsRepository = patientsRepository;
    }

    @Override
    public void save(Integer ID, String name, String dentistName, String affection, Integer age) throws ValidationException {
        Patient patient = new Patient(ID, name, dentistName, affection, age);
        patientsRepository.save(patient);
    }

    @Override
    public List<Patient> findAll() {
        return patientsRepository.findAll();
    }

    @Override
    public List<Patient> filterPatientsWithAGivenAffection(String affection) {
        return patientsRepository.findAll().stream().filter(patient -> patient.getAffection().
                equals(affection)).collect(Collectors.toList());
    }
}
