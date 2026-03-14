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

import com.cl.entity.LaorenEntity;
import com.cl.entity.view.LaorenView;

import com.cl.service.LaorenService;
import com.cl.service.TokenService;
import com.cl.utils.PageUtils;
import com.cl.utils.R;
import com.cl.utils.MPUtil;
import com.cl.utils.MapUtils;
import com.cl.utils.CommonUtil;
import java.io.IOException;

/**
 * 老人
 * 后端接口
 */
@RestController
@RequestMapping("/laoren")
public class LaorenController {
    @Autowired
    private LaorenService laorenService;



	@Autowired
	private TokenService tokenService;
	
	/**
	 * 登录
	 */
	@IgnoreAuth
	@RequestMapping(value = "/login")
	public R login(String username, String password, String captcha, HttpServletRequest request) {
		LaorenEntity u = laorenService.getOne(new QueryWrapper<LaorenEntity>().eq("laorenzhanghao", username));
        if(u==null || !u.getMima().equals(password)) {
            return R.error("账号或密码不正确");
        }
		String token = tokenService.generateToken(u.getId(), username,"laoren",  "老人" );
		return R.ok().put("token", token);
	}



	/**
     * 注册
     */
	@IgnoreAuth
    @RequestMapping("/register")
    public R register(@RequestBody LaorenEntity laoren){
    	//ValidatorUtils.validateEntity(laoren);
        LaorenEntity u = laorenService.getOne(new QueryWrapper<LaorenEntity>().eq("laorenzhanghao", laoren.getLaorenzhanghao()));
        if(u!=null) {
			return R.error("注册用户已存在");
		}
		Long uId = new Date().getTime();
		laoren.setId(uId);
        laorenService.save(laoren);
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
        return R.ok().put("data", laorenService.selectView(new QueryWrapper<LaorenEntity>().eq("id", id)));
    }

    /**
     * 密码重置
     */
    @IgnoreAuth
	@RequestMapping(value = "/resetPass")
    public R resetPass(String username, HttpServletRequest request){
    	LaorenEntity u = laorenService.getOne(new QueryWrapper<LaorenEntity>().eq("laorenzhanghao", username));
    	if(u==null) {
    		return R.error("账号不存在");
    	}
        u.setMima("123456");
        laorenService.updateById(u);
        return R.ok("密码已重置为：123456");
    }




    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,LaorenEntity laoren,
                                                                                                                                            HttpServletRequest request){
                                    QueryWrapper<LaorenEntity> ew = new QueryWrapper<LaorenEntity>();
                                                                                                                                                                                                                        
        //authTable:$authTable
        
        
        PageUtils page = laorenService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, laoren), params), params));
        return R.ok().put("data", page);
    }







    /**
     * 前端列表
     */
	@IgnoreAuth
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,LaorenEntity laoren,
		HttpServletRequest request){
        QueryWrapper<LaorenEntity> ew = new QueryWrapper<LaorenEntity>();

		PageUtils page = laorenService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, laoren), params), params));
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( LaorenEntity laoren){
       	QueryWrapper<LaorenEntity> ew = new QueryWrapper<LaorenEntity>();
      	ew.allEq(MPUtil.allEQMapPre( laoren, "laoren"));
        return R.ok().put("data", laorenService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(LaorenEntity laoren){
        QueryWrapper< LaorenEntity> ew = new QueryWrapper< LaorenEntity>();
 		ew.allEq(MPUtil.allEQMapPre( laoren, "laoren"));
		LaorenView laorenView =  laorenService.selectView(ew);
		return R.ok("查询老人成功").put("data", laorenView);
    }

    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        LaorenEntity laoren = laorenService.getById(id);
		laoren = laorenService.selectView(new QueryWrapper<LaorenEntity>().eq("id", id));
        return R.ok().put("data", laoren);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        LaorenEntity laoren = laorenService.getById(id);
		laoren = laorenService.selectView(new QueryWrapper<LaorenEntity>().eq("id", id));
        return R.ok().put("data", laoren);
    }




    /**
     * 后端保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody LaorenEntity laoren, HttpServletRequest request){
        //验证字段唯一性，否则返回错误信息
        if(laorenService.count(new QueryWrapper<LaorenEntity>().eq("laorenzhanghao", laoren.getLaorenzhanghao()))>0) {
            return R.error("老人账号已存在");
        }
        //ValidatorUtils.validateEntity(laoren);
        LaorenEntity u = laorenService.getOne(new QueryWrapper<LaorenEntity>().eq("laorenzhanghao", laoren.getLaorenzhanghao()));
        if(u!=null) {
            return R.error("用户已存在");
        }
    	laoren.setId(new Date().getTime()+(long)Math.floor(Math.random()*1000));
		laoren.setId(new Date().getTime());
        laorenService.save(laoren);
        return R.ok().put("data",laoren.getId());
    }

    /**
     * 前端保存
     */
    @RequestMapping("/add")
    public R add(@RequestBody LaorenEntity laoren, HttpServletRequest request){
        if(laorenService.count(new QueryWrapper<LaorenEntity>().eq("laorenzhanghao", laoren.getLaorenzhanghao()))>0) {
            return R.error("老人账号已存在");
        }
    	laoren.setId(new Date().getTime()+(long)Math.floor(Math.random()*1000));
    	//ValidatorUtils.validateEntity(laoren);
        LaorenEntity u = laorenService.getOne(new QueryWrapper<LaorenEntity>().eq("laorenzhanghao", laoren.getLaorenzhanghao()));
        if(u!=null) {
			return R.error("用户已存在");
		}
		laoren.setId(new Date().getTime());
        laorenService.save(laoren);
        return R.ok();
    }



    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    public R update(@RequestBody LaorenEntity laoren, HttpServletRequest request){
        //ValidatorUtils.validateEntity(laoren);
        laorenService.updateById(laoren);//全部更新
        return R.ok();
    }





    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        laorenService.removeBatchByIds(Arrays.asList(ids));
        return R.ok();
    }











}
