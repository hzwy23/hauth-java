package com.asofdate.hauth.dao.impl;

import com.asofdate.hauth.dao.OrgDao;
import com.asofdate.hauth.dao.UserDao;
import com.asofdate.hauth.dto.UserDTO;
import com.asofdate.hauth.entity.OrgEntity;
import com.asofdate.hauth.entity.UserEntity;
import com.asofdate.sql.SqlDefine;
import com.asofdate.utils.CryptoAES;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by hzwy23 on 2017/6/18.
 */
@Repository
public class UserDaoImpl implements UserDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private OrgDao orgDao;

    @Override
    public List<UserEntity> findAll(String domainid) {
        RowMapper<UserEntity> rowMapper = new BeanPropertyRowMapper<>(UserEntity.class);
        return jdbcTemplate.query(SqlDefine.sys_rdbms_017, rowMapper, domainid);
    }

    @Override
    public List<UserEntity> findAll(String domainId, String orgId, String statusCd) {
        List<UserEntity> list = findAll(domainId);
        if ("0".equals(statusCd) || "1".equals(statusCd)) {
            for (int i = 0; i < list.size(); i++) {
                if (!statusCd.equals(list.get(i).getStatus_cd())) {
                    list.remove(i);
                    i--;
                }
            }
        }
        if (orgId != null && !orgId.isEmpty()) {
            List<OrgEntity> orgList = orgDao.findSub(domainId, orgId);
            Set<String> set = new HashSet<>();
            for (OrgEntity om : orgList) {
                set.add(om.getOrg_id());
            }
            set.add(orgId);
            for (int i = 0; i < list.size(); i++) {
                if (!set.contains(list.get(i).getOrg_unit_id())) {
                    list.remove(i);
                    i--;
                }
            }
        }
        return list;
    }

    @Transactional
    @Override
    public int add(UserEntity userEntity) {
        jdbcTemplate.update(SqlDefine.sys_rdbms_018,
                userEntity.getUser_id(),
                userEntity.getUser_name(),
                userEntity.getCreate_user(),
                userEntity.getUser_email(),
                userEntity.getUser_phone(),
                userEntity.getOrg_unit_id(),
                userEntity.getModify_user());
        String password = CryptoAES.aesEncrypt(userEntity.getUser_passwd());
        return jdbcTemplate.update(SqlDefine.sys_rdbms_019,
                userEntity.getUser_id(), password, 0);
    }

    @Transactional
    @Override
    public int delete(List<UserEntity> list) {
        for (UserEntity m : list) {
            jdbcTemplate.update(SqlDefine.sys_rdbms_007,
                    m.getUser_id(),
                    m.getOrg_unit_id());
        }
        return 1;
    }

    @Override
    public int update(UserEntity userEntity) {
        return jdbcTemplate.update(SqlDefine.sys_rdbms_021,
                userEntity.getUser_name(),
                userEntity.getUser_phone(),
                userEntity.getUser_email(),
                userEntity.getModify_user(),
                userEntity.getOrg_unit_id(),
                userEntity.getUser_id());
    }

    @Override
    public int changePassword(UserDTO m) {
        String userId = m.getUserId();
        String newPd = m.getNewPasswd();
        String passwd = CryptoAES.aesEncrypt(newPd);
        return jdbcTemplate.update(SqlDefine.sys_rdbms_015,
                passwd, userId);
    }

    @Override
    public int changeStatus(String userId, String status) {
        return jdbcTemplate.update(SqlDefine.sys_rdbms_016, status, userId);
    }
}
