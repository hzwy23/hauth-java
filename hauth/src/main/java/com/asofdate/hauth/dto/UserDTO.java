package com.asofdate.hauth.dto;

/**
 * Created by hzwy23 on 2017/7/8.
 */
public class UserDTO {
    public String userId;
    public String newPasswd;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getNewPasswd() {
        return newPasswd;
    }

    public void setNewPasswd(String newPasswd) {
        this.newPasswd = newPasswd;
    }

    @Override
    public String toString() {
        return "UserDTO{" +
                "userId='" + userId + '\'' +
                ", newPasswd='" + newPasswd + '\'' +
                '}';
    }
}
