package com.cl.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import java.util.List;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cl.utils.PageUtils;
import com.cl.utils.Query;


import com.cl.dao.CaipinxinxiDao;
import com.cl.entity.CaipinxinxiEntity;
import com.cl.service.CaipinxinxiService;
import com.cl.entity.view.CaipinxinxiView;

@Service("caipinxinxiService")
public class CaipinxinxiServiceImpl extends ServiceImpl<CaipinxinxiDao, CaipinxinxiEntity> implements CaipinxinxiService {



    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<CaipinxinxiEntity> page = baseMapper.selectPage(new Query<CaipinxinxiEntity>(params).getPage(),new QueryWrapper<CaipinxinxiEntity>());
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, QueryWrapper<CaipinxinxiEntity> wrapper) {
        Page<CaipinxinxiEntity> page = baseMapper.selectPage(new Query<CaipinxinxiEntity>(params).getPage(),wrapper);
        Page<CaipinxinxiView> pageVo = (Page<CaipinxinxiView>)page.convert(CaipinxinxiView::new);
	    return new PageUtils(pageVo);
 	}
    
	@Override
	public List<CaipinxinxiView> selectListView(QueryWrapper<CaipinxinxiEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public CaipinxinxiView selectView(QueryWrapper<CaipinxinxiEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}

    @Override
    public List<Map<String, Object>> selectValue(Map<String, Object> params, QueryWrapper<CaipinxinxiEntity> wrapper) {
        return baseMapper.selectValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, QueryWrapper<CaipinxinxiEntity> wrapper) {
        return baseMapper.selectTimeStatValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectGroup(Map<String, Object> params, QueryWrapper<CaipinxinxiEntity> wrapper) {
        return baseMapper.selectGroup(params, wrapper);
    }




}
