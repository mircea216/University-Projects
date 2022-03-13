package com.company.model.validators;

import com.company.exceptions.ValidationException;
import com.company.model.Appointment;

public class AppointmentValidator implements Validator<Appointment> {
    @Override
    public void validate(Appointment appointment) throws ValidationException {
        StringBuilder errors = new StringBuilder();
        if (appointment.getPatientID() == null)
            errors.append("The patient's ID cannot be null!").append("\n");
        if (appointment.getID() == null)
            errors.append("The appointment's ID cannot be null!").append("\n");
        if (appointment.getDuration() < 0)
            errors.append("The duration should be greater than 0!").append("\n");
        if (errors.length() > 0)
            throw new ValidationException(errors.toString());
    }
}
