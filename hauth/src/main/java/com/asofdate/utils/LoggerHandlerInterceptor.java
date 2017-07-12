package com.asofdate.utils;

import com.asofdate.hauth.authentication.JwtService;
import com.asofdate.hauth.dto.RequestUserDTO;
import com.asofdate.sql.SqlDefine;
import com.google.gson.GsonBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by hzwy23 on 2017/6/19.
 */
@Component
public class LoggerHandlerInterceptor implements HandlerInterceptor {
    private final Logger logger = LoggerFactory.getLogger(LoggerHandlerInterceptor.class);
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {
    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {
        RequestUserDTO httpConn = JwtService.getConnUser(httpServletRequest);
        String userId = httpConn.getUserId();
        String domainId = httpConn.getDomainID();
        String clientIp = httpServletRequest.getRemoteAddr();
        Integer statuCd = httpServletResponse.getStatus();
        String method = httpServletRequest.getMethod();
        String uri = httpServletRequest.getRequestURI();
        Map<String, String[]> map = httpServletRequest.getParameterMap();
        Map<String, String> dt = parseJSON(map);
        String dtvalue = new GsonBuilder().create().toJson(dt);
        jdbcTemplate.update(SqlDefine.sys_rdbms_207, userId, clientIp, statuCd, method, uri, dtvalue, domainId);
    }

    private Map<String, String> parseJSON(Map<String, String[]> map) {
        Map<String, String> dt = new HashMap<>();
        for (Map.Entry<String, String[]> m : map.entrySet()) {
            if ("_".equals(m.getKey())) {
                continue;
            }
            String val = "";
            for (int i = 0; i < m.getValue().length; i++) {
                if (i == 0) {
                    val += m.getValue()[i];
                } else {
                    val += "," + m.getValue()[i];
                }
            }
            dt.put(m.getKey(), val);
        }
        return dt;
    }
}
