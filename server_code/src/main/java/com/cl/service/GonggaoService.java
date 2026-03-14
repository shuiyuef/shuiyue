package com.cl.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.GonggaoEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.GonggaoView;


/**
 * 健康资讯
 */
public interface GonggaoService extends IService<GonggaoEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<GonggaoView> selectListView(QueryWrapper<GonggaoEntity> wrapper);
   	
   	GonggaoView selectView(@Param("ew") QueryWrapper<GonggaoEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,QueryWrapper<GonggaoEntity> wrapper);
   	

}

