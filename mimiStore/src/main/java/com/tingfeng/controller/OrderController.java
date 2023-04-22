package com.tingfeng.controller;

import com.github.pagehelper.PageInfo;
import com.tingfeng.pojo.Xmorder;
import com.tingfeng.pojo.vo.OrderDetailVO;
import com.tingfeng.pojo.vo.OrderVO;
import com.tingfeng.service.OrderService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/order")
public class OrderController {

    private static final int PAGE_SIZE=5;

    @Resource
    private OrderService orderService;

    @RequestMapping("/getAll")
    public String getAll(HttpServletRequest request){
        List<Xmorder> orderList = orderService.getAll();
        request.setAttribute("orderList",orderList);
        return "order";
    }

    @RequestMapping("/split")
    public String split(HttpServletRequest request){
        /*PageInfo info=null;
        ProductInfoVo vo = (ProductInfoVo) request.getSession().getAttribute("prodVo");
        if (vo !=null) {
            info = productInfoService.splitPageVo(vo,PAGE_SIZE);
            request.getSession().removeAttribute("prodVo");
        }else {
            info = productInfoService.splitPage(1, PAGE_SIZE);
        }*/
        PageInfo orderList = orderService.splitPage(1, PAGE_SIZE);
        request.setAttribute("orderList",orderList);
        return "order";
    }

    @RequestMapping("/ajaxSplit")
    @ResponseBody
    public void ajaxSplit(OrderVO vo, HttpSession session){
        //取得当前page参数的页面的数据
        PageInfo orderList = orderService.splitPageVo(vo,PAGE_SIZE);
        session.setAttribute("orderList",orderList);
    }

    @ResponseBody
    @RequestMapping("/condition")
    public void condition(OrderVO vo,HttpSession session){
        System.out.println(vo);
        List<Xmorder> list = orderService.selectCondition(vo);
        for (Xmorder p: list) {
            System.out.println(p);
        }
        session.setAttribute("list",list);
    }

    @RequestMapping("/MultiTableCheck")
    @ResponseBody
    public OrderDetailVO MultiTableCheck(int uid, HttpSession session){
        OrderDetailVO orderDetailVO = orderService.MultiTableCheck(uid);
        System.err.println(orderDetailVO);
        session.setAttribute("orderDetailVO",orderDetailVO);
        return orderDetailVO;
    }
}
