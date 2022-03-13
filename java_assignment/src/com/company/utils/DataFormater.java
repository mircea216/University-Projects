package com.company.utils;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class DataFormater {
    public static LocalDateTime geFormatedDate(String date) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        return LocalDateTime.parse(date, formatter);
    }
}
