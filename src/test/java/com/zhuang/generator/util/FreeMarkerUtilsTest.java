package com.zhuang.generator.util;

import com.zhuang.data.orm.mapping.EntityMapping;
import org.junit.Test;

import java.util.HashMap;
import java.util.Map;

public class FreeMarkerUtilsTest {

    @Test
    public void getOutput() {
        Map dataModel = new HashMap();
        Map params = new HashMap();
        params.put("basePackage","zhuang.upms.modules.core");
        EntityMapping entityMapping = new EntityMapping("sys|_user");
        dataModel.put("entity", entityMapping);
        dataModel.put("stringUtils", new StringUtils());
        dataModel.put("params",params);
        //String tempalteName="test.ftl";
        //String tempalteName="entity.java.ftl";
        String tempalteName="entity.java.ftl";
        //String tempalteName = "controller.java.ftl";
        //String tempalteName = "service.java.ftl";
        System.out.println(FreeMarkerUtils.getOutput(FreeMarkerUtilsTest.class.getResource("/code-templates").getPath(), tempalteName, dataModel));
    }
}