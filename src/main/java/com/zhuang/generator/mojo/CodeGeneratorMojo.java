package com.zhuang.generator.mojo;

import com.zhuang.generator.CodeGenerator;
import com.zhuang.generator.config.MyGeneratorProperties;
import org.apache.maven.plugin.AbstractMojo;
import org.apache.maven.plugin.MojoExecutionException;
import org.apache.maven.plugin.MojoFailureException;

public class CodeGeneratorMojo extends AbstractMojo {

    private MyGeneratorProperties myGeneratorProperties;

    public CodeGeneratorMojo() {
        myGeneratorProperties = new MyGeneratorProperties();
    }

    @Override
    public void execute() throws MojoExecutionException, MojoFailureException {
        try {
            Class<?> codeGeneratorClass = Class.forName(myGeneratorProperties.getImplementClass());
            CodeGenerator codeGenerator = (CodeGenerator) codeGeneratorClass.getConstructor().newInstance();
            codeGenerator.generate();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
