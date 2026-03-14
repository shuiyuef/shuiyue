package com.cl.entity.view;

import com.cl.entity.GonggaoEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;
import java.io.Serializable;

/**
 * 社区供餐公告视图类
 */
@TableName("gonggao")
public class GonggaoView extends GonggaoEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    public GonggaoView(){
    }

    public GonggaoView(GonggaoEntity gonggaoEntity){
        try {
            BeanUtils.copyProperties(this, gonggaoEntity);
        } catch (IllegalAccessException | InvocationTargetException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }
}