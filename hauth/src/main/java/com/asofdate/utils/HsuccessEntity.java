package com.asofdate.utils;

/**
 * Created by hzwy23 on 2017/7/3.
 */
public class HsuccessEntity {
    public Integer reply_code;
    public String reply_msg;
    public Object data;

    public HsuccessEntity(RetMsg retMsg) {
        this.reply_code = retMsg.getCode();
        this.reply_msg = retMsg.getMessage();
        this.data = retMsg.getDetails();
    }

    public HsuccessEntity(Integer reply_code, String reply_msg, Object data) {
        this.reply_code = reply_code;
        this.reply_msg = reply_msg;
        this.data = data;
    }

    public Integer getReplyCode() {
        return reply_code;
    }

    public void setReplyCode(Integer reply_code) {
        this.reply_code = reply_code;
    }

    public String getReplyMsg() {
        return reply_msg;
    }

    public void setReplyMsg(String reply_msg) {
        this.reply_msg = reply_msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return "HsuccessEntity{" +
                "reply_code=" + reply_code +
                ", reply_msg='" + reply_msg + '\'' +
                ", data=" + data +
                '}';
    }
}
