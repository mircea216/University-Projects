package com.company.repository.impl;

import com.company.exceptions.ValidationException;
import com.company.model.Patient;
import com.company.model.validators.PatientValidator;
import com.company.model.validators.Validator;
import com.company.repository.PatientsRepository;

import java.util.ArrayList;
import java.util.List;

public class PatientRepositoryImpl implements PatientsRepository {
    private final List<Patient> storageOfPatients;
    private final Validator<Patient> patientValidator;

    public PatientRepositoryImpl(Validator<Patient> patientValidator) {
        storageOfPatients = new ArrayList<>();
        this.patientValidator = patientValidator;
    }

    @Override
    public void save(Patient patient) throws ValidationException {
        patientValidator.validate(patient);
        storageOfPatients.add(patient);
    }

    @Override
    public List<Patient> findAll() {
        return storageOfPatients;
    }
}
