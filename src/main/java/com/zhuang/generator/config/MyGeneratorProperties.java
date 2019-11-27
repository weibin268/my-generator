package com.zhuang.generator.config;

import java.io.*;
import java.util.Properties;

public class MyGeneratorProperties {

    public final static String DEFAULT_CONFIG_FILE_PATH = "config/my-generator.properties";

    private Properties properties;
    public final static String JDBC_DRIVER = "my.generator.jdbc-driver";
    public final static String JDBC_URL = "my.generator.jdbc-url";
    public final static String JDBC_USERNAME = "my.generator.jdbc-username";
    public final static String JDBC_PASSWORD = "my.generator.jdbc-password";
    private final static String TEMPLATE_PATH = "my.generator.template-path";
    private final static String BASE_PACKAGE = "my.generator.base-package";
    private final static String OUTPUT_PATH = "my.generator.output-path";
    private final static String MODULE_NAME = "my.generator.module-name";
    private final static String AUTHOR_NAME = "my.generator.author-name";
    private final static String TABLE_NAMES = "my.generator.table-names";

    public MyGeneratorProperties() {
        this(DEFAULT_CONFIG_FILE_PATH);
    }

    public MyGeneratorProperties(String configFilePath) {
        InputStream inputStream = this.getClass().getClassLoader().getResourceAsStream(configFilePath);
        loadProperties(inputStream);
    }

    public MyGeneratorProperties(File file){
        try {
            loadProperties(new FileInputStream(file));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }

    private void loadProperties(InputStream inputStream) {
        try {
            properties = new Properties();
            properties.load(inputStream);
        } catch (IOException e) {
            throw new RuntimeException("加载“my-generator.properties”配置文件出错！");
        } finally {
            if (inputStream != null) {
                try {
                    inputStream.close();
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
        }
    }

    public String getJdbcDriver(){
        return properties.getProperty(JDBC_DRIVER);
    }

    public String getJdbcUrl(){
        return properties.getProperty(JDBC_URL);
    }

    public String getJdbcUsername(){
        return properties.getProperty(JDBC_USERNAME);
    }

    public String getJdbcPassword(){
        return properties.getProperty(JDBC_PASSWORD);
    }

    public String getTemplatePath() {
        return properties.getProperty(TEMPLATE_PATH);
    }

    public String getBasePackage() {
        return properties.getProperty(BASE_PACKAGE);
    }

    public String getOutputPath() {
        return properties.getProperty(OUTPUT_PATH);
    }

    public String getModuleName() {
        return properties.getProperty(MODULE_NAME);
    }

    public String getAuthorName() {
        return properties.getProperty(AUTHOR_NAME);
    }

    public String getTableNames() {
        return properties.getProperty(TABLE_NAMES);
    }

}
