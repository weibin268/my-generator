<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head th:replace="common/base::headerFragment('${entity.tableComment}编辑')">
</head>
<body>
<div class="dlg-form">
    <form id="form1" method="post" class="layui-form">
        <input name="id" type="hidden"/>
<#list entity.properties as property>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">${property.columnComment}:</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" name="${property.propertyName}" <#if property.nullable>lay-verify="required"</#if>></input>
                </div>
            </div>
        </div>
</#list>
        <button id="btnSubmit" class="layui-btn" lay-submit="" lay-filter="*" style="display:none;">提交</button>
    </form>
</div>
</body>

<script th:inline="javascript">
    /*<![CDATA[*/
    layui.use(['form'], function () {
        var id = /*[[${r"${#httpServletRequest.getParameter('id')}"}]]*/null;
        var isView = /*[[${r"${#httpServletRequest.getParameter('isView')}"}]]*/null;
        var form = layui.form;

        zwb.util.lay.initForm();
        if (id != null) {
            zwb.util.post("/${params.moduleName}/${stringUtils.toLowerCaseFirstChar(entity.entityName)}/get", {id: id}, function (data) {
                zwb.util.fillForm("form1", data.data);
                form.render();
                if (isView == "1") zwb.util.disableForm("form1");
            });
        }
    });

    function doSave(index, layero, originOpener) {
        zwb.util.lay.validateForm("form1", function (data) {
            zwb.util.post("/${params.moduleName}/${stringUtils.toLowerCaseFirstChar(entity.entityName)}/save", zwb.util.serializeEntity("form1"), function (data) {
                if (!zwb.util.lay.handleException(data)) return false;
                parent.layui.layer.close(index);
                originOpener.zwb.util.lay.reloadTable();
            });
        });
    };
    /*]]>*/
</script>
</html>