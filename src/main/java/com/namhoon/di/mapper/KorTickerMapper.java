package com.namhoon.di.mapper;

import com.namhoon.di.dto.KorTickerDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

@Mapper
public interface KorTickerMapper {
    //가장 기본 select
    List<KorTickerDTO> selectKor();

    //동적 쿼리
    List<KorTickerDTO> selectKorByCriteria(Map<String, Object> criteria);
}
