<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head th:replace="common/base::headerFragment('用户列表')">

</head>

<link rel="stylesheet" type="text/css" th:href="@{/js/zTree/css/zTreeStyle/zTreeStyle.css}"/>
<link rel="stylesheet" type="text/css" th:href="@{/js/webuploader/webuploader.css}"/>

<script type="text/javascript" th:src="@{/js/zTree/js/jquery.ztree.all.js}"></script>
<script type="text/javascript" th:src="@{/js/webuploader/webuploader.js}"></script>

<body>
<div class="dlg-form">
    <form id="form1" method="post" class="layui-form">
        <input name="id" type="hidden"/>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">帐号:</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" name="loginId" lay-verify="required"></input>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">姓名:</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" name="name" lay-verify="required"></input>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">性别:</label>
                <div class="layui-input-inline">
                    <select name="sex">
                        <option value="">未选择</option>
                        <option value="M">男</option>
                        <option value="F">女</option>
                    </select>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">状态:</label>
                <div class="layui-input-inline">
                    <select name="status" lay-verify="required">
                        <option value="1">启用</option>
                        <option value="0">禁用</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">所属组织：</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" name="orgName" id="orgName" lay-verify="required"
                           readonly="readonly">
                    </input>
                    <input name="orgId" id="orgId" type="hidden"/>
                </div>
            </div>
            <div class="layui-inline" th:if="${r"${#httpServletRequest.getParameter('isView')!='1'}"}">
                <button class="layui-btn layui-btn-sm" onclick="return selectOrg()">
                    <i class="layui-icon">&#xe615;</i>
                </button>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">头像:</label>
                <div class="layui-input-inline" id="imgPicker">上传头像</div>
            </div>
            <div class="layui-inline">
                <img id="imgUser" style="width: 80px;"/>
                <input type="hidden" id="imgFileId" name="imgFileId"/>
            </div>
        </div>
        <button id="btnSubmit" class="layui-btn" lay-submit="" lay-filter="*" style="display:none;">提交</button>
    </form>
</div>
</body>

<script th:inline="javascript">
    /*<![CDATA[*/
    layui.use(['form'], function () {
        var id = /*[[${r"${#httpServletRequest.getParameter('id')}"}]]*/null;
        var isView = /*[[${r"${#httpServletRequest.getParameter('isView')}"}]]*/null;
        var tempId = /*[[${r"${tempId}"}]]*/null;
        var form = layui.form;

        zwb.util.lay.initForm();
        if (id != null) {
            $("input[name=loginId]").attr("disabled", "disabled");
            zwb.util.post("/${params.moduleName}/${stringUtils.toLowerCaseFirstChar(entity.entityName)}/get", {id: id}, function (data) {
                data.data.password = "******";
                zwb.util.fillForm("form1", data.data);
                form.render();
                if (isView == "1") zwb.util.disableForm("form1");
                initFileUpload(id);
            });
        } else {
            initFileUpload(tempId);
        }
    });

    function initFileUpload(bizId) {
        var imgFileId = $("#imgFileId").val();
        if (imgFileId) {
            $("#imgUser").attr("src", zwb.util.ui.getFileDownloadUrl(imgFileId));
        }
        var uploader = zwb.util.ui.fileUpload("imgPicker", "sys_user", bizId, function (data) {
            $("#imgUser").attr("src", zwb.util.ui.getFileDownloadUrl(data.id));
            $("#imgFileId").val(data.id);
        }, {
            accept: {
                title: 'Images',
                extensions: 'gif,jpg,jpeg,bmp,png',
                mimeTypes: 'image/*'
            }
        });
    }

    function selectOrg() {
        parent.zwb.util.lay.openSelectDialogTree("zhuang.upms.modules.core.mapper.Organization.getTreeNodes", function (arr) {
            $("#orgId").val(arr[0].value);
            $("#orgName").val(arr[0].text);
        }, {title: "组织机构选择"})
        return false;
    }

    function doSave(index, layero,originOpener) {
        zwb.util.lay.validateForm("form1", function (data) {
            zwb.util.post("/core/user/save", zwb.util.serializeEntity("form1"), function (data) {
                if (!zwb.util.lay.handleException(data))return false;
                parent.layui.layer.close(index);
                originOpener.zwb.util.lay.reloadTable();
            });
        });
    };
    /*]]>*/
</script>
</html>