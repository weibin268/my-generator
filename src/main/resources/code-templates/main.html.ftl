<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head th:replace="common/base::headerFragment('')">

</head>

<body>
<blockquote class="layui-elem-quote">
    <div class="search-form">
        <form id="form1" class="layui-form">
            <input type="hidden" name="parentId"/>
            <div class="layui-inline">
                <label class="layui-form-label">登录账号：</label>
                <div class="layui-input-inline">
                    <input name="userLoginId" class="layui-input" type="text" style="width:150px;"/>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">登录姓名：</label>
                <div class="layui-input-inline">
                    <input name="userName" class="layui-input" type="text" style="width:150px;"/>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">登录时间：</label>
                <div class="layui-input-inline">
                    <input id="startTime" name="startTime" class="layui-input" type="text" style="width:100px;"/>
                </div>
                至
                <div class="layui-input-inline">
                    <input id="endTime" name="endTime" class="layui-input" type="text" style="width:100px;"/>
                </div>
            </div>
            <div class="layui-inline">
                &nbsp;&nbsp;&nbsp;
                <div class="layui-input-inline">
                    <button class="layui-btn layui-btn-sm" onclick="return zwb.util.lay.reloadTable('table1')"><i
                            class="layui-icon">&#xe615;</i></button>
                </div>
            </div>
        </form>
    </div>
    <hr class="layui-bg-green"/>
</blockquote>
<table id="table1" class="layui-table" _formId="form1"
       _sql="${params.basePackage}.${params.moduleName}.mapper.${entity.entityName}.selectPage" _order="createdTime desc">
    <thead>
    <tr>
        <th lay-data="{field:'userLoginId', width:100}">登录账号</th>
        <th lay-data="{field:'userName', width:100}">登录姓名</th>
        <th lay-data="{field:'clientIp',width:150}">登录IP</th>
        <th lay-data="{field:'userAgent'}">浏览器信息</th>
        <th lay-data="{field:'createdTime', width:220}">登录时间</th>
        <!--        <th lay-data="{fixed: 'right', width:350, align:'center', toolbar: '#toolbar1'}">操作</th>-->
    </tr>
    </thead>
</table>

</body>

<script type="text/html" id="toolbar1">
    <a class="layui-btn layui-btn-sm" lay-event="view">查看</a>
</script>

<script type="text/javascript" th:inline="javascript">
    /*<![CDATA[*/
    zwb.util.lay.initTable();
    layui.use(['form', 'table', 'layer', 'laydate'], function () {
        var table = layui.table;
        var layer = layui.layer;
        var laydate = layui.laydate;

        table.on('tool(table1)', function (obj) {
            if (obj.event == "view") {
                zwb.util.lay.openDialog('${stringUtils.toLowerCaseFirstChar(entity.entityName)}_view?isView=1&id=' + obj.data.id, "700px", "400px", function (index, layero) {
                    zwb.util.lay.closeDialog(index);
                }, {title: "角色查看", btn: ['关闭']});
            }
        });
        laydate.render({elem: '#startTime'});
        laydate.render({elem: '#endTime'});
    });
    /*]]>*/
</script>
</html>
