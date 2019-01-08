<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head th:replace="common/base::headerFragment('${entity.tableComment}列表')">

</head>

<body>
<blockquote class="layui-elem-quote">
    <div class="search-form">
        <form id="form1" class="layui-form">
            <div class="layui-inline">
                <label class="layui-form-label">名称：</label>
                <div class="layui-input-inline">
                    <input name="name" class="layui-input" type="text" style="width:150px;"/>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">时间：</label>
                <div class="layui-input-inline">
                    <input id="startTime" name="startTime" class="layui-input" type="text" style="width:100px;"/>
                </div>
                至
                <div class="layui-input-inline">
                    <input id="endTime" name="endTime" class="layui-input" type="text" style="width:100px;"/>
                </div>
            </div>
            <div class="layui-inline search-form-button">
                <div class="layui-input-inline">
                    <button class="layui-btn" onclick="return zwb.util.lay.reloadTable('table1')"><i
                            class="layui-icon">&#xe615;</i></button>
                </div>
            </div>
        </form>
    </div>
</blockquote>
<table id="table1" class="layui-table" _formId="form1" _toolbar="#toolbar1"
       _sql="${params.basePackage}.${params.moduleName}.mapper.${entity.entityName}.selectPage"
       _order="createdTime desc">
    <thead>
    <tr>
<#list entity.properties as property>
        <th lay-data="{field:'${property.propertyName}', width:100}">${property.columnComment}</th>
</#list>
        <th lay-data="{fixed: 'right', width:200, align:'center', toolbar: '#toolbar2'}">操作</th>
    </tr>
    </thead>
</table>

</body>

<script type="text/html" id="toolbar1">
    <th:block th:if="${r'${canAdd}'}==true">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-sm" onclick="return openAdd();">新增</button>
        </div>
    </th:block>
</script>

<script type="text/html" id="toolbar2">
    <a class="layui-btn layui-btn-sm" lay-event="view">查看</a>
    <th:block th:if="${r'${canModify}'}==true">
        <a class="layui-btn layui-btn-sm" lay-event="edit">修改</a>
    </th:block>
    <th:block th:if="${r'${canDelete}'}==true">
        <a class="layui-btn layui-btn-danger layui-btn-sm" lay-event="delete">删除</a>
    </th:block>
</script>

<script type="text/javascript" th:inline="javascript">
    /*<![CDATA[*/
    zwb.util.lay.initTable();
    layui.use(['form', 'table', 'layer'], function () {
        var table = layui.table;
        var layer = layui.layer;
        table.on('tool(table1)', function (obj) {
            if (obj.event == "edit") {
                zwb.util.lay.openDialog('${stringUtils.toLowerCaseFirstChar(entity.entityName)}_edit?id=' + obj.data.id, "700px", "480px", null, {title: "${entity.tableComment}编辑"});
            } else if (obj.event == "view") {
                zwb.util.lay.openDialog('${stringUtils.toLowerCaseFirstChar(entity.entityName)}_edit?isView=1&id=' + obj.data.id, "700px", "480px", function (index, layero) {
                    zwb.util.lay.closeDialog(index);
                }, {title: "${entity.tableComment}查看", btn: ['关闭']});
            } else if (obj.event == "delete") {
                zwb.util.lay.confirm("确认删除？", function () {
                    var id = obj.data.id;
                    zwb.util.post("/${params.moduleName}/${stringUtils.toLowerCaseFirstChar(entity.entityName)}/delete", {id: id}, function (data) {
                        if (!zwb.util.lay.handleException(data)) return false;
                        zwb.util.lay.reloadTable();
                    })
                });
            }
        });
    });
    /*]]>*/
</script>
</html>
