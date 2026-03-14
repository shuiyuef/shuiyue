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

import com.cl.entity.ChushiEntity;
import com.cl.entity.view.ChushiView;

import com.cl.service.ChushiService;
import com.cl.service.TokenService;
import com.cl.utils.PageUtils;
import com.cl.utils.R;
import com.cl.utils.MPUtil;
import com.cl.utils.MapUtils;
import com.cl.utils.CommonUtil;
import java.io.IOException;

/**
 * 厨师
 * 后端接口
 */
@RestController
@RequestMapping("/chushi")
public class ChushiController {
    @Autowired
    private ChushiService chushiService;



	@Autowired
	private TokenService tokenService;
	
	/**
	 * 登录
	 */
	@IgnoreAuth
	@RequestMapping(value = "/login")
	public R login(String username, String password, String captcha, HttpServletRequest request) {
		ChushiEntity u = chushiService.getOne(new QueryWrapper<ChushiEntity>().eq("gonghao", username));
        if(u==null || !u.getMima().equals(password)) {
            return R.error("账号或密码不正确");
        }
		String token = tokenService.generateToken(u.getId(), username,"chushi",  "厨师" );
		return R.ok().put("token", token);
	}



	/**
     * 注册
     */
	@IgnoreAuth
    @RequestMapping("/register")
    public R register(@RequestBody ChushiEntity chushi){
    	//ValidatorUtils.validateEntity(chushi);
        ChushiEntity u = chushiService.getOne(new QueryWrapper<ChushiEntity>().eq("gonghao", chushi.getGonghao()));
        if(u!=null) {
			return R.error("注册用户已存在");
		}
		Long uId = new Date().getTime();
		chushi.setId(uId);
        chushiService.save(chushi);
        return R.ok();
    }


	/**
	 * 退出
	 */
	@RequestMapping("/logout")
	public R logout(HttpServletRequest request) {
		request.getSession().invalidate();
		return R.ok("退出成功");
	}

	/**
     * 获取用户的session用户信息
     */
    @RequestMapping("/session")
    public R getCurrUser(HttpServletRequest request){
    	Long id = (Long)request.getSession().getAttribute("userId");
        return R.ok().put("data", chushiService.selectView(new QueryWrapper<ChushiEntity>().eq("id", id)));
    }

    /**
     * 密码重置
     */
    @IgnoreAuth
	@RequestMapping(value = "/resetPass")
    public R resetPass(String username, HttpServletRequest request){
    	ChushiEntity u = chushiService.getOne(new QueryWrapper<ChushiEntity>().eq("gonghao", username));
    	if(u==null) {
    		return R.error("账号不存在");
    	}
        u.setMima("123456");
        chushiService.updateById(u);
        return R.ok("密码已重置为：123456");
    }




    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,ChushiEntity chushi,
                                                                                                        HttpServletRequest request){
                                    QueryWrapper<ChushiEntity> ew = new QueryWrapper<ChushiEntity>();
                                                                                                                                                            
        //authTable:$authTable
        
        
        PageUtils page = chushiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, chushi), params), params));
        return R.ok().put("data", page);
    }







    /**
     * 前端列表
     */
	@IgnoreAuth
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,ChushiEntity chushi,
		HttpServletRequest request){
        QueryWrapper<ChushiEntity> ew = new QueryWrapper<ChushiEntity>();

		PageUtils page = chushiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, chushi), params), params));
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( ChushiEntity chushi){
       	QueryWrapper<ChushiEntity> ew = new QueryWrapper<ChushiEntity>();
      	ew.allEq(MPUtil.allEQMapPre( chushi, "chushi"));
        return R.ok().put("data", chushiService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(ChushiEntity chushi){
        QueryWrapper< ChushiEntity> ew = new QueryWrapper< ChushiEntity>();
 		ew.allEq(MPUtil.allEQMapPre( chushi, "chushi"));
		ChushiView chushiView =  chushiService.selectView(ew);
		return R.ok("查询厨师成功").put("data", chushiView);
    }

    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        ChushiEntity chushi = chushiService.getById(id);
		chushi = chushiService.selectView(new QueryWrapper<ChushiEntity>().eq("id", id));
        return R.ok().put("data", chushi);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        ChushiEntity chushi = chushiService.getById(id);
		chushi = chushiService.selectView(new QueryWrapper<ChushiEntity>().eq("id", id));
        return R.ok().put("data", chushi);
    }




    /**
     * 后端保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody ChushiEntity chushi, HttpServletRequest request){
        //验证字段唯一性，否则返回错误信息
        if(chushiService.count(new QueryWrapper<ChushiEntity>().eq("gonghao", chushi.getGonghao()))>0) {
            return R.error("工号已存在");
        }
        //ValidatorUtils.validateEntity(chushi);
        ChushiEntity u = chushiService.getOne(new QueryWrapper<ChushiEntity>().eq("gonghao", chushi.getGonghao()));
        if(u!=null) {
            return R.error("用户已存在");
        }
    	chushi.setId(new Date().getTime()+(long)Math.floor(Math.random()*1000));
		chushi.setId(new Date().getTime());
        chushiService.save(chushi);
        return R.ok().put("data",chushi.getId());
    }

    /**
     * 前端保存
     */
    @RequestMapping("/add")
    public R add(@RequestBody ChushiEntity chushi, HttpServletRequest request){
        if(chushiService.count(new QueryWrapper<ChushiEntity>().eq("gonghao", chushi.getGonghao()))>0) {
            return R.error("工号已存在");
        }
    	chushi.setId(new Date().getTime()+(long)Math.floor(Math.random()*1000));
    	//ValidatorUtils.validateEntity(chushi);
        ChushiEntity u = chushiService.getOne(new QueryWrapper<ChushiEntity>().eq("gonghao", chushi.getGonghao()));
        if(u!=null) {
			return R.error("用户已存在");
		}
		chushi.setId(new Date().getTime());
        chushiService.save(chushi);
        return R.ok();
    }



    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    public R update(@RequestBody ChushiEntity chushi, HttpServletRequest request){
        //ValidatorUtils.validateEntity(chushi);
        chushiService.updateById(chushi);//全部更新
        return R.ok();
    }





    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        chushiService.removeBatchByIds(Arrays.asList(ids));
        return R.ok();
    }











}
