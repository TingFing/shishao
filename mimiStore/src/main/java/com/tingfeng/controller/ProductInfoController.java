package com.tingfeng.controller;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageInfo;
import com.tingfeng.pojo.ProductInfo;
import com.tingfeng.pojo.vo.ProductInfoVo;
import com.tingfeng.service.ProductInfoService;
import com.tingfeng.utils.FileNameUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/prod")
public class ProductInfoController {

    private static final int PAGE_SIZE=5;

    String saveFileName="";

    @Autowired
    ProductInfoService productInfoService;

    @RequestMapping("/getAll")
    public String getAll(HttpServletRequest request){
        List<ProductInfo> list = productInfoService.getAll();
        request.setAttribute("list",list);
        return "product";
    }

    @RequestMapping("/split")
    public String split(HttpServletRequest request){
        PageInfo info=null;
        ProductInfoVo vo = (ProductInfoVo) request.getSession().getAttribute("prodVo");
        if (vo !=null) {
            info = productInfoService.splitPageVo(vo,PAGE_SIZE);
            request.getSession().removeAttribute("prodVo");
        }else {
            info = productInfoService.splitPage(1, PAGE_SIZE);
        }
        request.setAttribute("info",info);
        return "product";
    }

    @RequestMapping("/ajaxSplit")
    @ResponseBody
    public void ajaxSplit(ProductInfoVo vo, HttpSession session){
        //取得当前page参数的页面的数据
        PageInfo info = productInfoService.splitPageVo(vo,PAGE_SIZE);
        session.setAttribute("info",info);
    }

    @ResponseBody
    @RequestMapping("/condition")
    public void condition(ProductInfoVo vo,HttpSession session){
        System.out.println(vo);
        List<ProductInfo> list = productInfoService.selectCondition(vo);
        for (ProductInfo p: list) {
            System.out.println(p);
        }
        session.setAttribute("list",list);
    }

    //异步ajax文件上传
    @ResponseBody
    @RequestMapping("/ajaxImg")
    public Object ajaxImg(MultipartFile pimage,HttpServletRequest request){

        //提取生成文件名UUID+上传图片的后缀.jpg.png
        saveFileName = FileNameUtil.getUUIDFileName()+FileNameUtil.getFileType(pimage.getOriginalFilename());
        //得到项目中图片存储的路径
        String path = request.getServletContext().getRealPath("/image_big");
        //转存 E: idea_workspace\mimissm2\image_big\adfdasfdsaf.jpg
        try {
            pimage.transferTo(new File(path+File.separator+saveFileName));
        } catch (IOException e) {
            e.printStackTrace();
        }

        //返回客户端JSON对象，封装图片的路径
        JSONObject object = new JSONObject();
        object.put("imgurl",saveFileName);
        return object.toString();
    }

    @RequestMapping("/save")
    public String save(ProductInfo info,HttpServletRequest request){
        info.setpImage(saveFileName);
        info.setpDate(new Date());
        int num = -1;
        try {
            num = productInfoService.save(info);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (num>0) {
            request.setAttribute("msg","成功！");
        }else{
            request.setAttribute("msg","失败！");
        }

        //清空saveFileName变量中的内容,为了下次增加或修改的异步ajax的上传处理
        saveFileName="";
        //增加成功后应该重新访问数据库，所以跳转到分页显示的action上

        return "forward:/prod/split.action";
    }

    @RequestMapping("/one")
    public String one(int pid, Model model,ProductInfoVo vo,HttpSession session){
        ProductInfo info = productInfoService.getById(pid);
        model.addAttribute("prod",info);
        session.setAttribute("prodVo",vo);
        return "update";
    }

    @RequestMapping("/update")
    public String update(ProductInfo info,HttpServletRequest request){
        if (!saveFileName.equals("")) {
            info.setpImage(saveFileName);
        }
        int num=-1;
        try {
            num = productInfoService.update(info);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (num>0) {
            request.setAttribute("msg","更新成功！");
        }else {
            request.setAttribute("msg","更新失败！");
        }

        //处理完更新后，saveFileName里可能有数据
        saveFileName="";
        return "forward:/prod/split.action";
    }

    @RequestMapping("/delete")
    public String delete(int pid,HttpServletRequest request,ProductInfoVo vo){
        int num = -1;
        try {
            num = productInfoService.delete(pid);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (num>0) {
            request.setAttribute("msg","删除成功！");
            request.getSession().setAttribute("deleteProdVo",vo);
        }else {
            request.setAttribute("msg","删除失败！");
        }
        return "forward:/prod/deleteAjaxSplit.action";
    }

    @RequestMapping(value = "/deleteAjaxSplit",produces = "text/html;charset=UTF-8")
    @ResponseBody
    public Object deleteAjaxSplit(HttpServletRequest request){
        PageInfo info = null;
        ProductInfoVo vo = (ProductInfoVo) request.getSession().getAttribute("deleteProdVo");
        if (vo!=null) {
            info = productInfoService.splitPageVo(vo,PAGE_SIZE);
        }else {
            info = productInfoService.splitPage(1,PAGE_SIZE);
        }
        request.getSession().setAttribute("info",info);
        return request.getAttribute("msg");
    }

    @RequestMapping("/deleteBatch")
    public String deleteBatch(String pids,HttpServletRequest request){
        String []ps = pids.split(",");
        try {
            int num = productInfoService.deleteBatch(ps);
            if (num>0) {
                request.setAttribute("msg","批量删除成功！");
            }else {
                request.setAttribute("msg","批量删除失败！");
            }
        } catch (Exception e) {
            request.setAttribute("msg","商品不可删除！");
        }
        return "forward:/prod/deleteAjaxSplit.action";
    }

}
