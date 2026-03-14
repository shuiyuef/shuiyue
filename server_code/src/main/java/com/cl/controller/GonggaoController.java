package com.cl.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.*;
import jakarta.servlet.http.HttpServletRequest;

import com.cl.utils.ValidatorUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.cl.annotation.IgnoreAuth;

import com.cl.entity.GonggaoEntity;
import com.cl.entity.view.GonggaoView;

import com.cl.service.GonggaoService;
import com.cl.service.TokenService;
import com.cl.utils.PageUtils;
import com.cl.utils.R;
import com.cl.utils.MPUtil;
import com.cl.utils.MapUtils;
import com.cl.utils.CommonUtil;
import java.io.IOException;

/**
 * 健康资讯
 * 后端接口
 */
@RestController
@RequestMapping("/gonggao")
public class GonggaoController {
    @Autowired
    private GonggaoService GonggaoService;







    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,GonggaoEntity Gonggao,
                                                                                HttpServletRequest request){
                                    QueryWrapper<GonggaoEntity> ew = new QueryWrapper<GonggaoEntity>();
                                                                                                                    
        //authTable:$authTable
        
        
        PageUtils page = GonggaoService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, Gonggao), params), params));
        return R.ok().put("data", page);
    }







    /**
     * 前端列表
     */
	@IgnoreAuth
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,GonggaoEntity Gonggao,
		HttpServletRequest request){
        QueryWrapper<GonggaoEntity> ew = new QueryWrapper<GonggaoEntity>();

		PageUtils page = GonggaoService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, Gonggao), params), params));
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( GonggaoEntity Gonggao){
       	QueryWrapper<GonggaoEntity> ew = new QueryWrapper<GonggaoEntity>();
      	ew.allEq(MPUtil.allEQMapPre( Gonggao, "Gonggao"));
        return R.ok().put("data", GonggaoService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(GonggaoEntity Gonggao){
        QueryWrapper< GonggaoEntity> ew = new QueryWrapper< GonggaoEntity>();
 		ew.allEq(MPUtil.allEQMapPre( Gonggao, "Gonggao"));
		GonggaoView GonggaoView =  GonggaoService.selectView(ew);
		return R.ok("查询健康资讯成功").put("data", GonggaoView);
    }

    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        GonggaoEntity Gonggao = GonggaoService.getById(id);
		Gonggao = GonggaoService.selectView(new QueryWrapper<GonggaoEntity>().eq("id", id));
        return R.ok().put("data", Gonggao);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        GonggaoEntity Gonggao = GonggaoService.getById(id);
		Gonggao = GonggaoService.selectView(new QueryWrapper<GonggaoEntity>().eq("id", id));
        return R.ok().put("data", Gonggao);
    }




    /**
     * 后端保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody GonggaoEntity Gonggao, HttpServletRequest request){
        //ValidatorUtils.validateEntity(Gonggao);
        GonggaoService.save(Gonggao);
        return R.ok().put("data",Gonggao.getId());
    }

    /**
     * 前端保存
     */
    @RequestMapping("/add")
    public R add(@RequestBody GonggaoEntity Gonggao, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(Gonggao);
        GonggaoService.save(Gonggao);
        return R.ok();
    }



    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    public R update(@RequestBody GonggaoEntity Gonggao, HttpServletRequest request){
        //ValidatorUtils.validateEntity(Gonggao);
        
        GonggaoService.updateById(Gonggao);//全部更新
        return R.ok();
    }





    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        GonggaoService.removeBatchByIds(Arrays.asList(ids));
        return R.ok();
    }











}
