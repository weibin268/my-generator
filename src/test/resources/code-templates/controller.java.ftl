package ${params.basePackage}.${params.moduleName}.controller;

import com.zhuang.common.web.restapi.args.IdArgs;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import zhuang.upms.util.SecurityUtils;
import zhuang.upms.modules.base.controller.BaseController;
import ${params.basePackage}.${params.moduleName}.service.${entity.entityName}Service;
import ${params.basePackage}.${params.moduleName}.model.${entity.entityName};

import javax.servlet.http.HttpServletRequest;

/**
 * Created by ${params.authorName} on ${params.nowDate}.
 */
@Controller
@RequestMapping(value = "/${params.moduleName}/${stringUtils.toLowerCaseFirstChar(entity.entityName)}")
public class ${entity.entityName}Controller extends BaseController {

    @Autowired
    private ${entity.entityName}Service ${stringUtils.toLowerCaseFirstChar(entity.entityName)}Service;

    @RequestMapping(value = "${stringUtils.toLowerCaseFirstChar(entity.entityName)}_main")
    public String main(HttpServletRequest request) {
        request.setAttribute("canDelete", SecurityUtils.hasPermission("core:${stringUtils.toLowerCaseFirstChar(entity.entityName)}:delete"));
        request.setAttribute("canAdd", SecurityUtils.hasPermission("core:${stringUtils.toLowerCaseFirstChar(entity.entityName)}:add"));
        request.setAttribute("canModify", SecurityUtils.hasPermission("core:${stringUtils.toLowerCaseFirstChar(entity.entityName)}:modify"));
        return "${params.moduleName}/${stringUtils.toLowerCaseFirstChar(entity.entityName)}/${stringUtils.toLowerCaseFirstChar(entity.entityName)}_main";
    }

    @RequestMapping(value = "${stringUtils.toLowerCaseFirstChar(entity.entityName)}_edit")
    public String edit(HttpServletRequest request) {
        return "${params.moduleName}/${stringUtils.toLowerCaseFirstChar(entity.entityName)}/${stringUtils.toLowerCaseFirstChar(entity.entityName)}_edit";
    }
 
    @ResponseBody
    @RequestMapping(value = "get")
    public Object get(IdArgs args) {
        ${entity.entityName} model = ${stringUtils.toLowerCaseFirstChar(entity.entityName)}Service.get(args.getId());
        return toMyJsonResult(model);
    }

    @ResponseBody
    @RequiresPermissions(value = {"core:${stringUtils.toLowerCaseFirstChar(entity.entityName)}:add", "core:${stringUtils.toLowerCaseFirstChar(entity.entityName)}:modify"}, logical = Logical.OR)
    @RequestMapping("save")
    public Object save(${entity.entityName} model) {
        ${stringUtils.toLowerCaseFirstChar(entity.entityName)}Service.save(model);
        return toMyJsonResult(null);
    }

    @RequestMapping(value = "delete")
    @ResponseBody
    @RequiresPermissions(value = "core:${stringUtils.toLowerCaseFirstChar(entity.entityName)}:delete")
    public Object delete(IdArgs args) {
        ${stringUtils.toLowerCaseFirstChar(entity.entityName)}Service.delete(args.getId());
        return toMyJsonResult(null);
    }

}
