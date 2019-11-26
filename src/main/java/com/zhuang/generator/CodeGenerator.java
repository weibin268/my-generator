package com.zhuang.generator;

import com.zhuang.data.jdbc.JdbcUtils;
import com.zhuang.data.orm.mapping.EntityMapping;
import com.zhuang.generator.config.MyGeneratorProperties;
import com.zhuang.generator.util.DateUtils;
import com.zhuang.generator.util.PathUtils;
import com.zhuang.generator.util.StringUtils;

import java.io.File;
import java.sql.Connection;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public abstract class CodeGenerator {

    public static final String DATA_MODEL_KEY_ENTITY = "entity";
    public static final String DATA_MODEL_KEY_STRING_UTILS = "stringUtils";
    public static final String DATA_MODEL_KEY_PARAMS = "params";
    public static final String DATA_MODEL_KEY_PARAMS_BASE_PACKAGE = "basePackage";
    public static final String DATA_MODEL_KEY_PARAMS_MODULE_NAME = "moduleName";
    public static final String DATA_MODEL_KEY_PARAMS_AUTHOR_NAME = "authorName";
    public static final String DATA_MODEL_KEY_PARAMS_NOW_DATE_TIME = "nowDateTime";
    public static final String DATA_MODEL_KEY_PARAMS_NOW_DATE = "nowDate";

    private MyGeneratorProperties myGeneratorProperties;
    private Connection connection;
    private String templatePath;
    private String outputPath;
    private String basePackage;
    private String moduleName;
    private String authorName;

    public Connection getConnection() {
        if (connection != null) return connection;
        return JdbcUtils.getConnection();
    }

    public void setConnection(Connection connection) {
        this.connection = connection;
    }

    public String getTemplatePath() {
        if (templatePath != null) return templatePath;
        String templatePath = myGeneratorProperties.getTemplatePath();
        if (templatePath != null && !templatePath.isEmpty()) {
            return PathUtils.getAbsolutePath(templatePath);
        } else {
            return this.getClass().getResource("/code-templates").getPath();
        }
    }

    public void setTemplatePath(String templatePath) {
        this.templatePath = templatePath;
    }

    public String getOutputPath() {
        if (outputPath != null) return outputPath;
        String outputPath = myGeneratorProperties.getOutputPath();
        if (outputPath != null && !outputPath.isEmpty()) {
            return PathUtils.getAbsolutePath(outputPath);
        } else {
            return this.getClass().getResource("/code-output").getPath();
        }
    }

    public void setOutputPath(String outputPath) {
        this.outputPath = outputPath;
    }

    public String getBasePackage() {
        if (basePackage != null) return basePackage;
        return myGeneratorProperties.getBasePackage();
    }

    public void setBasePackage(String basePackage) {
        this.basePackage = basePackage;
    }

    public String getModuleName() {
        if (moduleName != null) return moduleName;
        return myGeneratorProperties.getModuleName();
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public String getAuthorName() {
        if (authorName != null) return authorName;
        return myGeneratorProperties.getAuthorName();
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public CodeGenerator() {
        myGeneratorProperties = new MyGeneratorProperties();
    }

    public void generate() {
        generate(myGeneratorProperties.getTableNames());
    }

    public void generate(String[] tableNames) {
        for (String tableName : tableNames) {
            Map dataModel = new HashMap();
            Map params = new HashMap();
            params.put(DATA_MODEL_KEY_PARAMS_BASE_PACKAGE, getBasePackage());
            params.put(DATA_MODEL_KEY_PARAMS_MODULE_NAME, getModuleName());
            params.put(DATA_MODEL_KEY_PARAMS_AUTHOR_NAME, getAuthorName());
            params.put(DATA_MODEL_KEY_PARAMS_NOW_DATE_TIME, DateUtils.parseString(new Date()));
            params.put(DATA_MODEL_KEY_PARAMS_NOW_DATE, DateUtils.parseString(new Date()).substring(0, 10));
            EntityMapping entityMapping = new EntityMapping(tableName, getConnection());
            dataModel.put(DATA_MODEL_KEY_ENTITY, entityMapping);
            dataModel.put(DATA_MODEL_KEY_STRING_UTILS, new StringUtils());
            dataModel.put(DATA_MODEL_KEY_PARAMS, params);
            File templateDir = new File(getTemplatePath());
            File[] templateFiles = templateDir.listFiles();
            for (File templateFile : templateFiles) {
                generate(templateFile.getName(), dataModel);
            }
        }
    }

    public void generate(String tableNames) {
        generate(tableNames.split(","));
    }

    public abstract void generate(String templateName, Map dataModel);

}
