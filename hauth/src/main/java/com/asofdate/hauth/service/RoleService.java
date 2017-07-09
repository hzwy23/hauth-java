package com.asofdate.hauth.service;

import com.asofdate.hauth.entity.RoleEntity;
import com.asofdate.hauth.entity.UserRoleEntity;
import com.asofdate.utils.RetMsg;

import java.util.List;

/**
 * Created by hzwy23 on 2017/6/18.
 */
public interface RoleService {
    List<RoleEntity> findAll(String domainId);

    List<RoleEntity> getOther(String userId);

    List<RoleEntity> getOwner(String userId);

    RoleEntity getDetails(String roleId);

    int auth(List<UserRoleEntity> list, String modifyUserId);

    int revoke(List<UserRoleEntity> list);

    int batchAuth(List<UserRoleEntity> list, String modifyUserId);

    RetMsg add(RoleEntity roleEntity);

    RetMsg delete(List<RoleEntity> list);

    RetMsg update(RoleEntity roleEntity);
}
