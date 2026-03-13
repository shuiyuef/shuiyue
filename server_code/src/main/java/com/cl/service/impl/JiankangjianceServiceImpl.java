package com.cl.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import java.util.List;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cl.utils.PageUtils;
import com.cl.utils.Query;


import com.cl.dao.JiankangjianceDao;
import com.cl.entity.JiankangjianceEntity;
import com.cl.service.JiankangjianceService;
import com.cl.entity.view.JiankangjianceView;

@Service("jiankangjianceService")
public class JiankangjianceServiceImpl extends ServiceImpl<JiankangjianceDao, JiankangjianceEntity> implements JiankangjianceService {



    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<JiankangjianceEntity> page = baseMapper.selectPage(new Query<JiankangjianceEntity>(params).getPage(),new QueryWrapper<JiankangjianceEntity>());
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, QueryWrapper<JiankangjianceEntity> wrapper) {
        Page<JiankangjianceEntity> page = baseMapper.selectPage(new Query<JiankangjianceEntity>(params).getPage(),wrapper);
        Page<JiankangjianceView> pageVo = (Page<JiankangjianceView>)page.convert(JiankangjianceView::new);
	    return new PageUtils(pageVo);
 	}
    
	@Override
	public List<JiankangjianceView> selectListView(QueryWrapper<JiankangjianceEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public JiankangjianceView selectView(QueryWrapper<JiankangjianceEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}


}
