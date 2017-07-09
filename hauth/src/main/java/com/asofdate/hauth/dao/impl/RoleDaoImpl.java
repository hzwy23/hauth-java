package com.asofdate.hauth.dao.impl;

import com.asofdate.hauth.dao.RoleDao;
import com.asofdate.hauth.entity.RoleEntity;
import com.asofdate.hauth.entity.UserRoleEntity;
import com.asofdate.sql.SqlDefine;
import com.asofdate.utils.JoinCode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 * Created by hzwy23 on 2017/6/18.
 */
@Repository
public class RoleDaoImpl implements RoleDao {
    private final Logger logger = LoggerFactory.getLogger(RoleDaoImpl.class);
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<RoleEntity> findAll(String domainId) {
        RowMapper<RoleEntity> rowMapper = new BeanPropertyRowMapper<>(RoleEntity.class);
        return jdbcTemplate.query(SqlDefine.sys_rdbms_028, rowMapper, domainId);
    }

    @Override
    public RoleEntity getDetails(String roleId) {
        RoleEntity roleEntity = new RoleEntity();
        jdbcTemplate.query(SqlDefine.sys_rdbms_208, new RowCallbackHandler() {
            @Override
            public void processRow(ResultSet resultSet) throws SQLException {
                roleEntity.setDomain_id(resultSet.getString("domain_id"));
                roleEntity.setRole_id(resultSet.getString("role_id"));
                roleEntity.setCode_number(resultSet.getString("code_number"));
                roleEntity.setRole_name(resultSet.getString("role_name"));
                roleEntity.setDomain_desc(resultSet.getString("domain_desc"));
            }
        }, roleId);
        return roleEntity;
    }

    @Override
    public List<RoleEntity> getOther(String userId) {
        RowMapper<RoleEntity> rowMapper = new BeanPropertyRowMapper<>(RoleEntity.class);
        return jdbcTemplate.query(SqlDefine.sys_rdbms_095, rowMapper, userId);
    }

    @Override
    public List<RoleEntity> getOwner(String userId) {
        RowMapper<RoleEntity> rowMapper = new BeanPropertyRowMapper<>(RoleEntity.class);
        return jdbcTemplate.query(SqlDefine.sys_rdbms_094, rowMapper, userId);
    }

    @Transactional
    @Override
    public int auth(List<UserRoleEntity> list, String modifyUserId) {
        for (UserRoleEntity m : list) {
            String userId = m.getUserId();
            String roleId = m.getRoleId();
            String uuid = JoinCode.join(userId, roleId);
            jdbcTemplate.update(SqlDefine.sys_rdbms_096, uuid, roleId, userId, modifyUserId);
        }
        return 1;
    }

    @Transactional
    @Override
    public int batchAuth(List<UserRoleEntity> list, String modifyUserId) {
        for (UserRoleEntity m : list) {
            String userId = m.getUserId();
            String roleId = m.getRoleId();
            String uuid = JoinCode.join(userId, roleId);
            try {
                jdbcTemplate.update(SqlDefine.sys_rdbms_096, uuid, roleId, userId, modifyUserId);
            } catch (Exception e) {
                logger.info("用户[{}]已经拥有了角色[{}],无需重复授权", userId, roleId);
                logger.info(e.getMessage());
            }
        }
        return 1;
    }

    @Transactional
    @Override
    public int revoke(List<UserRoleEntity> list) {
        for (UserRoleEntity m : list) {
            String userId = m.getUserId();
            String roleId = m.getRoleId();
            String uuid = JoinCode.join(userId, roleId);
            jdbcTemplate.update(SqlDefine.sys_rdbms_097, uuid);
        }
        return 1;
    }

    @Override
    public int add(RoleEntity roleEntity) {
        return jdbcTemplate.update(SqlDefine.sys_rdbms_026,
                roleEntity.getRole_id(),
                roleEntity.getRole_name(),
                roleEntity.getCreate_user(),
                roleEntity.getRole_status_code(),
                roleEntity.getDomain_id(),
                roleEntity.getModify_user(),
                roleEntity.getCode_number());
    }

    @Override
    public int delete(List<RoleEntity> list) {
        for (RoleEntity m : list) {
            String roleId = m.getRole_id();
            String domainId = m.getDomain_id();
            jdbcTemplate.update(SqlDefine.sys_rdbms_027, roleId, domainId);
        }
        return 1;
    }

    @Override
    public int update(RoleEntity roleEntity) {
        logger.debug("{},{},{},{}",
                roleEntity.getRole_name(),
                roleEntity.getRole_status_code(),
                roleEntity.getModify_user(),
                roleEntity.getRole_id());
        return jdbcTemplate.update(SqlDefine.sys_rdbms_050,
                roleEntity.getRole_name(),
                roleEntity.getRole_status_code(),
                roleEntity.getModify_user(),
                roleEntity.getRole_id());
    }
}
