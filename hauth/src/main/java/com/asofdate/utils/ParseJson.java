package com.asofdate.utils;

import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;

import java.util.List;

/**
 * Created by hzwy23 on 2017/7/8.
 */
public class ParseJson<T> {
    public List<T> toList(String json) {
        return new GsonBuilder().create().fromJson(json,
                new TypeToken<List<T>>() {
                }.getType());
    }
}
