package com.cl.dao;

import com.cl.entity.FankuiyujianyiEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.FankuiyujianyiView;


/**
 * 反馈与建议
 * 
 * @author 
 * @email 
 * @date 2025-04-15 23:30:50
 */
public interface FankuiyujianyiDao extends BaseMapper<FankuiyujianyiEntity> {
	
	List<FankuiyujianyiView> selectListView(@Param("ew") QueryWrapper<FankuiyujianyiEntity> wrapper);

	List<FankuiyujianyiView> selectListView(@Param("page")Page page,@Param("ew") QueryWrapper<FankuiyujianyiEntity> wrapper);
	
	FankuiyujianyiView selectView(@Param("ew") QueryWrapper<FankuiyujianyiEntity> wrapper);


}
