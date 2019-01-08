package com.zhuang.generator.impl;

import com.zhuang.generator.CodeGenerator;
import org.junit.Test;

import static org.junit.Assert.*;

public class DefaultCodeGeneratorTest {

    @Test
    public void generate() {
        CodeGenerator codeGenerator= new DefaultCodeGenerator();
        codeGenerator.setModuleName("log");
        codeGenerator.generate("sys_|operation_log");
    }

}