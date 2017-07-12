package com.asofdate.hauth.controller;

import com.asofdate.hauth.authentication.JwtService;
import com.asofdate.hauth.dto.AuthDTO;
import com.asofdate.hauth.entity.RoleEntity;
import com.asofdate.hauth.entity.UserRoleEntity;
import com.asofdate.hauth.service.AuthService;
import com.asofdate.hauth.service.RoleService;
import com.asofdate.utils.Hret;
import com.asofdate.utils.JoinCode;
import com.asofdate.utils.ParseJson;
import com.asofdate.utils.RetMsg;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import io.swagger.annotations.Api;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by hzwy23 on 2017/6/18.
 */
@RestController
@RequestMapping(value = "/v1/auth/role")
@Api("角色定义管理")
public class RoleController {
    private final Logger logger = LoggerFactory.getLogger(RoleController.class);
    @Autowired
    private RoleService roleService;

    @Autowired
    private AuthService authService;

    @RequestMapping(value = "/other", method = RequestMethod.GET)
    public List getOther(HttpServletRequest request) {
        String userId = request.getParameter("user_id");
        return roleService.getOther(userId);
    }

    @RequestMapping(value = "/owner", method = RequestMethod.GET)
    public List getOwner(HttpServletRequest request) {
        String userId = request.getParameter("user_id");
        return roleService.getOwner(userId);
    }

    @RequestMapping(value = "/auth", method = RequestMethod.POST)
    public String auth(HttpServletResponse response, HttpServletRequest request) {
        String modifyUserId = JwtService.getConnUser(request).getUserId();
        String json = request.getParameter("JSON");
        List<UserRoleEntity> list = new ParseJson<UserRoleEntity>().toList(json);
        try {
            int size = roleService.auth(list, modifyUserId);
            if (1 == size) {
                return Hret.success(200, "success", null);
            }
            response.setStatus(422);
            return Hret.error(422, "授权失败,用户已经拥有了这个角色", null);
        } catch (Exception e) {
            logger.info(e.getMessage());
            response.setStatus(421);
            return Hret.error(421, "授权失败,用户已经拥有了这个角色", null);
        }
    }


    @RequestMapping(value = "/auth/batch", method = RequestMethod.POST)
    public String batchAuth(HttpServletResponse response, HttpServletRequest request) {
        String modifyUserId = JwtService.getConnUser(request).getUserId();
        String json = request.getParameter("JSON");
        List<UserRoleEntity> list = new ParseJson<UserRoleEntity>().toList(json);
        try {
            int size = roleService.batchAuth(list, modifyUserId);
            if (1 == size) {
                return Hret.success(200, "success", null);
            }
            response.setStatus(422);
            return Hret.error(422, "授权失败,用户已经拥有了这个角色", null);
        } catch (Exception e) {
            logger.info(e.getMessage());
            response.setStatus(421);
            return Hret.error(421, "授权失败,用户已经拥有了这个角色", null);
        }
    }

    @RequestMapping(value = "/revoke", method = RequestMethod.POST)
    public String revoke(HttpServletResponse response, HttpServletRequest request) {
        String json = request.getParameter("JSON");
        List<UserRoleEntity> list = new ParseJson<UserRoleEntity>().toList(json);
        try {
            int size = roleService.revoke(list);
            if (1 == size) {
                return Hret.success(200, "success", null);
            }
            response.setStatus(422);
            return Hret.error(422, "撤销权限失败,请联系管理员", null);
        } catch (Exception e) {
            logger.info(e.getMessage());
            response.setStatus(421);
            return Hret.error(421, "撤销权限失败,请联系管理员", null);
        }
    }

    @RequestMapping(method = RequestMethod.GET)
    public String findAll(HttpServletRequest request) {
        String domainId = request.getParameter("domain_id");
        if (domainId == null || domainId.isEmpty()) {
            domainId = JwtService.getConnUser(request).getDomainID();
        }
        AuthDTO authDTO = authService.domainAuth(request, domainId, "r");
        if (!authDTO.getStatus()) {
            return Hret.error(403, "权限不足，您没有被授权访问这个域", authDTO.getMessage());
        }
        return new GsonBuilder().create().toJson(roleService.findAll(domainId));
    }

    /**
     * 新增角色信息
     */
    @RequestMapping(method = RequestMethod.POST)
    public String add(HttpServletResponse response, HttpServletRequest request) {
        RoleEntity roleEntity = parse(request);
        String domainId = roleEntity.getDomain_id();
        AuthDTO authDTO = authService.domainAuth(request, domainId, "w");
        if (!authDTO.getStatus()) {
            return Hret.error(403, "您没有权限在域【" + domainId + "】中新增角色", null);
        }
        RetMsg retMsg = roleService.add(roleEntity);
        if (retMsg.checkCode()) {
            return Hret.success(retMsg);
        }
        response.setStatus(retMsg.getCode());
        return Hret.error(retMsg);
    }

    @RequestMapping(method = RequestMethod.PUT)
    public String update(HttpServletRequest request, HttpServletResponse response) {
        RoleEntity roleEntity = parse(request);

        String domainId = roleEntity.getDomain_id();
        AuthDTO authDTO = authService.domainAuth(request, domainId, "w");
        if (!authDTO.getStatus()) {
            return Hret.error(403, "您没有权限在域【" + domainId + "】中更新角色", null);
        }

        RetMsg retMsg = roleService.update(roleEntity);
        if (retMsg.checkCode()) {
            return Hret.success(retMsg);
        }
        response.setStatus(retMsg.getCode());
        return Hret.error(retMsg);
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public String delete(HttpServletResponse response, HttpServletRequest request) {
        String json = request.getParameter("JSON");
        List<RoleEntity> list = new GsonBuilder().create().fromJson(json, new TypeToken<List<RoleEntity>>() {
        }.getType());

        for (RoleEntity m : list) {
            AuthDTO authDTO = authService.domainAuth(request, m.getDomain_id(), "w");
            if (!authDTO.getStatus()) {
                return Hret.error(403, "您没有权限删除域【" + m.getDomain_id() + "】中的角色信息", null);
            }
        }

        RetMsg retMsg = roleService.delete(list);
        if (!retMsg.checkCode()) {
            response.setStatus(retMsg.getCode());
            return Hret.error(retMsg);
        }
        return Hret.success(retMsg);
    }

    private RoleEntity parse(HttpServletRequest request) {
        RoleEntity roleEntity = new RoleEntity();
        String codeNumber = request.getParameter("role_id");
        String domainId = request.getParameter("domain_id");
        roleEntity.setCode_number(codeNumber);
        roleEntity.setRole_name(request.getParameter("role_name"));
        roleEntity.setRole_status_code(request.getParameter("role_status"));
        roleEntity.setDomain_id(domainId);
        String userId = JwtService.getConnUser(request).getUserId();
        roleEntity.setCreate_user(userId);
        roleEntity.setModify_user(userId);
        String roleId = JoinCode.join(domainId, codeNumber);
        roleEntity.setRole_id(roleId);
        return roleEntity;
    }
}
