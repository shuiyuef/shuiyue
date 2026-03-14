package com.cl.dao;

import com.cl.entity.CaipinxinxiEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.CaipinxinxiView;


/**
 * 菜品信息
 */
public interface CaipinxinxiDao extends BaseMapper<CaipinxinxiEntity> {
	
	List<CaipinxinxiView> selectListView(@Param("ew") QueryWrapper<CaipinxinxiEntity> wrapper);

	List<CaipinxinxiView> selectListView(@Param("page")Page page,@Param("ew") QueryWrapper<CaipinxinxiEntity> wrapper);
	
	CaipinxinxiView selectView(@Param("ew") QueryWrapper<CaipinxinxiEntity> wrapper);


    List<Map<String, Object>> selectValue(@Param("params") Map<String, Object> params,@Param("ew") QueryWrapper<CaipinxinxiEntity> wrapper);

    List<Map<String, Object>> selectTimeStatValue(@Param("params") Map<String, Object> params,@Param("ew") QueryWrapper<CaipinxinxiEntity> wrapper);

    List<Map<String, Object>> selectGroup(@Param("params") Map<String, Object> params,@Param("ew") QueryWrapper<CaipinxinxiEntity> wrapper);



}
