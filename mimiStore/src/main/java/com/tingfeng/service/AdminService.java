package com.tingfeng.service;

import com.tingfeng.pojo.Admin;

public interface AdminService {
    Admin login(String name,String pwd);

    int insert(Admin admin);
}
