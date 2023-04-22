package com.tingfeng.mapper;

import com.tingfeng.pojo.ProductInfo;
import com.tingfeng.pojo.Yonghu;
import com.tingfeng.pojo.YonghuExample;
import com.tingfeng.pojo.vo.ProductInfoVo;
import com.tingfeng.pojo.vo.UserVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface YonghuMapper {
    int countByExample(YonghuExample example);

    int deleteByExample(YonghuExample example);

    int deleteByPrimaryKey(Integer uid);

    int insert(Yonghu record);

    int insertSelective(Yonghu record);

    List<Yonghu> selectByExample(YonghuExample example);

    Yonghu selectByPrimaryKey(Integer uid);

    int updateByExampleSelective(@Param("record") Yonghu record, @Param("example") YonghuExample example);

    int updateByExample(@Param("record") Yonghu record, @Param("example") YonghuExample example);

    int updateByPrimaryKeySelective(Yonghu record);

    int updateByPrimaryKey(Yonghu record);

    List<Yonghu> selectCondition(UserVo vo);

    int deleteBatch(String []ids);
}