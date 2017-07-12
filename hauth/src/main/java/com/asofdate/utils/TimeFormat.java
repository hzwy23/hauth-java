package com.asofdate.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by hzwy23 on 2017/7/10.
 */
public class TimeFormat {
    private static SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private static SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");

    public static String formatTime(String as_of_date) {
        return format(sdfTime, as_of_date);
    }

    public static String formatDate(String as_of_date) {
        return format(sdfDate, as_of_date);
    }

    private static String format(SimpleDateFormat sdf, String as_of_date) {
        if (as_of_date == null || as_of_date.isEmpty()) {
            return as_of_date;
        }
        try {
            Date date = sdf.parse(as_of_date);
            return sdf.format(date);
        } catch (ParseException e) {
            System.out.println("as_of_date type is not yyyy-MM-dd HH:mm:ss," + as_of_date + "," + e.getMessage());
            return as_of_date;
        }
    }
}
