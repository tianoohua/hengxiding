package com.hengxi.spa.mapper;

import com.hengxi.spa.pojo.KB02;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface KB02Mapper {
    @Select("select * from kb02 limit 0,5")
    List<KB02> getAllKB02();
}
