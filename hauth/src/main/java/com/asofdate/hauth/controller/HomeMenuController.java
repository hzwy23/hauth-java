package com.asofdate.hauth.controller;

import com.asofdate.hauth.authentication.JwtService;
import com.asofdate.hauth.entity.HomeMenuEntity;
import com.asofdate.hauth.service.HomeMenuService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by hzwy23 on 2017/5/15.
 */
@RestController
@Api("用户可访问资源服务")
public class HomeMenuController {
    @Autowired
    public HomeMenuService homeMenuService;

    @RequestMapping(value = "/v1/auth/main/menu",method = RequestMethod.GET)
    @ResponseBody
    public List<HomeMenuEntity> homeMenu(HttpServletRequest request) {
        String TypeId = request.getParameter("TypeId");
        String Id = request.getParameter("Id");

        String username = JwtService.getConnUser(request).getUserId();
        List<HomeMenuEntity> homeMenusModel = homeMenuService.findAuthedMenus(username, TypeId, Id);
        return homeMenusModel;
    }
}
