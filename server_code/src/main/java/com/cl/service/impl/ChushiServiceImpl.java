package com.cl.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import java.util.List;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cl.utils.PageUtils;
import com.cl.utils.Query;


import com.cl.dao.ChushiDao;
import com.cl.entity.ChushiEntity;
import com.cl.service.ChushiService;
import com.cl.entity.view.ChushiView;

@Service("chushiService")
public class ChushiServiceImpl extends ServiceImpl<ChushiDao, ChushiEntity> implements ChushiService {



    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<ChushiEntity> page = baseMapper.selectPage(new Query<ChushiEntity>(params).getPage(),new QueryWrapper<ChushiEntity>());
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, QueryWrapper<ChushiEntity> wrapper) {
        Page<ChushiEntity> page = baseMapper.selectPage(new Query<ChushiEntity>(params).getPage(),wrapper);
        Page<ChushiView> pageVo = (Page<ChushiView>)page.convert(ChushiView::new);
	    return new PageUtils(pageVo);
 	}
    
	@Override
	public List<ChushiView> selectListView(QueryWrapper<ChushiEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public ChushiView selectView(QueryWrapper<ChushiEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}


}
