package com.company.controller;

import com.company.exceptions.ValidationException;
import com.company.model.Patient;

import java.util.List;
import java.util.stream.Collectors;

public interface PatientsController {
    void save(Integer ID, String name, String dentistName, String affection, Integer age) throws ValidationException;

    List<Patient> findAll();

    List<Patient> filterPatientsWithAGivenAffection(String affection);

}
