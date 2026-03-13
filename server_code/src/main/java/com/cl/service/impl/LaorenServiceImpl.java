package com.cl.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import java.util.List;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cl.utils.PageUtils;
import com.cl.utils.Query;


import com.cl.dao.LaorenDao;
import com.cl.entity.LaorenEntity;
import com.cl.service.LaorenService;
import com.cl.entity.view.LaorenView;

@Service("laorenService")
public class LaorenServiceImpl extends ServiceImpl<LaorenDao, LaorenEntity> implements LaorenService {



    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<LaorenEntity> page = baseMapper.selectPage(new Query<LaorenEntity>(params).getPage(),new QueryWrapper<LaorenEntity>());
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, QueryWrapper<LaorenEntity> wrapper) {
        Page<LaorenEntity> page = baseMapper.selectPage(new Query<LaorenEntity>(params).getPage(),wrapper);
        Page<LaorenView> pageVo = (Page<LaorenView>)page.convert(LaorenView::new);
	    return new PageUtils(pageVo);
 	}
    
	@Override
	public List<LaorenView> selectListView(QueryWrapper<LaorenEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public LaorenView selectView(QueryWrapper<LaorenEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}


}
