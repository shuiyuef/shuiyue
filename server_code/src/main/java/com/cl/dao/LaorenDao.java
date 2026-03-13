package com.cl.dao;

import com.cl.entity.LaorenEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.LaorenView;


/**
 * 老人
 * 
 * @author 
 * @email 
 * @date 2025-04-15 23:30:50
 */
public interface LaorenDao extends BaseMapper<LaorenEntity> {
	
	List<LaorenView> selectListView(@Param("ew") QueryWrapper<LaorenEntity> wrapper);

	List<LaorenView> selectListView(@Param("page")Page page,@Param("ew") QueryWrapper<LaorenEntity> wrapper);
	
	LaorenView selectView(@Param("ew") QueryWrapper<LaorenEntity> wrapper);


}
