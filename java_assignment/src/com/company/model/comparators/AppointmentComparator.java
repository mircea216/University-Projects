package com.company.model.comparators;

import com.company.model.Appointment;

import java.util.Comparator;

public class AppointmentComparator implements Comparator<Appointment> {
    @Override
    public int compare(Appointment appointment1, Appointment appointment2) {
        return appointment1.getDuration() - appointment2.getDuration();
    }
}
