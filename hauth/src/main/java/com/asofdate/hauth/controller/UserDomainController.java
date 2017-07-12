package com.asofdate.hauth.controller;

import com.asofdate.hauth.authentication.JwtService;
import com.asofdate.hauth.dto.DomainDTO;
import com.asofdate.hauth.service.DomainService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by hzwy23 on 2017/6/18.
 */
@RestController
@Api("用户可访问域管理")
public class UserDomainController {
    @Autowired
    private DomainService domainService;

    @RequestMapping(value = "/v1/auth/domain/self/owner", method = RequestMethod.GET)
    @ResponseBody
    public DomainDTO getDomain(HttpServletRequest request) {

        // 获取连接用户账号
        String domainId = JwtService.getConnUser(request).getDomainID();

        return domainService.findAll(domainId);
    }
}
