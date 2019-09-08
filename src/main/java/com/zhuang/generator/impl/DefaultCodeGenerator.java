package com.zhuang.generator.impl;

import com.zhuang.data.orm.mapping.EntityMapping;
import com.zhuang.generator.CodeGenerator;
import com.zhuang.generator.util.FileUtils;
import com.zhuang.generator.util.FreeMarkerUtils;
import com.zhuang.generator.util.PathUtils;
import com.zhuang.generator.util.StringUtils;

import java.util.Map;

public class DefaultCodeGenerator extends CodeGenerator {

    @Override
    public void generate(String templateName, Map dataModel) {
        EntityMapping entityMapping = (EntityMapping) dataModel.get(DATA_MODEL_KEY_ENTITY);
        StringUtils stringUtils = (StringUtils) dataModel.get(DATA_MODEL_KEY_STRING_UTILS);
        String packagePath = PathUtils.getPathByPackage(getBasePackage());
        String javaPath = "/src/main/java";
        String viewPath = "/src/main/resources/views";
        String filePath = templateName;
        if (templateName.equalsIgnoreCase("entity.java.ftl")) {
            filePath = PathUtils.combine(javaPath, packagePath, getModuleName(), "entity", entityMapping.getEntityName()) + ".java";
        } else if (templateName.equalsIgnoreCase("service.java.ftl")) {
            filePath = PathUtils.combine(javaPath, packagePath, getModuleName(), "service", entityMapping.getEntityName()) + "Service.java";
        } else if (templateName.equalsIgnoreCase("controller.java.ftl")) {
            filePath = PathUtils.combine(javaPath, packagePath, getModuleName(), "controller", entityMapping.getEntityName()) + "Controller.java";
        } else if (templateName.equalsIgnoreCase("mapper.xml.ftl")) {
            filePath = PathUtils.combine(javaPath, packagePath, getModuleName(), "mapper", entityMapping.getEntityName()) + ".xml";
        } else if (templateName.equalsIgnoreCase("main.html.ftl")) {
            filePath = PathUtils.combine(viewPath, getModuleName(), stringUtils.toLowerCaseFirstChar(entityMapping.getEntityName()), stringUtils.toLowerCaseFirstChar(entityMapping.getEntityName())) + "_main.html";
        } else if (templateName.equalsIgnoreCase("edit.html.ftl")) {
            filePath = PathUtils.combine(viewPath, getModuleName(), stringUtils.toLowerCaseFirstChar(entityMapping.getEntityName()), stringUtils.toLowerCaseFirstChar(entityMapping.getEntityName())) + "_edit.html";
        }
        String fullFilePath = PathUtils.combine(getOutputPath(), filePath);
        System.out.println(fullFilePath);
        String fileContent = FreeMarkerUtils.getOutput(getTemplatePath(), templateName, dataModel);
        FileUtils.writeText(fullFilePath, fileContent);
    }

}
