package com.cl.entity.view;

import com.cl.entity.ChushiEntity;

import com.baomidou.mybatisplus.annotation.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;

import java.io.Serializable;
import com.cl.utils.EncryptUtil;
 

/**
 * 厨师
 * 后端返回视图实体辅助类   
 * （通常后端关联的表或者自定义的字段需要返回使用）
 */
@TableName("chushi")
public class ChushiView  extends ChushiEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	public ChushiView(){
	}
 
 	public ChushiView(ChushiEntity chushiEntity){
 	try {
			BeanUtils.copyProperties(this, chushiEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 		
	}



}
