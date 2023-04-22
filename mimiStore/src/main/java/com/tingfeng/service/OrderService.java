package com.tingfeng.service;

import com.github.pagehelper.PageInfo;
import com.tingfeng.pojo.Xmorder;
import com.tingfeng.pojo.vo.OrderDetailVO;
import com.tingfeng.pojo.vo.OrderVO;

import java.util.List;

public interface OrderService {

    List<Xmorder> getAll();

    PageInfo splitPage(int pageNum,int pageSize);

    PageInfo splitPageVo(OrderVO vo, int pageSize);

    List<Xmorder> selectCondition(OrderVO vo);

    OrderDetailVO MultiTableCheck(int uid);
}
