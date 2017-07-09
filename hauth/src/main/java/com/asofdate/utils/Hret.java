package com.asofdate.utils;

import com.google.gson.GsonBuilder;

/**
 * Created by hzwy23 on 2017/5/18.
 */
public class Hret {

    public static String error(RetMsg retMsg) {
        HerrorEntity herrorEntity = new HerrorEntity(retMsg);
        return new GsonBuilder().create().toJson(herrorEntity);
    }

    public static String error(int status, String message, Object result) {
        HerrorEntity herrorEntity = new HerrorEntity(status, message, result);
        return new GsonBuilder().create().toJson(herrorEntity);
    }

    public static String success(int status, String message, Object result) {
        HsuccessEntity hsuccessEntity = new HsuccessEntity(status, message, result);
        return new GsonBuilder().create().toJson(hsuccessEntity);
    }

    public static String success(RetMsg retMsg) {
        HsuccessEntity hsuccessEntity = new HsuccessEntity(retMsg);
        return new GsonBuilder().create().toJson(hsuccessEntity);
    }

    public static String success() {
        HsuccessEntity hsuccessEntity = new HsuccessEntity(200, "success", null);
        return new GsonBuilder().create().toJson(hsuccessEntity);
    }
}
