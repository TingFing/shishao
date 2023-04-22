package com.tingfeng.controller;

import com.github.pagehelper.PageInfo;
import com.tingfeng.pojo.Yonghu;
import com.tingfeng.pojo.vo.UserVo;
import com.tingfeng.service.YonghuService;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UsersController {

    private static final int PAGE_SIZE=5;

    @Resource
    private YonghuService yonghuService;

    @RequestMapping("/getAll")
    public String getAll(HttpServletRequest request){
        List<Yonghu> userList = yonghuService.getAll();
        request.setAttribute("userList",userList);
        return "user";
    }

    @RequestMapping("/split")
    public String split(HttpServletRequest request){
        PageInfo userInfo=null;
        UserVo vo = (UserVo) request.getSession().getAttribute("userVo");
        if (vo !=null) {
            userInfo = yonghuService.splitPageVo(vo,PAGE_SIZE);
            request.getSession().removeAttribute("userVo");
        }else {
            userInfo = yonghuService.splitPage(1, PAGE_SIZE);
        }
        request.setAttribute("userInfo",userInfo);
        return "user";
    }

    @ResponseBody
    @RequestMapping("/ajaxSplit")
    public void ajaxSplit(UserVo vo, HttpSession session){
        //取得当前page参数的页面的数据
        PageInfo userInfo = yonghuService.splitPageVo(vo,PAGE_SIZE);
        session.setAttribute("userInfo",userInfo);


    }

    @RequestMapping("/one")
    public String one(@Param("uid") int uid, HttpSession session,UserVo vo){
        Yonghu info = yonghuService.getById(uid);
        session.setAttribute("prod",info);
        session.setAttribute("userVo",vo);
        return "userUpdate";
    }

    @RequestMapping("/update")
    public String update(Yonghu user, HttpServletRequest request){


        int rows = 0;
        try {
            rows = yonghuService.update(user);
            System.err.println(rows);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (rows!=1) {
            request.setAttribute("msg","更新失败！");
        }else {
            request.setAttribute("msg","更新成功！");
        }
        return "forward:/user/split.action";
    }

    @ResponseBody
    @RequestMapping("/condition")
    public void condition(UserVo vo, HttpSession session){
        System.out.println(vo);
        List<Yonghu> userInfo = yonghuService.selectCondition(vo);
        for (Yonghu userVo: userInfo) {
            System.out.println(userVo);
        }
        session.setAttribute("userInfo",userInfo);
    }

    @RequestMapping("/delete")
    public String delete(int uid,HttpServletRequest request,UserVo vo){
        int num = -1;
        try {
            num = yonghuService.delete(uid);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (num>0) {
            request.setAttribute("msg","删除成功！");
            request.getSession().setAttribute("deleteUserVo",vo);
        }else {
            request.setAttribute("msg","删除失败！");
        }
        return "forward:/user/deleteAjaxSplit.action";
    }

    @RequestMapping(value = "/deleteAjaxSplit",produces = "text/html;charset=UTF-8")
    @ResponseBody
    public Object deleteAjaxSplit(HttpServletRequest request){
        PageInfo info = null;
        UserVo vo = (UserVo) request.getSession().getAttribute("deleteUserVo");
        if (vo!=null) {
            info = yonghuService.splitPageVo(vo,PAGE_SIZE);
        }else {
            info = yonghuService.splitPage(1,PAGE_SIZE);
        }
        request.getSession().setAttribute("userInfo",info);
        return request.getAttribute("msg");
    }

    @RequestMapping("/deleteBatch")
    public String deleteBatch(String uids,HttpServletRequest request){
        String []ps = uids.split(",");
        try {
            int num = yonghuService.deleteBatch(ps);
            if (num>0) {
                request.setAttribute("msg","批量删除成功！");
            }else {
                request.setAttribute("msg","批量删除失败！");
            }
        } catch (Exception e) {
            request.setAttribute("msg","商品不可删除！");
        }
        return "forward:/user/deleteAjaxSplit.action";
    }
}
