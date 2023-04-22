package com.tingfeng.mapper;

import com.tingfeng.pojo.Xmorder;
import com.tingfeng.pojo.XmorderExample;
import com.tingfeng.pojo.vo.OrderDetailVO;
import com.tingfeng.pojo.vo.OrderVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface XmorderMapper {
    int countByExample(XmorderExample example);

    int deleteByExample(XmorderExample example);

    int deleteByPrimaryKey(String oid);

    int insert(Xmorder record);

    int insertSelective(Xmorder record);

    List<Xmorder> selectByExample(XmorderExample example);

    Xmorder selectByPrimaryKey(String oid);

    int updateByExampleSelective(@Param("record") Xmorder record, @Param("example") XmorderExample example);

    int updateByExample(@Param("record") Xmorder record, @Param("example") XmorderExample example);

    int updateByPrimaryKeySelective(Xmorder record);

    int updateByPrimaryKey(Xmorder record);

    List<Xmorder> selectCondition(OrderVO vo);

    OrderDetailVO MultiTableCheck(int uid);
}