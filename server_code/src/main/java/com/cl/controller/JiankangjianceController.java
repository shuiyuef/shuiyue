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

import com.cl.entity.JiankangjianceEntity;
import com.cl.entity.view.JiankangjianceView;

import com.cl.service.JiankangjianceService;
import com.cl.service.TokenService;
import com.cl.utils.PageUtils;
import com.cl.utils.R;
import com.cl.utils.MPUtil;
import com.cl.utils.MapUtils;
import com.cl.utils.CommonUtil;
import java.io.IOException;

/**
 * 健康监测
 * 后端接口
 */
@RestController
@RequestMapping("/jiankangjiance")
public class JiankangjianceController {
    @Autowired
    private JiankangjianceService jiankangjianceService;







    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,JiankangjianceEntity jiankangjiance,
                                                                                                                                                                                                        HttpServletRequest request){
                    String tableName = request.getSession().getAttribute("tableName").toString();
                                            if(tableName.equals("laoren")) {
                    jiankangjiance.setLaorenzhanghao((String)request.getSession().getAttribute("username"));
                                    }
                                                                                                                                                                                                                                                                                                                                                                                                                                            QueryWrapper<JiankangjianceEntity> ew = new QueryWrapper<JiankangjianceEntity>();
                                                                                                                                                                                                                                                                                                                            
        //authTable:是
        
        
        PageUtils page = jiankangjianceService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, jiankangjiance), params), params));
        return R.ok().put("data", page);
    }







    /**
     * 前端列表
     */
	@IgnoreAuth
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,JiankangjianceEntity jiankangjiance,
		HttpServletRequest request){
        QueryWrapper<JiankangjianceEntity> ew = new QueryWrapper<JiankangjianceEntity>();

		PageUtils page = jiankangjianceService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, jiankangjiance), params), params));
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( JiankangjianceEntity jiankangjiance){
       	QueryWrapper<JiankangjianceEntity> ew = new QueryWrapper<JiankangjianceEntity>();
      	ew.allEq(MPUtil.allEQMapPre( jiankangjiance, "jiankangjiance"));
        return R.ok().put("data", jiankangjianceService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(JiankangjianceEntity jiankangjiance){
        QueryWrapper< JiankangjianceEntity> ew = new QueryWrapper< JiankangjianceEntity>();
 		ew.allEq(MPUtil.allEQMapPre( jiankangjiance, "jiankangjiance"));
		JiankangjianceView jiankangjianceView =  jiankangjianceService.selectView(ew);
		return R.ok("查询健康监测成功").put("data", jiankangjianceView);
    }

    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        JiankangjianceEntity jiankangjiance = jiankangjianceService.getById(id);
		jiankangjiance = jiankangjianceService.selectView(new QueryWrapper<JiankangjianceEntity>().eq("id", id));
        return R.ok().put("data", jiankangjiance);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        JiankangjianceEntity jiankangjiance = jiankangjianceService.getById(id);
		jiankangjiance = jiankangjianceService.selectView(new QueryWrapper<JiankangjianceEntity>().eq("id", id));
        return R.ok().put("data", jiankangjiance);
    }




    /**
     * 后端保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody JiankangjianceEntity jiankangjiance, HttpServletRequest request){
        //ValidatorUtils.validateEntity(jiankangjiance);
        jiankangjianceService.save(jiankangjiance);
        return R.ok().put("data",jiankangjiance.getId());
    }

    /**
     * 前端保存
     */
    @RequestMapping("/add")
    public R add(@RequestBody JiankangjianceEntity jiankangjiance, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(jiankangjiance);
        jiankangjianceService.save(jiankangjiance);
        return R.ok();
    }



    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    public R update(@RequestBody JiankangjianceEntity jiankangjiance, HttpServletRequest request){
        //ValidatorUtils.validateEntity(jiankangjiance);
        jiankangjianceService.updateById(jiankangjiance);//全部更新
        return R.ok();
    }





    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        jiankangjianceService.removeBatchByIds(Arrays.asList(ids));
        return R.ok();
    }











}
