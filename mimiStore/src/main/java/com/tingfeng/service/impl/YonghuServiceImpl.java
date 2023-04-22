package com.tingfeng.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tingfeng.mapper.YonghuMapper;
import com.tingfeng.pojo.ProductInfo;
import com.tingfeng.pojo.Yonghu;
import com.tingfeng.pojo.YonghuExample;
import com.tingfeng.pojo.vo.UserVo;
import com.tingfeng.service.YonghuService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class YonghuServiceImpl implements YonghuService {

    @Resource
    private YonghuMapper yonghuMapper;

    @Override
    public List<Yonghu> getAll() {
        return yonghuMapper.selectByExample(new YonghuExample());
    }

    @Override
    public PageInfo splitPage(int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);

        YonghuExample example = new YonghuExample();
        example.setOrderByClause("uid desc");
        List<Yonghu> userSplitList = yonghuMapper.selectByExample(example);
        PageInfo<Yonghu> userPageInfo = new PageInfo<>(userSplitList);
        return userPageInfo;
    }

    @Override
    public int update(Yonghu user) {
        return yonghuMapper.updateByPrimaryKeySelective(user);
    }

    @Override
    public Yonghu getById(int id) {
        return yonghuMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Yonghu> selectCondition(UserVo userVo) {
        return yonghuMapper.selectCondition(userVo);
    }

    @Override
    public PageInfo splitPageVo(UserVo vo, int pageSize) {
        PageHelper.startPage(vo.getPage(),pageSize);
        List<Yonghu> list = yonghuMapper.selectCondition(vo);
        return new PageInfo<>(list);
    }

    @Override
    public int delete(int uid) {
        return yonghuMapper.deleteByPrimaryKey(uid);
    }

    @Override
    public int deleteBatch(String[] ids) {
        return yonghuMapper.deleteBatch(ids);
    }
}
