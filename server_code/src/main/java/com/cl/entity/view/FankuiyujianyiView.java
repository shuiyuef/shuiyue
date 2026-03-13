package com.cl.entity.view;

import com.cl.entity.FankuiyujianyiEntity;

import com.baomidou.mybatisplus.annotation.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;

import java.io.Serializable;
import com.cl.utils.EncryptUtil;
 

/**
 * 反馈与建议
 * 后端返回视图实体辅助类   
 * （通常后端关联的表或者自定义的字段需要返回使用）
 * @author 
 * @email 
 * @date 2025-04-15 23:30:50
 */
@TableName("fankuiyujianyi")
public class FankuiyujianyiView  extends FankuiyujianyiEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	public FankuiyujianyiView(){
	}
 
 	public FankuiyujianyiView(FankuiyujianyiEntity fankuiyujianyiEntity){
 	try {
			BeanUtils.copyProperties(this, fankuiyujianyiEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 		
	}



}
