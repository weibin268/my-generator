package ${params.basePackage}.${params.moduleName}.service;

import org.springframework.stereotype.Service;
import zhuang.upms.modules.base.service.BaseService;
import ${params.basePackage}.${params.moduleName}.model.${entity.entityName};

import java.util.Date;
import java.util.UUID;

/**
 * Created by ${params.authorName} on ${params.nowDate}.
 */
@Service
public class ${entity.entityName}Service extends BaseService<${entity.entityName}> {

    public void add(${entity.entityName} model) {
        dbAccessor.insert(model);
    }

    public ${entity.entityName} get(Object id) {
		${entity.entityName} model = dbAccessor.queryEntity("${params.basePackage}.${params.moduleName}.mapper.${entity.entityName}.getById", id, ${entity.entityName}.class);
		return model;
    }

    public void save(${entity.entityName} model) {
		if (model.getId() == null || model.getId().equals("")) {
			model.setId(UUID.randomUUID().toString());
<#list entity.properties as property>
	<#if property.propertyName=="createdBy">
			model.setCreatedBy(getCurrentUserInfo().getUserId());
	</#if>
	<#if property.propertyName=="createdTime">
			model.setCreatedTime(new Date());
	</#if>
	<#if property.propertyName=="modifiedBy">
			model.setModifiedBy(getCurrentUserInfo().getUserId());
	</#if>
	<#if property.propertyName=="modifiedTime">
			model.setModifiedTime(new Date());
	</#if>
</#list>
			dbAccessor.insert(model);
		} else {
			${entity.entityName} tempModel = dbAccessor.select(model.getId(), ${entity.entityName}.class);
<#list entity.properties as property>
	<#if property.propertyName=="modifiedBy">
			tempModel.setModifiedBy(getCurrentUserInfo().getUserId());
	</#if>
	<#if property.propertyName=="modifiedTime">
			tempModel.setModifiedTime(new Date());
	</#if>
	<#if property.propertyName=="status">
			tempModel.setStatus(model.getStatus());
	</#if>
</#list>
			dbAccessor.update(tempModel);
		}
    }

    public void delete(Object id) {
    	dbAccessor.executeNonQuery("${params.basePackage}.${params.moduleName}.mapper.${entity.entityName}.deleteById", getUpdateParam(id));
    }

}
