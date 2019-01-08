<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${params.basePackage}.${params.moduleName}.mapper.${entity.entityName}">

    <insert id="insert" parameterType="${params.basePackage}.${params.moduleName}.model.${entity.entityName}">
        insert into ${entity.tableName}(<#list entity.properties as property>${property.columnName}<#if property?has_next>,</#if></#list>)
        values(<#list entity.properties as property>${r"#{"+property.propertyName+"}"}<#if property?has_next>,</#if></#list>)
    </insert>

    <update id="update" parameterType="${params.basePackage}.${params.moduleName}.model.${entity.entityName}">
        update ${entity.tableName} set <#list entity.properties as property><#if !property.isId>${property.columnName}=${r"#{"+property.propertyName+"}"}<#if property?has_next>,</#if></#if></#list>
        where id=${r"#{id}"}
    </update>

    <select id="selectPage" resultType="map">
        select
<#list entity.properties as property>
            a.${property.columnName} as ${property.propertyName}<#if property?has_next>,</#if>
</#list>
        from ${entity.tableName} a
<#list entity.properties as property>
    <#if property.columnName=="status">
        where a.status!=-1
    </#if>
</#list>
    </select>

    <select id="getById" resultType="${params.basePackage}.${params.moduleName}.model.${entity.entityName}">
        select a.*
        from ${entity.tableName} a
        where a.id=${r"#{id}"}<#list entity.properties as property><#if property.columnName=="status"> AND a.status!=-1</#if></#list>
    </select>

    <update id="deleteById">
        UPDATE ${entity.tableName} SET status = -1,modified_by=${r"#{ModifiedBy}"},modified_time=${r"#{ModifiedTime}"}
        where id=${r"#{id}"}
    </update>

</mapper>
