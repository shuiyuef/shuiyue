package com.cl.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.ChushiEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.ChushiView;


/**
 * 厨师
 */
public interface ChushiService extends IService<ChushiEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<ChushiView> selectListView(QueryWrapper<ChushiEntity> wrapper);
   	
   	ChushiView selectView(@Param("ew") QueryWrapper<ChushiEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,QueryWrapper<ChushiEntity> wrapper);
   	

}

