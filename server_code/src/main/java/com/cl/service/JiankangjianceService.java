package com.cl.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.JiankangjianceEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.JiankangjianceView;


/**
 * 健康监测
 */
public interface JiankangjianceService extends IService<JiankangjianceEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<JiankangjianceView> selectListView(QueryWrapper<JiankangjianceEntity> wrapper);
   	
   	JiankangjianceView selectView(@Param("ew") QueryWrapper<JiankangjianceEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,QueryWrapper<JiankangjianceEntity> wrapper);
   	

}

