package com.asofdate.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by hzwy23 on 2017/6/30.
 */
public class Validator {

    private static final Logger logger = LoggerFactory.getLogger(Validator.class);

    public static Boolean isAdminDomain(String domainID) {
        if ("vertex_root".equals(domainID)) {
            return true;
        }
        return false;
    }

    public static Boolean isFloat(String str) {
        Pattern pattern = Pattern.compile("(-\\+)^[0-9]*(\\.[0-9])$");
        Matcher matcher = pattern.matcher(str);
        if (matcher.matches()) {
            return true;
        }
        return false;
    }

    public static Boolean isWord(String str) {
        Pattern pattern = Pattern.compile("^[A-Za-z0-9]*[_A-Za-z0-9]*[A-Za-z0-9]$");
        Matcher matcher = pattern.matcher(str);
        if (matcher.matches()) {
            return true;
        }
        return false;
    }

    public static Boolean isWord(String str, Integer max) {
        if (str.length() > max) {
            return false;
        }
        return isWord(str);
    }

    public static Boolean isWord(String str, Integer min, Integer max) {
        if (str.length() > max || str.length() < min) {
            return false;
        }
        return isWord(str);
    }


    public static Boolean isAlphabet(String str) {
        Pattern pattern = Pattern.compile("^[A-Za-z]*$");
        Matcher matcher = pattern.matcher(str);
        if (matcher.matches()) {
            return true;
        }
        return false;
    }

    public static Boolean isAlphabet(String str, Integer max) {
        if (str.length() > max) {
            return false;
        }
        return isAlphabet(str);
    }

    public static Boolean isAlphabet(String str, Integer min, Integer max) {
        if (str.length() > max || str.length() < min) {
            return false;
        }
        return isAlphabet(str);
    }

    public static Boolean isNumeric(String str) {
        if (str == null || str.isEmpty()) {
            return false;
        }
        Pattern pattern = Pattern.compile("^[0-9]*$");
        Matcher matcher = pattern.matcher(str);
        if (matcher.matches()) {
            return true;
        }
        return false;
    }

    public static Boolean isDate(String str) {
        Pattern pattern = Pattern.compile("^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$");
        Matcher matcher = pattern.matcher(str);
        if (matcher.matches()) {
            return true;
        }
        return false;
    }

    public static Boolean isTime(String str) {
        Pattern pattern = Pattern.compile("^(?:(?!0000)[0-9]{4}(-|/)(?:(?:0[1-9]|1[0-2])(-|/)(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])(-|/)(?:29|30)|(?:0[13578]|1[02])(-|/)31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)\\s+([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]$");
        Matcher matcher = pattern.matcher(str);
        if (matcher.matches()) {
            return true;
        }
        return false;
    }
}
