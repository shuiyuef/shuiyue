package com.cl.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.LaorenEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.LaorenView;


/**
 * 老人
 *
 * @author 
 * @email 
 * @date 2025-04-15 23:30:50
 */
public interface LaorenService extends IService<LaorenEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<LaorenView> selectListView(QueryWrapper<LaorenEntity> wrapper);
   	
   	LaorenView selectView(@Param("ew") QueryWrapper<LaorenEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,QueryWrapper<LaorenEntity> wrapper);
   	

}

