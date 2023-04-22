package com.tingfeng.service;

import com.github.pagehelper.PageInfo;
import com.tingfeng.pojo.ProductInfo;
import com.tingfeng.pojo.vo.ProductInfoVo;

import java.util.List;

public interface ProductInfoService {

    //查所有商品
    List<ProductInfo> getAll();

    PageInfo splitPage(int pageNum,int pageSize);

    int save(ProductInfo info);

    ProductInfo getById(int pid);

    int update(ProductInfo info);

    int delete(int pid);

    int deleteBatch(String []ids);

    List<ProductInfo> selectCondition(ProductInfoVo vo);

    PageInfo splitPageVo(ProductInfoVo vo,int pageSize);
}
