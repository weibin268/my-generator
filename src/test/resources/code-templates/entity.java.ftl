package ${params.basePackage}.${params.moduleName}.entity;

import java.util.Date;
import com.zhuang.data.orm.annotation.Id;
import com.zhuang.data.orm.annotation.Table;
import com.zhuang.data.orm.annotation.UnderscoreNaming;

/**
 * Created by ${params.authorName} on ${params.nowDate}.
 */
@UnderscoreNaming
@Table(name="${entity.tableName}")//${entity.tableComment}
public class ${entity.entityName} {

<#list entity.properties as property>
    <#if property.isId>
	@Id
    </#if>
    private ${property.propertyType} ${property.propertyName};//${property.columnComment}
</#list>

<#list entity.properties as property>
  	public ${property.propertyType} get${stringUtils.underscoreToCamelCase(property.columnName,true)}() {
		return ${property.propertyName};
	}

    public void set${stringUtils.underscoreToCamelCase(property.columnName,true)}(${property.propertyType} ${property.propertyName}) {
		this.${property.propertyName}=${property.propertyName};
	}

</#list>
  	@Override
    public String toString() {
        return "Menu{" +
<#list entity.properties as property>
 				"${property.propertyName}='" + ${property.propertyName} + '\'' +
</#list>
                '}';
    }

}
