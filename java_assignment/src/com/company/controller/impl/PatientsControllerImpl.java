package com.company.controller.impl;

import com.company.controller.PatientsController;
import com.company.exceptions.ValidationException;
import com.company.model.Patient;
import com.company.service.PatientsService;

import java.util.List;

public class PatientsControllerImpl implements PatientsController {
    private PatientsService patientsService;

    public PatientsControllerImpl(PatientsService patientsService) {
        this.patientsService = patientsService;
    }

    @Override
    public void save(Integer ID, String name, String dentistName, String affection, Integer age) throws ValidationException {
        patientsService.save(ID, name, dentistName, affection, age);
    }

    @Override
    public List<Patient> findAll() {
        return patientsService.findAll();
    }

    @Override
    public List<Patient> filterPatientsWithAGivenAffection(String affection) {
        return patientsService.filterPatientsWithAGivenAffection(affection);
    }
}
