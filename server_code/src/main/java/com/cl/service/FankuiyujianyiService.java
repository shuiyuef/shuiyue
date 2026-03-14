package com.cl.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.FankuiyujianyiEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.FankuiyujianyiView;


/**
 * 反馈与建议
 */
public interface FankuiyujianyiService extends IService<FankuiyujianyiEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<FankuiyujianyiView> selectListView(QueryWrapper<FankuiyujianyiEntity> wrapper);
   	
   	FankuiyujianyiView selectView(@Param("ew") QueryWrapper<FankuiyujianyiEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,QueryWrapper<FankuiyujianyiEntity> wrapper);
   	

}

