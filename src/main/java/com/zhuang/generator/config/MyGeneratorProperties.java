package com.zhuang.generator.config;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class MyGeneratorProperties {

    public final static String DEFAULT_CONFIG_FILE_PATH = "config/my-generator.properties";

    private Properties properties;
    private final static String TEMPLATE_PATH = "my.generator.template-path";
    private final static String BASE_PACKAGE = "my.generator.base-package";
    private final static String OUTPUT_PATH = "my.generator.output-path";
    private final static String MODULE_NAME = "my.generator.module-name";
    private final static String AUTHOR_NAME = "my.generator.author-name";

    public MyGeneratorProperties() {
        this(DEFAULT_CONFIG_FILE_PATH);
    }

    public MyGeneratorProperties(String configFilePath) {
        InputStream inputStream = null;
        try {
            inputStream = this.getClass().getClassLoader().getResourceAsStream(configFilePath);
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

}