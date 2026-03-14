package com.cl.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.DiscusscaipinxinxiEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.DiscusscaipinxinxiView;


/**
 * 菜品信息评论表
 */
public interface DiscusscaipinxinxiService extends IService<DiscusscaipinxinxiEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<DiscusscaipinxinxiView> selectListView(QueryWrapper<DiscusscaipinxinxiEntity> wrapper);
   	
   	DiscusscaipinxinxiView selectView(@Param("ew") QueryWrapper<DiscusscaipinxinxiEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,QueryWrapper<DiscusscaipinxinxiEntity> wrapper);
   	

}

