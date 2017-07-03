package com.asofdate.utils;

/**
 * Created by hzwy23 on 2017/7/3.
 */
public class HerrorEntity {
    public Integer error_code;
    public String error_msg;
    public Object error_details;

    public HerrorEntity(RetMsg retMsg) {
        this.error_code = retMsg.getCode();
        this.error_msg = retMsg.getMessage();
        this.error_details = retMsg.getDetails();
    }

    public HerrorEntity(Integer error_code, String error_msg, Object error_details) {
        this.error_code = error_code;
        this.error_msg = error_msg;
        this.error_details = error_details;
    }

    public Integer getErrorCode() {
        return error_code;
    }

    public void setErrorCode(Integer error_code) {
        this.error_code = error_code;
    }

    public String getErrorMsg() {
        return error_msg;
    }

    public void setErrorMsg(String error_msg) {
        this.error_msg = error_msg;
    }

    public Object getErrorDetails() {
        return error_details;
    }

    public void setErrorDetails(Object error_details) {
        this.error_details = error_details;
    }

    @Override
    public String toString() {
        return "HerrorEntity{" +
                "error_code='" + error_code + '\'' +
                ", error_msg='" + error_msg + '\'' +
                ", error_details='" + error_details + '\'' +
                '}';
    }
}
