package com.company.userinterface;

import com.company.controller.AppointmentsController;
import com.company.controller.PatientsController;
import com.company.exceptions.UnauthorisedID;
import com.company.model.Appointment;
import com.company.model.Patient;
import com.company.exceptions.ValidationException;
import com.company.utils.DataFormater;

import java.time.LocalDateTime;
import java.util.ConcurrentModificationException;
import java.util.Scanner;

public class UserInterface {
    private PatientsController patientsController;
    private AppointmentsController appointmentsController;

    public UserInterface(PatientsController patientsController, AppointmentsController appointmentsController) {
        this.patientsController = patientsController;
        this.appointmentsController = appointmentsController;
    }

    public static void showMenu() {
        System.out.println("1. ADD A PATIENT");
        System.out.println("2. SHOW ALL PATIENTS");
        System.out.println("3. MAKE AN APPOINTMENT");
        System.out.println("4. DELETE AN APPOINTMENT");
        System.out.println("5. SHOW ALL APPOINTMENTS");
        System.out.println("6. DISPLAY THE APPOINTMENTS SORTED IN ASCENDING ORDER BY THE DURATION");
        System.out.println("7. DISPLAY PATIENTS WITH A CERTAIN AFFECTION");
        System.out.println("x. EXIT");
    }

    public void showAllPatients() {
        for (Patient patient : patientsController.findAll())
            System.out.println(patient.toString());
    }

    public void showAllAppointments() {
        for (Appointment appointment : appointmentsController.findAll())
            System.out.println(appointment.toString());
    }

    public void inputDataForPatients() {
        System.out.println("Enter patient ID: ");
        Scanner scannerID = new Scanner(System.in);
        Integer ID = scannerID.nextInt();

        System.out.println("Enter name: ");
        Scanner scannerName = new Scanner(System.in);
        String name = scannerName.nextLine();

        System.out.println("Enter dentist's name: ");
        Scanner scannerDentist = new Scanner(System.in);
        String dentistName = scannerDentist.nextLine();

        System.out.println("Enter affection: ");
        Scanner scannerAffection = new Scanner(System.in);
        String affection = scannerAffection.nextLine();

        System.out.println("Enter age: ");
        Scanner scannerAge = new Scanner(System.in);
        Integer age = scannerAge.nextInt();
        try {
            patientsController.save(ID, name, dentistName, affection, age);
        } catch (ValidationException validationException) {
            System.out.println(validationException.getMessage());
        }
    }

    public void inputDateForAppointments() {
        System.out.println("Enter appointment ID: ");
        Scanner scannerID = new Scanner(System.in);
        Integer ID = scannerID.nextInt();

        System.out.println("Enter patient ID: ");
        Scanner scannerPatientID = new Scanner(System.in);
        Integer patientID = scannerPatientID.nextInt();

        System.out.println("Enter the date of the appointment with the next format yyyy-MM-dd HH:mm : ");
        Scanner scannerDate = new Scanner(System.in);
        String datetime = scannerDate.nextLine();

        System.out.println("Enter the duration of the appointment: ");
        Scanner scannerDuration = new Scanner(System.in);
        Integer duration = scannerDuration.nextInt();

        LocalDateTime date = DataFormater.geFormatedDate(datetime);
        try {
            appointmentsController.save(ID, patientID, date, duration);
        } catch (ValidationException validationException) {
            System.out.println(validationException.getMessage());
        } catch (Exception exception) {
            System.out.println(exception.getMessage());
        }
    }

    public void deleteAnAppointment() {
        System.out.println("Give the ID of the appointment to be deleted:");
        Scanner scannerID = new Scanner(System.in);
        Integer ID = scannerID.nextInt();
        try {
            appointmentsController.remove(ID);
        } catch (UnauthorisedID unauthorisedID) {
            System.out.println(unauthorisedID.getMessage());
        } catch (ConcurrentModificationException exception) {
            System.out.println("");
        }
    }

    public void displaySortedAppointments() {
        if (appointmentsController.sortAppointmentsByDuration().isEmpty())
            System.out.println("There is no appointment made so far.");
        else {
            System.out.println("The appointments sorted in ascending order by duration are:");
            for (Appointment appointment : appointmentsController.sortAppointmentsByDuration())
                System.out.println(appointment);
        }
    }

    public void filterPatientsWithACertainAffection() {
        System.out.println("Give the affection:");
        Scanner scannerAffection = new Scanner(System.in);
        String affection = scannerAffection.nextLine();
        if (patientsController.filterPatientsWithAGivenAffection(affection).isEmpty())
            System.out.println("There is no patient with the given affection.");
        else {
            System.out.println("The patients with" + affection + " are: ");
            for (Patient patient : patientsController.filterPatientsWithAGivenAffection(affection))
                System.out.println(patient);
        }
    }

    public void run() {
        String option;

        label:
        while (true) {
            showMenu();
            System.out.println("Select the option: ");
            Scanner scanner = new Scanner(System.in);
            option = scanner.nextLine();
            switch (option) {
                case "1":
                    inputDataForPatients();
                    break;
                case "2":
                    showAllPatients();
                    break;
                case "3":
                    inputDateForAppointments();
                    break;
                case "4":
                    deleteAnAppointment();
                    break;
                case "5":
                    showAllAppointments();
                    break;
                case "6":
                    displaySortedAppointments();
                    break;
                case "7":
                    filterPatientsWithACertainAffection();
                    break;
                case "x":
                    break label;
                default:
                    System.out.println("The selected option is invalid!");
                    break;
            }
        }
    }
}


