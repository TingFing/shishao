package com.tingfeng.service;

import com.github.pagehelper.PageInfo;
import com.tingfeng.pojo.Yonghu;
import com.tingfeng.pojo.vo.UserVo;

import java.util.List;

public interface YonghuService {

    List<Yonghu> getAll();

    PageInfo splitPage(int pageNum,int pageSize);

    int update(Yonghu user);

    Yonghu getById(int id);

    List<Yonghu> selectCondition(UserVo userVo);

    PageInfo splitPageVo(UserVo vo, int pageSize);

    int delete(int uid);

    int deleteBatch(String []ids);
}
