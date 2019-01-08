${stringUtils.toLowerCaseFirstChar(entity.entityName)}
${entity.tableName}
${entity.properties[0].propertyName}
<#list entity.properties as property>
    ${property?has_next?c}
    <#if property?has_next>,</#if>
</#list>