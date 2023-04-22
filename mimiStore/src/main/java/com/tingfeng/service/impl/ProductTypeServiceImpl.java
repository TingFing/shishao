package com.tingfeng.service.impl;

import com.tingfeng.mapper.ProductTypeMapper;
import com.tingfeng.pojo.ProductType;
import com.tingfeng.pojo.ProductTypeExample;
import com.tingfeng.service.ProductTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("ProductTypeServiceImpl")
public class ProductTypeServiceImpl implements ProductTypeService {

    @Autowired
    ProductTypeMapper productTypeMapper;
    @Override
    public List<ProductType> getAll() {
        return productTypeMapper.selectByExample(new ProductTypeExample());
    }
}
