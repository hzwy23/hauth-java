package com.asofdate.hauth.controller;

import com.asofdate.hauth.service.RoleResourceService;
import com.asofdate.utils.Hret;
import com.asofdate.utils.RetMsg;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by hzwy23 on 2017/6/20.
 */
@RestController
@RequestMapping(value = "/v1/auth/role/resource")
@Api("角色与资源关系管理")
public class RoleResourceController {
    @Autowired
    private RoleResourceService roleResourceService;

    @RequestMapping(value = "/owner", method = RequestMethod.GET)
    public List getAll(HttpServletRequest request) {
        String roleId = request.getParameter("role_id");
        return roleResourceService.findAll(roleId);
    }

    @RequestMapping(value = "/other", method = RequestMethod.GET)
    public List getOther(HttpServletRequest request) {
        String roleId = request.getParameter("role_id");
        return roleResourceService.getOther(roleId);
    }

    @RequestMapping(value = "/revoke", method = RequestMethod.POST)
    public String revoke(HttpServletResponse response, HttpServletRequest request) {
        String roleId = request.getParameter("role_id");
        String resId = request.getParameter("res_id");

        RetMsg retMsg = roleResourceService.revoke(roleId, resId);
        if (retMsg.checkCode()) {
            return Hret.success(retMsg);
        }
        response.setStatus(retMsg.getCode());
        return Hret.error(retMsg);

    }

    @RequestMapping(value = "/auth", method = RequestMethod.POST)
    public String auth(HttpServletResponse response, HttpServletRequest request) {
        String roleId = request.getParameter("role_id");
        String resId = request.getParameter("res_id");

        RetMsg retMsg = roleResourceService.auth(roleId, resId);
        if (retMsg.checkCode()) {
            return Hret.success(retMsg);
        }
        response.setStatus(retMsg.getCode());
        return Hret.error(retMsg);
    }
}
