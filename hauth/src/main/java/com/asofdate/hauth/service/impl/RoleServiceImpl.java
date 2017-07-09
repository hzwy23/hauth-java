package com.asofdate.hauth.service.impl;

import com.asofdate.hauth.dao.RoleDao;
import com.asofdate.hauth.entity.RoleEntity;
import com.asofdate.hauth.entity.UserRoleEntity;
import com.asofdate.hauth.service.RoleService;
import com.asofdate.utils.RetMsg;
import com.asofdate.utils.SysStatus;
import com.asofdate.utils.factory.RetMsgFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by hzwy23 on 2017/6/18.
 */
@Service
public class RoleServiceImpl implements RoleService {
    private final Logger logger = LoggerFactory.getLogger(RoleServiceImpl.class);
    @Autowired
    private RoleDao roleDao;

    @Override
    public List<RoleEntity> findAll(String domainId) {
        return roleDao.findAll(domainId);
    }

    @Override
    public List<RoleEntity> getOther(String userId) {
        return roleDao.getOther(userId);
    }

    @Override
    public List<RoleEntity> getOwner(String userId) {
        return roleDao.getOwner(userId);
    }

    @Override
    public RoleEntity getDetails(String roleId) {
        return roleDao.getDetails(roleId);
    }

    @Override
    public int auth(List<UserRoleEntity> list, String modifyUserId) {
        return roleDao.auth(list, modifyUserId);
    }

    @Override
    public int revoke(List<UserRoleEntity> list) {
        return roleDao.revoke(list);
    }

    @Override
    public int batchAuth(List<UserRoleEntity> list, String modifyUserId) {
        return roleDao.batchAuth(list, modifyUserId);
    }

    @Override
    public RetMsg add(RoleEntity roleEntity) {
        try {
            int size = roleDao.add(roleEntity);
            if (1 == size) {
                return RetMsgFactory.getRetMsg(SysStatus.SUCCESS_CODE, "success", null);
            }
            return RetMsgFactory.getRetMsg(SysStatus.ERROR_CODE, "新增角色信息失败，请联系管理员", null);
        } catch (Exception e) {
            return RetMsgFactory.getRetMsg(SysStatus.EXCEPTION_ERROR_CODE, e.getMessage(), null);
        }
    }

    @Override
    public RetMsg delete(List<RoleEntity> list) {
        try {
            int size = roleDao.delete(list);
            if (1 == size) {
                return RetMsgFactory.getRetMsg(SysStatus.SUCCESS_CODE, "success", null);
            }
            return RetMsgFactory.getRetMsg(SysStatus.ERROR_CODE, "删除角色信息失败，请联系管理员", null);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return RetMsgFactory.getRetMsg(SysStatus.EXCEPTION_ERROR_CODE, e.getMessage(), null);
        }
    }

    @Override
    public RetMsg update(RoleEntity roleEntity) {
        try {
            int size = roleDao.update(roleEntity);
            if (1 == size) {
                return RetMsgFactory.getRetMsg(SysStatus.SUCCESS_CODE, "success", null);
            }
            return RetMsgFactory.getRetMsg(SysStatus.ERROR_CODE, "更新角色信息失败，请联系管理员", null);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return RetMsgFactory.getRetMsg(SysStatus.EXCEPTION_ERROR_CODE, e.getMessage(), null);
        }
    }
}
