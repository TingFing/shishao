package com.tingfeng.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tingfeng.mapper.XmorderMapper;
import com.tingfeng.pojo.Xmorder;
import com.tingfeng.pojo.XmorderExample;
import com.tingfeng.pojo.vo.OrderDetailVO;
import com.tingfeng.pojo.vo.OrderVO;
import com.tingfeng.service.OrderService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    @Resource
    private XmorderMapper xmorderMapper;

    @Override
    public List<Xmorder> getAll() {
        XmorderExample example = new XmorderExample();
        List<Xmorder> list = xmorderMapper.selectByExample(example);
        for (int i = 0; i < list.size(); i++) {
            Xmorder xmorder = list.get(i);
            Date d = xmorder.getOdate();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String formattedTime = sdf.format(d);
            xmorder.setDate(formattedTime);
            System.err.println(formattedTime);
        }
        return list;
    }

    @Override
    public PageInfo splitPageVo(OrderVO vo, int pageSize) {
        PageHelper.startPage(vo.getPage(),pageSize);
        List<Xmorder> orderList = xmorderMapper.selectCondition(vo);
        for (int i = 0; i < orderList.size(); i++) {
            Xmorder xmorder = orderList.get(i);
            Date d = xmorder.getOdate();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String formattedTime = sdf.format(d);
            xmorder.setDate(formattedTime);
        }
        return new PageInfo<>(orderList);
    }

    @Override
    public List<Xmorder> selectCondition(OrderVO vo) {
        return xmorderMapper.selectCondition(vo);
    }

    @Override
    public OrderDetailVO MultiTableCheck(int uid) {
        return xmorderMapper.MultiTableCheck(uid);
    }

    @Override
    public PageInfo splitPage(int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        XmorderExample example = new XmorderExample();
        example.setOrderByClause("odate desc");
        List<Xmorder> orderList = xmorderMapper.selectByExample(example);
        for (int i = 0; i < orderList.size(); i++) {
            Xmorder xmorder = orderList.get(i);
            Date d = xmorder.getOdate();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String formattedTime = sdf.format(d);
            xmorder.setDate(formattedTime);
        }
        PageInfo<Xmorder> pageInfo = new PageInfo<>(orderList);
        return pageInfo;
    }
}
