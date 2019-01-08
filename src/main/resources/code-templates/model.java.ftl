package ${params.basePackage}.model;

import java.util.Date;
import com.zhuang.data.orm.annotation.Id;
import com.zhuang.data.orm.annotation.Table;
import com.zhuang.data.orm.annotation.UnderscoreNaming;

/**
 * Created by ${params.authorName} on ${params.nowDate}.
 */
@UnderscoreNaming
@Table(name="${entity.tableName}")
public class ${entity.entityName} {

<#list entity.properties as property>
	<#if property.isId>
	@Id
	</#if>
    private ${property.propertyType} ${property.propertyName};
</#list>

<#list entity.properties as property>
  	public String get${stringUtils.underscoreToCamelCase(property.propertyName,true)}() {
		return ${property.propertyName};
	}

    public String get${stringUtils.underscoreToCamelCase(property.propertyName,true)}() {
		return ${property.propertyName};
	}

</#list>
}
