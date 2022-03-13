package com.company.model.validators;

import com.company.exceptions.ValidationException;
import com.company.model.Patient;

public class PatientValidator implements Validator<Patient> {
    @Override
    public void validate(Patient patient) throws ValidationException {
        StringBuilder errors = new StringBuilder();
        if (patient.getID() == null)
            errors.append("The patient's ID cannot be null").append("\n");
        if (patient.getAge() < 0)
            errors.append("Age should be greater than 0").append("\n");
        if (patient.getAffection().equals(""))
            errors.append("Affection cannot be null!").append("\n");
        if (patient.getName().equals(""))
            errors.append("Dentist's name cannot be null!").append("\n");
        if (errors.length() > 0)
            throw new ValidationException(errors.toString());
    }
}
