package com.tingfeng.controller;

import com.tingfeng.pojo.Admin;
import com.tingfeng.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    AdminService adminService;

    @RequestMapping("/login")
    public String login(String name, String pwd, HttpServletRequest request){
        Admin admin = adminService.login(name, pwd);
        if (admin!=null) {
            System.out.println("------------------------------------");
            request.setAttribute("admin",admin);
            System.out.println(admin.getaName());
            return "main";
        }else {
            request.setAttribute("errmsg","用户名或密码不正确");
            return "login";
        }
    }

    @RequestMapping("/regist")
    public String regist(Admin admin,HttpServletRequest request){
        int rows = 0;
        try {
            rows = adminService.insert(admin);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (rows==1) {
            request.setAttribute("msg","成功！");
        }else{
            request.setAttribute("msg","失败！");
        }
        return "login";
    }
}
