package com.cl.dao;

import com.cl.entity.ChushiEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.ChushiView;


/**
 * 厨师
 */
public interface ChushiDao extends BaseMapper<ChushiEntity> {
	
	List<ChushiView> selectListView(@Param("ew") QueryWrapper<ChushiEntity> wrapper);

	List<ChushiView> selectListView(@Param("page")Page page,@Param("ew") QueryWrapper<ChushiEntity> wrapper);
	
	ChushiView selectView(@Param("ew") QueryWrapper<ChushiEntity> wrapper);


}
