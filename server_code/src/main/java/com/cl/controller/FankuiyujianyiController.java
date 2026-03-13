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

import com.cl.entity.FankuiyujianyiEntity;
import com.cl.entity.view.FankuiyujianyiView;

import com.cl.service.FankuiyujianyiService;
import com.cl.service.TokenService;
import com.cl.utils.PageUtils;
import com.cl.utils.R;
import com.cl.utils.MPUtil;
import com.cl.utils.MapUtils;
import com.cl.utils.CommonUtil;
import java.io.IOException;

/**
 * 反馈与建议
 * 后端接口
 * @author 
 * @email 
 * @date 2025-04-15 23:30:50
 */
@RestController
@RequestMapping("/fankuiyujianyi")
public class FankuiyujianyiController {
    @Autowired
    private FankuiyujianyiService fankuiyujianyiService;







    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,FankuiyujianyiEntity fankuiyujianyi,
                                                                                                                    HttpServletRequest request){
                    String tableName = request.getSession().getAttribute("tableName").toString();
                                                                                                                                if(tableName.equals("laoren")) {
                    fankuiyujianyi.setLaorenzhanghao((String)request.getSession().getAttribute("username"));
                                    }
                                                                                                                                                    QueryWrapper<FankuiyujianyiEntity> ew = new QueryWrapper<FankuiyujianyiEntity>();
                                                                                                                                                                                
        //authTable:是
        
        
        PageUtils page = fankuiyujianyiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, fankuiyujianyi), params), params));
        return R.ok().put("data", page);
    }







    /**
     * 前端列表
     */
	@IgnoreAuth
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,FankuiyujianyiEntity fankuiyujianyi,
		HttpServletRequest request){
        QueryWrapper<FankuiyujianyiEntity> ew = new QueryWrapper<FankuiyujianyiEntity>();

		PageUtils page = fankuiyujianyiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, fankuiyujianyi), params), params));
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( FankuiyujianyiEntity fankuiyujianyi){
       	QueryWrapper<FankuiyujianyiEntity> ew = new QueryWrapper<FankuiyujianyiEntity>();
      	ew.allEq(MPUtil.allEQMapPre( fankuiyujianyi, "fankuiyujianyi"));
        return R.ok().put("data", fankuiyujianyiService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(FankuiyujianyiEntity fankuiyujianyi){
        QueryWrapper< FankuiyujianyiEntity> ew = new QueryWrapper< FankuiyujianyiEntity>();
 		ew.allEq(MPUtil.allEQMapPre( fankuiyujianyi, "fankuiyujianyi"));
		FankuiyujianyiView fankuiyujianyiView =  fankuiyujianyiService.selectView(ew);
		return R.ok("查询反馈与建议成功").put("data", fankuiyujianyiView);
    }

    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        FankuiyujianyiEntity fankuiyujianyi = fankuiyujianyiService.getById(id);
		fankuiyujianyi = fankuiyujianyiService.selectView(new QueryWrapper<FankuiyujianyiEntity>().eq("id", id));
        return R.ok().put("data", fankuiyujianyi);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        FankuiyujianyiEntity fankuiyujianyi = fankuiyujianyiService.getById(id);
		fankuiyujianyi = fankuiyujianyiService.selectView(new QueryWrapper<FankuiyujianyiEntity>().eq("id", id));
        return R.ok().put("data", fankuiyujianyi);
    }




    /**
     * 后端保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody FankuiyujianyiEntity fankuiyujianyi, HttpServletRequest request){
        //ValidatorUtils.validateEntity(fankuiyujianyi);
        fankuiyujianyiService.save(fankuiyujianyi);
        return R.ok().put("data",fankuiyujianyi.getId());
    }

    /**
     * 前端保存
     */
    @RequestMapping("/add")
    public R add(@RequestBody FankuiyujianyiEntity fankuiyujianyi, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(fankuiyujianyi);
        fankuiyujianyiService.save(fankuiyujianyi);
        return R.ok();
    }



    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    public R update(@RequestBody FankuiyujianyiEntity fankuiyujianyi, HttpServletRequest request){
        //ValidatorUtils.validateEntity(fankuiyujianyi);
        fankuiyujianyiService.updateById(fankuiyujianyi);//全部更新
        return R.ok();
    }





    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        fankuiyujianyiService.removeBatchByIds(Arrays.asList(ids));
        return R.ok();
    }











}
