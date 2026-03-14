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
 * 老人
 * 数据库通用操作实体类（普通增删改查）
 */
@TableName("laoren")
public class LaorenEntity<T> implements Serializable {
	private static final long serialVersionUID = 1L;

	public LaorenEntity() {
	}

	public LaorenEntity(T t) {
		try {
			BeanUtils.copyProperties(this, t);
		} catch (IllegalAccessException | InvocationTargetException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 主键id
	 */
	@TableId
	private Long id;
	/**
	 * 老人账号
	 */
	private String laorenzhanghao;
	/**
	 * 密码
	 */
	private String mima;
	/**
	 * 老人姓名
	 */
	private String laorenxingming;
	/**
	 * 性别
	 */
	private String xingbie;
	/**
	 * 头像
	 */
	private String touxiang;
	/**
	 * 年龄
	 */
	private Integer nianling;
	/**
	 * 饮食禁忌
	 */
	private String yinshijinji;
	/**
	 * 偏好口味
	 */
	private String pianhaokouwei;
	/**
	 * 余额
	 */
	private Double money;

	/**
	 * 手机号 (新增对接前端字段)
	 */
	private String shouji;

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

	public void setLaorenzhanghao(String laorenzhanghao) {
		this.laorenzhanghao = laorenzhanghao;
	}
	public String getLaorenzhanghao() {
		return laorenzhanghao;
	}

	public void setMima(String mima) {
		this.mima = mima;
	}
	public String getMima() {
		return mima;
	}

	public void setLaorenxingming(String laorenxingming) {
		this.laorenxingming = laorenxingming;
	}
	public String getLaorenxingming() {
		return laorenxingming;
	}

	public void setXingbie(String xingbie) {
		this.xingbie = xingbie;
	}
	public String getXingbie() {
		return xingbie;
	}

	public void setTouxiang(String touxiang) {
		this.touxiang = touxiang;
	}
	public String getTouxiang() {
		return touxiang;
	}

	public void setNianling(Integer nianling) {
		this.nianling = nianling;
	}
	public Integer getNianling() {
		return nianling;
	}

	public void setYinshijinji(String yinshijinji) {
		this.yinshijinji = yinshijinji;
	}
	public String getYinshijinji() {
		return yinshijinji;
	}

	public void setPianhaokouwei(String pianhaokouwei) {
		this.pianhaokouwei = pianhaokouwei;
	}
	public String getPianhaokouwei() {
		return pianhaokouwei;
	}

	public void setMoney(Double money) {
		this.money = money;
	}
	public Double getMoney() {
		return money;
	}

	// ====== 新增手机号的 Get/Set 方法 ======
	public void setShouji(String shouji) {
		this.shouji = shouji;
	}
	public String getShouji() {
		return shouji;
	}
}