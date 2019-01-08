package com.zhuang.generator.util;

public class StringUtils {

    public String camelCaseToUnderscore(String text) {
        return camelCaseToUnderscore(text, false);
    }

    public String camelCaseToUnderscore(String text, boolean isBigMode) {
        return com.zhuang.data.util.StringUtils.camelCaseToUnderscore(text, isBigMode);
    }

    public String underscoreToCamelCase(String text) {
        return underscoreToCamelCase(text, false);
    }

    public String underscoreToCamelCase(String text, boolean isBigMode) {
        return com.zhuang.data.util.StringUtils.underscoreToCamelCase(text, isBigMode);
    }

    public String toLowerCase(String str) {
        if (str == null || str.isEmpty()) return str;
        return str.toLowerCase();
    }

    public String toLowerCaseFirstChar(String str) {
        if (str == null || str.isEmpty()) return str;
        return str.substring(0, 1).toLowerCase() + str.substring(1);
    }
}
