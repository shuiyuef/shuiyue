package com.cl.dao;

import com.cl.entity.GonggaoEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.GonggaoView;


/**
 * 健康资讯
 */
public interface GonggaoDao extends BaseMapper<GonggaoEntity> {
	
	List<GonggaoView> selectListView(@Param("ew") QueryWrapper<GonggaoEntity> wrapper);

	List<GonggaoView> selectListView(@Param("page")Page page,@Param("ew") QueryWrapper<GonggaoEntity> wrapper);
	
	GonggaoView selectView(@Param("ew") QueryWrapper<GonggaoEntity> wrapper);


}
