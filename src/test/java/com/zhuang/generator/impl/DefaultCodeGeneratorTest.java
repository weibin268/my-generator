package com.zhuang.generator.impl;

import com.zhuang.generator.CodeGenerator;
import org.junit.Test;

public class DefaultCodeGeneratorTest {

    @Test
    public void generate() {
        CodeGenerator codeGenerator= new DefaultCodeGenerator();
        codeGenerator.generate();
    }

}