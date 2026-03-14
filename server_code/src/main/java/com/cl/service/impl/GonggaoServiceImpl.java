package com.cl.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import java.util.List;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cl.utils.PageUtils;
import com.cl.utils.Query;


import com.cl.dao.GonggaoDao;
import com.cl.entity.GonggaoEntity;
import com.cl.service.GonggaoService;
import com.cl.entity.view.GonggaoView;

@Service("GonggaoService")
public class GonggaoServiceImpl extends ServiceImpl<GonggaoDao, GonggaoEntity> implements GonggaoService {



    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<GonggaoEntity> page = baseMapper.selectPage(new Query<GonggaoEntity>(params).getPage(),new QueryWrapper<GonggaoEntity>());
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, QueryWrapper<GonggaoEntity> wrapper) {
        Page<GonggaoEntity> page = baseMapper.selectPage(new Query<GonggaoEntity>(params).getPage(),wrapper);
        Page<GonggaoView> pageVo = (Page<GonggaoView>)page.convert(GonggaoView::new);
	    return new PageUtils(pageVo);
 	}
    
	@Override
	public List<GonggaoView> selectListView(QueryWrapper<GonggaoEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public GonggaoView selectView(QueryWrapper<GonggaoEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}


}
