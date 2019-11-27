package com.zhuang.generator.util;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateExceptionHandler;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.ui.freemarker.SpringTemplateLoader;

import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.util.Map;

public class FreeMarkerUtils {

    public static Configuration getConfiguration(String templatePath) {
        try {
            Configuration configuration = new Configuration(Configuration.VERSION_2_3_28);
            if (templatePath.contains("classpath:")) {
                configuration.setTemplateLoader(new SpringTemplateLoader(new DefaultResourceLoader(), templatePath));
            } else {
                configuration.setDirectoryForTemplateLoading(new File(templatePath));
            }
            configuration.setDefaultEncoding("UTF-8");
            configuration.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
            configuration.setLogTemplateExceptions(false);
            configuration.setWrapUncheckedExceptions(true);
            return configuration;
        } catch (IOException e) {
            throw new RuntimeException("FreeMarkerUtils.getConfiguration", e);
        }
    }

    public static String getOutput(String templatePath, String templateName, Map dataModel) {
        try {
            Configuration configuration = getConfiguration(templatePath);
            StringWriter out = new StringWriter();
            Template template = configuration.getTemplate(templateName);
            template.process(dataModel, out);
            out.flush();
            out.close();
            return out.getBuffer().toString();
        } catch (IOException | TemplateException e) {
            throw new RuntimeException("FreeMarkerUtils.getOutput", e);
        }
    }

}

