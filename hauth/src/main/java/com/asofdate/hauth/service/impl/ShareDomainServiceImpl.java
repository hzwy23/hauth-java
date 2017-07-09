package com.asofdate.hauth.service.impl;

import com.asofdate.hauth.dao.ShareDomainDao;
import com.asofdate.hauth.entity.ShareDomainEntity;
import com.asofdate.hauth.service.ShareDomainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by hzwy23 on 2017/6/19.
 */
@Service
public class ShareDomainServiceImpl implements ShareDomainService {
    @Autowired
    private ShareDomainDao shareDomainDao;

    @Override
    public List<ShareDomainEntity> findAll(String domainId) {
        return shareDomainDao.findAll(domainId);
    }

    @Override
    public List<ShareDomainEntity> unShareTarget(String domainId) {
        return shareDomainDao.unShareTarget(domainId);
    }

    @Override
    public int add(ShareDomainEntity shareDomainEntity) {
        return shareDomainDao.add(shareDomainEntity);
    }

    @Override
    public int delete(List<ShareDomainEntity> list) {
        return shareDomainDao.delete(list);
    }

    @Override
    public int update(ShareDomainEntity shareDomainEntity) {
        return shareDomainDao.update(shareDomainEntity);
    }
}
