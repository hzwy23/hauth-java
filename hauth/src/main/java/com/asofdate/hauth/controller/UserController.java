package com.asofdate.hauth.controller;

import com.asofdate.hauth.authentication.JwtService;
import com.asofdate.hauth.dto.UserDTO;
import com.asofdate.hauth.entity.UserEntity;
import com.asofdate.hauth.service.AuthService;
import com.asofdate.hauth.service.UserService;
import com.asofdate.utils.Hret;
import com.asofdate.utils.ParseJson;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by hzwy23 on 2017/5/19.
 */
@RestController
@RequestMapping(value = "/v1/auth/user")
@Api("用户信息管理")
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private AuthService authService;

    @RequestMapping(method = RequestMethod.GET)
    public List<UserEntity> findAll(HttpServletRequest request) {
        String domainId = request.getParameter("domain_id");
        if (domainId == null || domainId.isEmpty()) {
            domainId = JwtService.getConnUser(request).getDomainID();
        }
        return userService.findAll(domainId);
    }

    @RequestMapping(method = RequestMethod.GET, value = "/search")
    public List<UserEntity> search(HttpServletRequest request) {
        String domainId = request.getParameter("domain_id");
        String orgId = request.getParameter("org_id");
        String statusCd = request.getParameter("status_id");
        return userService.findAll(domainId, orgId, statusCd);
    }

    @RequestMapping(method = RequestMethod.PUT)
    public String update(HttpServletResponse response, HttpServletRequest request) {
        UserEntity userEntity = parse(request);
        int size = userService.update(userEntity);
        if (size == 1) {
            return Hret.success(200, "success", null);
        }
        response.setStatus(421);
        return Hret.error(421, "更新用户信息失败，请联系管理员", null);
    }

    @RequestMapping(value = "/status", method = RequestMethod.PUT)
    public String changeStatus(HttpServletResponse response, HttpServletRequest request) {
        String userId = request.getParameter("userId");
        String status = request.getParameter("userStatus");
        int size = userService.changeStatus(userId, status);
        if (size == 1) {
            return Hret.success(200, "success", null);
        }
        response.setStatus(421);
        return Hret.error(421, "修改用户状态失败，请联系管理员", null);
    }

    @RequestMapping(value = "/password", method = RequestMethod.PUT)
    public String changePasswd(HttpServletResponse response, HttpServletRequest request) {
        String userId = request.getParameter("userId");
        String newPasswd = request.getParameter("newPasswd");
        String surePasswd = request.getParameter("surePasswd");
        if (!newPasswd.equals(surePasswd)) {
            response.setStatus(422);
            return Hret.error(422, "两次输入的密码不正确，请重新确认密码", null);
        }
        UserDTO m = new UserDTO();
        m.setUserId(userId);
        m.setNewPasswd(newPasswd);
        int size = userService.changePassword(m);
        if (size == 1) {
            return Hret.success(200, "success", null);
        }
        response.setStatus(421);
        return Hret.error(421, "修改用户密码失败，请联系管理员", null);
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public String delete(HttpServletResponse response, HttpServletRequest request) {
        String json = request.getParameter("JSON");
        List<UserEntity> list = new ParseJson<UserEntity>().toList(json);
        int size = userService.delete(list);
        if (size == 1) {
            return Hret.success(200, "success", null);
        }
        response.setStatus(421);
        return Hret.error(421, "删除用户信息失败, 请联系管理员", null);
    }

    @RequestMapping(method = RequestMethod.POST)
    public String add(HttpServletResponse response, HttpServletRequest request) {
        UserEntity args = parse(request);
        if (args == null) {
            return Hret.error(422, "参数解析失败,请按照要求填写表单", null);
        }

        String domainId = args.getDomain_id();

        Boolean status = authService.domainAuth(request, domainId, "w").getStatus();
        if (!status) {
            return Hret.error(422, "您没有权限在这个域中创建用户", null);
        }

        int size = userService.add(args);
        if (size != 1) {
            response.setStatus(421);
            return Hret.error(421, "新增用户失败,账号已存在", null);
        }
        return Hret.success(200, "success", null);
    }

    private UserEntity parse(HttpServletRequest request) {
        UserEntity userEntity = new UserEntity();
        String userId = request.getParameter("userId");
        String userDesc = request.getParameter("userDesc");
        String userPasswd = request.getParameter("userPasswd");
        String userPasswdConfirm = request.getParameter("userPasswdConfirm");
        String userEmail = request.getParameter("userEmail");
        String userPhone = request.getParameter("userPhone");
        String domainId = request.getParameter("domainId");
        String userOrgUnitId = request.getParameter("userOrgUnitId");
        String userStatus = request.getParameter("userStatus");
        String crateUserId = JwtService.getConnUser(request).getUserId();

        userEntity.setUser_id(userId);
        userEntity.setUser_name(userDesc);
        userEntity.setUser_passwd(userPasswd);
        userEntity.setUser_passwd_confirm(userPasswdConfirm);
        userEntity.setUser_email(userEmail);
        userEntity.setUser_phone(userPhone);
        userEntity.setOrg_unit_id(userOrgUnitId);
        userEntity.setUser_status(userStatus);
        userEntity.setDomain_id(domainId);
        userEntity.setCreate_user(crateUserId);
        userEntity.setModify_user(crateUserId);

        return userEntity;
    }
}
