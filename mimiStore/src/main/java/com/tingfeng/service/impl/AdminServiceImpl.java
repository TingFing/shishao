package com.tingfeng.service.impl;

import com.tingfeng.mapper.AdminMapper;
import com.tingfeng.pojo.Admin;
import com.tingfeng.pojo.AdminExample;
import com.tingfeng.service.AdminService;
import com.tingfeng.utils.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;
    @Override
    public Admin login(String name, String pwd) {
        //创建adminException对象，用来fengzhuang
        AdminExample adminExample = new AdminExample();
        //添加用户查询条件
        /**
         * select * from admin where a_name = ‘admin’
         */
        adminExample.createCriteria().andANameEqualTo(name);
        List<Admin> list = adminMapper.selectByExample(adminExample);
        System.out.println(list.get(0));
        if (list.size()>0) {
            //获取用户
            Admin admin = list.get(0);
            String mipwd = MD5Util.getMD5(pwd);
            System.err.println(mipwd);
            if (mipwd.equals(admin.getaPass())) {
                return admin;
            }
        }
        return null;
    }

    @Override
    public int insert(Admin admin) {
        String pwd = admin.getaPass();
        String Md5Pwd = MD5Util.getMD5(pwd);
        admin.setaPass(Md5Pwd);
        return adminMapper.insert(admin);
    }
}
