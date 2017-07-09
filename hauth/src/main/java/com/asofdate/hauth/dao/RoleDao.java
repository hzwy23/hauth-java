package com.asofdate.hauth.dao;

import com.asofdate.hauth.entity.RoleEntity;
import com.asofdate.hauth.entity.UserRoleEntity;

import java.util.List;

/**
 * Created by hzwy23 on 2017/6/18.
 */
public interface RoleDao {
    List<RoleEntity> findAll(String domainId);

    RoleEntity getDetails(String roleId);

    List<RoleEntity> getOther(String userId);

    List<RoleEntity> getOwner(String userId);

    int auth(List<UserRoleEntity> list, String modifyUserId);

    int revoke(List<UserRoleEntity> list);

    int batchAuth(List<UserRoleEntity> list, String modifyUserId);

    int add(RoleEntity roleEntity);

    int delete(List<RoleEntity> list);

    int update(RoleEntity roleEntity);
}
