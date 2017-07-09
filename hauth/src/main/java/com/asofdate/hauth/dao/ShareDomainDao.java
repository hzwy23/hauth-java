package com.asofdate.hauth.dao;

import com.asofdate.hauth.entity.ShareDomainEntity;

import java.util.List;

/**
 * Created by hzwy23 on 2017/6/19.
 */
public interface ShareDomainDao {
    List<ShareDomainEntity> findAll(String domainId);

    List<ShareDomainEntity> unShareTarget(String domainId);

    int add(ShareDomainEntity shareDomainEntity);

    int delete(List<ShareDomainEntity> list);

    int update(ShareDomainEntity shareDomainEntity);
}
