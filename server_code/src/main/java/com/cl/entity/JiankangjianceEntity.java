package com.cl.entity;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.lang.reflect.InvocationTargetException;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.baomidou.mybatisplus.annotation.*;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.beanutils.BeanUtils;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.TableField;


/**
 * 健康监测
 * 数据库通用操作实体类（普通增删改查）
 */
@TableName("jiankangjiance")
public class JiankangjianceEntity<T> implements Serializable {
	private static final long serialVersionUID = 1L;


	public JiankangjianceEntity() {
		
	}
	
	public JiankangjianceEntity(T t) {
		try {
			BeanUtils.copyProperties(this, t);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 主键id
	 */
	@TableId(type = IdType.AUTO)
	private Long id;
	/**
	 * 老人账号
	 */
					
	private String laorenzhanghao;
	
	/**
	 * 老人姓名
	 */
					
	private String laorenxingming;
	
	/**
	 * 头像
	 */
					
	private String touxiang;
	
	/**
	 * 血压
	 */
					
	private String xueya;
	
	/**
	 * 血糖
	 */
					
	private String xuetang;
	
	/**
	 * 心率
	 */
					
	private String xinlv;
	
	/**
	 * 皮肤状况
	 */
					
	private String pifuzhuangkuang;
	
	/**
	 * 精神状态
	 */
					
	private String jingshenzhuangtai;
	
	/**
	 * 基础疾病
	 */
					
	private String jichujibing;
	
	/**
	 * 饮食限制
	 */
					
	private String yinshixianzhi;
	
	/**
	 * 登记时间
	 */
				
	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat 		
	private Date dengjishijian;
	
	/**
	 * 评估内容
	 */
					
	private String pingguneirong;
	
	/**
	 * 健康报告
	 */
					
	private String jiankangbaogao;
	
	/**
	 * 健康建议
	 */
					
	private String jiankangjianyi;
	

	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat
	private Date addtime;

	public Date getAddtime() {
		return addtime;
	}
	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	/**
	 * 设置：老人账号
	 */
	public void setLaorenzhanghao(String laorenzhanghao) {
		this.laorenzhanghao = laorenzhanghao;
	}
	/**
	 * 获取：老人账号
	 */
	public String getLaorenzhanghao() {
		return laorenzhanghao;
	}
	/**
	 * 设置：老人姓名
	 */
	public void setLaorenxingming(String laorenxingming) {
		this.laorenxingming = laorenxingming;
	}
	/**
	 * 获取：老人姓名
	 */
	public String getLaorenxingming() {
		return laorenxingming;
	}
	/**
	 * 设置：头像
	 */
	public void setTouxiang(String touxiang) {
		this.touxiang = touxiang;
	}
	/**
	 * 获取：头像
	 */
	public String getTouxiang() {
		return touxiang;
	}
	/**
	 * 设置：血压
	 */
	public void setXueya(String xueya) {
		this.xueya = xueya;
	}
	/**
	 * 获取：血压
	 */
	public String getXueya() {
		return xueya;
	}
	/**
	 * 设置：血糖
	 */
	public void setXuetang(String xuetang) {
		this.xuetang = xuetang;
	}
	/**
	 * 获取：血糖
	 */
	public String getXuetang() {
		return xuetang;
	}
	/**
	 * 设置：心率
	 */
	public void setXinlv(String xinlv) {
		this.xinlv = xinlv;
	}
	/**
	 * 获取：心率
	 */
	public String getXinlv() {
		return xinlv;
	}
	/**
	 * 设置：皮肤状况
	 */
	public void setPifuzhuangkuang(String pifuzhuangkuang) {
		this.pifuzhuangkuang = pifuzhuangkuang;
	}
	/**
	 * 获取：皮肤状况
	 */
	public String getPifuzhuangkuang() {
		return pifuzhuangkuang;
	}
	/**
	 * 设置：精神状态
	 */
	public void setJingshenzhuangtai(String jingshenzhuangtai) {
		this.jingshenzhuangtai = jingshenzhuangtai;
	}
	/**
	 * 获取：精神状态
	 */
	public String getJingshenzhuangtai() {
		return jingshenzhuangtai;
	}
	/**
	 * 设置：基础疾病
	 */
	public void setJichujibing(String jichujibing) {
		this.jichujibing = jichujibing;
	}
	/**
	 * 获取：基础疾病
	 */
	public String getJichujibing() {
		return jichujibing;
	}
	/**
	 * 设置：饮食限制
	 */
	public void setYinshixianzhi(String yinshixianzhi) {
		this.yinshixianzhi = yinshixianzhi;
	}
	/**
	 * 获取：饮食限制
	 */
	public String getYinshixianzhi() {
		return yinshixianzhi;
	}
	/**
	 * 设置：登记时间
	 */
	public void setDengjishijian(Date dengjishijian) {
		this.dengjishijian = dengjishijian;
	}
	/**
	 * 获取：登记时间
	 */
	public Date getDengjishijian() {
		return dengjishijian;
	}
	/**
	 * 设置：评估内容
	 */
	public void setPingguneirong(String pingguneirong) {
		this.pingguneirong = pingguneirong;
	}
	/**
	 * 获取：评估内容
	 */
	public String getPingguneirong() {
		return pingguneirong;
	}
	/**
	 * 设置：健康报告
	 */
	public void setJiankangbaogao(String jiankangbaogao) {
		this.jiankangbaogao = jiankangbaogao;
	}
	/**
	 * 获取：健康报告
	 */
	public String getJiankangbaogao() {
		return jiankangbaogao;
	}
	/**
	 * 设置：健康建议
	 */
	public void setJiankangjianyi(String jiankangjianyi) {
		this.jiankangjianyi = jiankangjianyi;
	}
	/**
	 * 获取：健康建议
	 */
	public String getJiankangjianyi() {
		return jiankangjianyi;
	}

}
