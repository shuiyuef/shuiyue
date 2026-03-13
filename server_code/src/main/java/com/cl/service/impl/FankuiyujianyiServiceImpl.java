package com.cl.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import java.util.List;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cl.utils.PageUtils;
import com.cl.utils.Query;


import com.cl.dao.FankuiyujianyiDao;
import com.cl.entity.FankuiyujianyiEntity;
import com.cl.service.FankuiyujianyiService;
import com.cl.entity.view.FankuiyujianyiView;

@Service("fankuiyujianyiService")
public class FankuiyujianyiServiceImpl extends ServiceImpl<FankuiyujianyiDao, FankuiyujianyiEntity> implements FankuiyujianyiService {



    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<FankuiyujianyiEntity> page = baseMapper.selectPage(new Query<FankuiyujianyiEntity>(params).getPage(),new QueryWrapper<FankuiyujianyiEntity>());
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, QueryWrapper<FankuiyujianyiEntity> wrapper) {
        Page<FankuiyujianyiEntity> page = baseMapper.selectPage(new Query<FankuiyujianyiEntity>(params).getPage(),wrapper);
        Page<FankuiyujianyiView> pageVo = (Page<FankuiyujianyiView>)page.convert(FankuiyujianyiView::new);
	    return new PageUtils(pageVo);
 	}
    
	@Override
	public List<FankuiyujianyiView> selectListView(QueryWrapper<FankuiyujianyiEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public FankuiyujianyiView selectView(QueryWrapper<FankuiyujianyiEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}


}
