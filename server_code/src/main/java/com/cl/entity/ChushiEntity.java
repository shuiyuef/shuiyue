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
 * 厨师
 * 数据库通用操作实体类（普通增删改查）
 */
@TableName("chushi")
public class ChushiEntity<T> implements Serializable {
	private static final long serialVersionUID = 1L;

	public ChushiEntity() {
	}

	public ChushiEntity(T t) {
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
	 * 工号
	 */
	private String gonghao;
	/**
	 * 密码
	 */
	private String mima;
	/**
	 * 厨师姓名
	 */
	private String chushixingming;
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

	public void setGonghao(String gonghao) {
		this.gonghao = gonghao;
	}
	public String getGonghao() {
		return gonghao;
	}

	public void setMima(String mima) {
		this.mima = mima;
	}
	public String getMima() {
		return mima;
	}

	public void setChushixingming(String chushixingming) {
		this.chushixingming = chushixingming;
	}
	public String getChushixingming() {
		return chushixingming;
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

	// ====== 新增手机号的 Get/Set 方法 ======
	public void setShouji(String shouji) {
		this.shouji = shouji;
	}
	public String getShouji() {
		return shouji;
	}
}