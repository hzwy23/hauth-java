package com.asofdate.hauth.service.impl;

import com.asofdate.hauth.dao.UserDao;
import com.asofdate.hauth.dto.UserDTO;
import com.asofdate.hauth.entity.UserEntity;
import com.asofdate.hauth.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by hzwy23 on 2017/6/18.
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;

    @Override
    public List<UserEntity> findAll(String domainid) {
        return userDao.findAll(domainid);
    }

    @Override
    public List<UserEntity> findAll(String domainId, String orgId, String statusCd) {
        return userDao.findAll(domainId, orgId, statusCd);
    }

    @Override
    public int add(UserEntity userEntity) {
        return userDao.add(userEntity);
    }

    @Override
    public int delete(List<UserEntity> list) {
        return userDao.delete(list);
    }

    @Override
    public int update(UserEntity userEntity) {
        return userDao.update(userEntity);
    }

    @Override
    public int changePassword(UserDTO m) {
        return userDao.changePassword(m);
    }

    @Override
    public int changeStatus(String userId, String status) {
        return userDao.changeStatus(userId, status);
    }
}
