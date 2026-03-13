package com.cl.dao;

import com.cl.entity.JiankangjianceEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.JiankangjianceView;


/**
 * 健康监测
 * 
 * @author 
 * @email 
 * @date 2025-04-15 23:30:50
 */
public interface JiankangjianceDao extends BaseMapper<JiankangjianceEntity> {
	
	List<JiankangjianceView> selectListView(@Param("ew") QueryWrapper<JiankangjianceEntity> wrapper);

	List<JiankangjianceView> selectListView(@Param("page")Page page,@Param("ew") QueryWrapper<JiankangjianceEntity> wrapper);
	
	JiankangjianceView selectView(@Param("ew") QueryWrapper<JiankangjianceEntity> wrapper);


}
