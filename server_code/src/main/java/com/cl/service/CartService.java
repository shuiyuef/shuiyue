package com.cl.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.CartEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.CartView;


/**
 * 购物车
 *
 * @author 
 * @email 
 * @date 2025-04-15 23:30:50
 */
public interface CartService extends IService<CartEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<CartView> selectListView(QueryWrapper<CartEntity> wrapper);
   	
   	CartView selectView(@Param("ew") QueryWrapper<CartEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,QueryWrapper<CartEntity> wrapper);
   	

}

