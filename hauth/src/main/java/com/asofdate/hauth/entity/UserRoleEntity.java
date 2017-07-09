package com.asofdate.hauth.entity;

/**
 * Created by hzwy23 on 2017/7/8.
 */
public class UserRoleEntity {
    public String user_id;
    public String role_id;

    public String getUserId() {
        return user_id;
    }

    public void setUserId(String user_id) {
        this.user_id = user_id;
    }

    public String getRoleId() {
        return role_id;
    }

    public void setRoleId(String role_id) {
        this.role_id = role_id;
    }

    @Override
    public String toString() {
        return "UserRoleEntity{" +
                "user_id='" + user_id + '\'' +
                ", role_id='" + role_id + '\'' +
                '}';
    }
}
