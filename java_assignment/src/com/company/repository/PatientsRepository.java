package com.company.repository;

import com.company.exceptions.ValidationException;
import com.company.model.Patient;

import java.util.List;

public interface PatientsRepository {
    void save(Patient patient) throws ValidationException;

    List<Patient> findAll();
}
