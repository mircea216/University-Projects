package com.company;

import com.company.controller.AppointmentsController;
import com.company.controller.PatientsController;
import com.company.controller.impl.AppointmentsControllerImpl;
import com.company.controller.impl.PatientsControllerImpl;
import com.company.model.Appointment;
import com.company.model.Patient;
import com.company.model.validators.AppointmentValidator;
import com.company.model.validators.PatientValidator;
import com.company.model.validators.Validator;
import com.company.repository.AppointmentsRepository;
import com.company.repository.PatientsRepository;
import com.company.repository.impl.AppointmentsRepositoryImpl;
import com.company.repository.impl.PatientRepositoryImpl;
import com.company.service.AppointmentsService;
import com.company.service.PatientsService;
import com.company.service.impl.AppointmentsServiceImpl;
import com.company.service.impl.PatientsServiceImpl;
import com.company.userinterface.UserInterface;

public class Main {

    public static void main(String[] args) throws Exception {
        Patient patient = new Patient(1, "John Smith", "Ian Tyler", "teeth decay", 50);
        Validator<Patient> patientValidator = new PatientValidator();
        Validator<Appointment> appointmentValidator = new AppointmentValidator();
        PatientsRepository patientsRepository = new PatientRepositoryImpl(patientValidator);
        patientsRepository.save(patient);
        patientsRepository.save(patient);
        PatientsService patientsService = new PatientsServiceImpl(patientsRepository);
        PatientsController patientsController = new PatientsControllerImpl(patientsService);
        AppointmentsRepository appointmentsRepository = new AppointmentsRepositoryImpl(appointmentValidator);
        AppointmentsService appointmentsService = new AppointmentsServiceImpl(patientsRepository, appointmentsRepository);
        AppointmentsController appointmentsController = new AppointmentsControllerImpl(appointmentsService);
        UserInterface userInterface = new UserInterface(patientsController, appointmentsController);
        userInterface.run();
    }
}
