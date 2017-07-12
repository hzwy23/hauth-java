package com.asofdate.hauth.controller;

import com.asofdate.hauth.authentication.JwtService;
import com.asofdate.sql.SqlDefine;
import io.swagger.annotations.Api;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created by hzwy23 on 2017/5/17.
 */
@Controller
@Api("系统首页管理")
public class SystemPageController {
    private final static Logger logger = LoggerFactory.getLogger(SystemPageController.class);
    @Autowired
    public JdbcTemplate jdbcTemplate;

    @RequestMapping(value = "/HomePage", method = RequestMethod.GET)
    public String homePage(HttpServletRequest request, Map<String, Object> map) {
        Authentication authentication = JwtService
                .getAuthentication((HttpServletRequest) request);
        String username = authentication.getName();
        logger.debug("username is :" + username);
        String url = jdbcTemplate.queryForObject(SqlDefine.sys_rdbms_078, String.class, username);
        url = url.replaceFirst("^./views/", "").replaceFirst(".tpl$", "");
        logger.debug("url is :" + url);
        map.put("userId", username);
        return url;
    }

    @RequestMapping(value = "/v1/auth/index/entry",method = RequestMethod.GET)
    public String subSystemPage(HttpServletRequest request) {
        Authentication authentication = JwtService
                .getAuthentication((HttpServletRequest) request);
        String username = authentication.getName();
        logger.info("username is:" + username);
        String resId = request.getParameter("Id");
        logger.info("resource id is :" + resId);
        String url = jdbcTemplate.queryForObject(SqlDefine.sys_rdbms_011, String.class, username, resId);
        url = url.replaceFirst("^./views/", "").replaceFirst(".tpl$", "").replaceFirst("^./apps/", "");
        logger.info("url is :" + url);
        return url;
    }
}
