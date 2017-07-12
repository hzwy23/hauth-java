package com.asofdate.hauth.controller;

import com.asofdate.hauth.authentication.JwtService;
import com.asofdate.hauth.entity.ShareDomainEntity;
import com.asofdate.hauth.service.AuthService;
import com.asofdate.hauth.service.ShareDomainService;
import com.asofdate.utils.Hret;
import com.asofdate.utils.ParseJson;
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
 * Created by hzwy23 on 2017/6/19.
 */
@RestController
@RequestMapping(value = "/v1/auth/share/domain")
@Api("域共享配置管理")
public class ShareDomainController {
    private final Logger logger = LoggerFactory.getLogger(ShareDomainController.class);

    @Autowired
    private AuthService authService;

    @Autowired
    private ShareDomainService shareDomainService;

    @RequestMapping(method = RequestMethod.GET)
    public List findAll(HttpServletRequest request) {
        String domainId = request.getParameter("domain_id");
        return shareDomainService.findAll(domainId);
    }

    @RequestMapping(method = RequestMethod.POST)
    public String add(HttpServletResponse response, HttpServletRequest request) {
        ShareDomainEntity arg = parse(request);
        String domainid = arg.getDomain_id();
        Boolean status = authService.domainAuth(request, domainid, "w").getStatus();
        if (!status) {
            response.setStatus(403);
            return Hret.error(403, "您没有权限修改域[" + domainid + "]的授权信息", null);
        }

        if (arg == null) {
            return Hret.error(421, "解析参数失败", null);
        }
        int size = shareDomainService.add(arg);
        if (size == 1) {
            return Hret.success(200, "success", null);
        }

        response.setStatus(421);
        return Hret.error(421, "授权域权限信息失败,请联系管理员", null);
    }

    @RequestMapping(method = RequestMethod.PUT)
    public String update(HttpServletResponse response, HttpServletRequest request) {
        ShareDomainEntity arg = parse(request);
        if (arg == null) {
            return Hret.error(421, "解析参数失败", null);
        }
        String domainId = arg.getDomain_id();
        Boolean status = authService.domainAuth(request, domainId, "w").getStatus();
        if (!status) {
            response.setStatus(403);
            return Hret.error(403, "您没有权限修改域[" + domainId + "]的授权信息", null);
        }

        int size = shareDomainService.update(arg);
        if (size == 1) {
            return Hret.success(200, "success", null);
        }

        response.setStatus(421);
        return Hret.error(421, "更新域权限信息失败,请联系管理员", null);
    }

    @RequestMapping(method = RequestMethod.POST, value = "/delete")
    public String delete(HttpServletResponse response, HttpServletRequest request) {
        String args = request.getParameter("JSON");
        List<ShareDomainEntity> list = new ParseJson<ShareDomainEntity>().toList(args);
        String domainId = request.getParameter("domain_id");
        Boolean status = authService.domainAuth(request, domainId, "w").getStatus();
        if (!status) {
            response.setStatus(403);
            return Hret.error(403, "您没有权限删除域[ " + domainId + " ]的授权信息", null);
        }

        try {
            int size = shareDomainService.delete(list);
            if (size == 1) {
                return Hret.success(200, "success", null);
            }
            response.setStatus(421);
            return Hret.error(421, "更新域权限信息失败,请联系管理员", null);

        } catch (Exception e) {
            logger.info(e.getMessage());
            response.setStatus(422);
            return Hret.error(422, "删除域授权信息失败,请联系管理员", null);
        }
    }

    @RequestMapping(value = "/unshare", method = RequestMethod.GET)
    public List unshareTarget(HttpServletRequest request) {
        String domainId = request.getParameter("domain_id");
        return shareDomainService.unShareTarget(domainId);
    }

    private ShareDomainEntity parse(HttpServletRequest request) {
        ShareDomainEntity shareDomainEntity = new ShareDomainEntity();
        shareDomainEntity.setDomain_id(request.getParameter("domain_id"));
        shareDomainEntity.setTarget_domain_id(request.getParameter("target_domain_id"));
        shareDomainEntity.setAuthorization_level(request.getParameter("authorization_level"));
        shareDomainEntity.setUuid(request.getParameter("uuid"));
        String userId = JwtService.getConnUser(request).getUserId();
        shareDomainEntity.setCreate_user(userId);
        shareDomainEntity.setModify_user(userId);
        return shareDomainEntity;
    }
}
