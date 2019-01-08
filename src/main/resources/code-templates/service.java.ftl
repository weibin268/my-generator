package ${params.basePackage}.service;

import com.zhuang.common.model.KeyValue;
import com.zhuang.common.web.exception.MyCheckException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import zhuang.upms.modules.base.service.BaseService;
import ${params.basePackage}.model.${entity.entityName};

import java.util.*;

/**
 * Created by ${params.authorName} on ${params.nowDate}.
 */
@Service
public class ${entity.entityName}Service extends BaseService<${entity.entityName}> {

    public void add(${entity.entityName} model) {

    }

    public ${entity.entityName} get(Object id) {
		${entity.entityName} model = dbAccessor.queryEntity("${params.basePackage}.${params.moduleName}.mapper.${entity.entityName}.getById", id, ${entity.entityName}.class);
		return model;
    }

    public void save(${entity.entityName} model) {
		if (model.getId() == null || model.getId().equals("")) {
			model.setId(UUID.randomUUID().toString());
			model.setCreatedBy(getCurrentUserInfo().getUserId());
			model.setCreatedTime(new Date());
			model.setModifiedBy(getCurrentUserInfo().getUserId());
			model.setModifiedTime(new Date());
			}
			dbAccessor.insert(model);
		} else {
			${entity.entityName} tempModel = dbAccessor.select(model.getId(), ${entity.entityName}.class);
			tempModel.setModifiedBy(getCurrentUserInfo().getUserId());
			tempModel.setModifiedTime(new Date());
			tempModel.setStatus(model.getStatus());
			dbAccessor.update(tempModel);
		}
    }

    public void delete(Object id) {
    	dbAccessor.executeNonQuery("${params.basePackage}.${params.moduleName}.mapper.${entity.entityName}.deleteById", getUpdateParam(id));
    }

}
