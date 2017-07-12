package com.asofdate.hauth.controller;

import com.asofdate.hauth.authentication.JwtService;
import com.asofdate.hauth.entity.UserDetailsEntity;
import com.asofdate.hauth.service.UserDetailsService;
import com.asofdate.sql.SqlDefine;
import com.asofdate.utils.CryptoAES;
import com.asofdate.utils.Hret;
import io.swagger.annotations.Api;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by hzwy23 on 2017/5/18.
 */
@Controller
@Api("主题配置管理")
public class ThemeController {
    private final static Logger logger = LoggerFactory.getLogger(SystemPageController.class);
    @Autowired
    public JdbcTemplate jdbcTemplate;
    @Autowired
    public UserDetailsService userDetailsService;

    @RequestMapping(value = "/v1/auth/theme/update", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public String changeTheme(HttpServletResponse response, HttpServletRequest request) {
        String themeId = request.getParameter("theme_id");

        Authentication authentication = JwtService
                .getAuthentication((HttpServletRequest) request);
        String username = authentication.getName();
        logger.info("request user id is:" + username);
        try {
            int code = jdbcTemplate.update(SqlDefine.sys_rdbms_024, themeId, username);
            if (1 == code) {
                return Hret.success(200, "modify theme info successfully", null);
            } else {
                response.setStatus(421);
                return Hret.error(421, "modify user theme failed", null);
            }
        } catch (Exception e) {
            logger.info(e.getMessage());
            response.setStatus(422);
            return Hret.error(422, e.getMessage(), null);
        }

    }

    @RequestMapping(value = "/v1/auth/passwd/update", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public String changePasswd(HttpServletResponse response, HttpServletRequest request) {
        String msg = "modify user password success";
        Authentication authentication = JwtService
                .getAuthentication((HttpServletRequest) request);
        String username = authentication.getName();
        String userId = request.getParameter("userid");
        if (!username.equals(userId)) {
            msg = "forbin change other user's password";
            response.setStatus(421);
            logger.info(msg);
            return Hret.error(421, msg, null);
        }
        String oldPassword = request.getParameter("orapasswd");
        String newPassword = request.getParameter("newpasswd");
        String confirmPassword = request.getParameter("surepasswd");
        if (!newPassword.equals(confirmPassword)) {
            msg = "new password and comfirm password is not same. please check your new passwod and confirm password";
            response.setStatus(421);
            logger.info(msg);
            return Hret.error(421, msg, null);
        }

        if (newPassword == null || newPassword.length() < 6) {
            msg = "new password length must greater than 6 and can not be empty.";
            response.setStatus(421);
            logger.info(msg);
            return Hret.error(421, msg, null);
        }

        if (newPassword.length() > 30) {
            msg = "new password length must less than 30";
            response.setStatus(421);
            logger.info(msg);
            return Hret.error(421, msg, null);
        }

        oldPassword = CryptoAES.aesEncrypt(oldPassword);
        newPassword = CryptoAES.aesEncrypt(newPassword);

        int code = jdbcTemplate.update(SqlDefine.sys_rdbms_014, newPassword, userId, oldPassword);
        if (1 == code) {
            response.setStatus(200);
            logger.info("modify user password successfully, user id is :" + username);
            return Hret.success(200, msg, null);
        } else {
            response.setStatus(421);
            logger.info("user id is not exists or old password is not right.");
            return Hret.error(421, msg, null);
        }
    }

    @RequestMapping(value = "/v1/auth/user/query", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public UserDetailsEntity getUserDetailsInfo(HttpServletRequest request) {
        Authentication authentication = JwtService
                .getAuthentication((HttpServletRequest) request);
        String username = authentication.getName();
        logger.info("check user details info. user id is : " + username);
        UserDetailsEntity userDetailsEntity = userDetailsService.findById(username);
        return userDetailsEntity;
    }
}
