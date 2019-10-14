<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 2019/8/7
  Time: 14:23
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" pageEncoding="UTF-8" %>
<%@ include file="/baseJsp/inc-base.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="expires" content="0"/>
<meta http-equiv="X-UA-Compatible" content="IE=8; IE=9; IE=10"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>模型数据展示 区县</title>
    <link rel="stylesheet" type="text/css"
          href="css/moduledata/moduleDataShowForCity.css">
    <link rel="stylesheet" type="text/css"
          href="css/moduledata/analyseCommon.css">
</head>
<body class="no-scrollbar">
<div style="height: 10%">
    <div id="top_search" class="easyui-panel" style="padding:10px;background:#fafafa;">
        <input id="yzk100" class="easyui-combobox"  name="dept" label="选择模型:"  style="width:300px;"
               data-options="valueField:'id',textField:'text',data: [{
			id: 'java',
			text: 'Java'
		},{
			id: 'perl',
			text: 'Perl'
		},{
			id: 'ruby',
			text: 'Ruby'
		}]">
        <input id="ape032" class="easyui-combobox"  name="dept" label="选择期别:"  style="width:300px;"
               data-options="valueField:'id',textField:'text',data: [{
			id: '0',
			text: '月'
		},{
			id: '1',
			text: '季'
		},{
			id: '3',
			text: '年'
		}]">
        <div style="display: none;">
            <input id="aae043" type="text" class="easyui-textbox" label="选择的期号" >
        </div>
        <input id="aae043_0" type="text" class="easyui-datebox"  label="选择日期" data-options="" style="width:300px">
        <a href="#" id="btn_query" class="easyui-linkbutton c8"  data-options="plain:true" style="width:120px;float:right;margin-right: 200px;background-color:#95B8E7">查询</a>
    </div>
</div>
<div style="height: 90%;background: red;width:100%" >
    <div id="top_content" class="easyui-panel" style="background:#fafafa;width:100%" >
        <table id="dg" title="Client Side Pagination" style="width:100%"  data-options="
                rownumbers:true,
                fitColumns:true,
                singleSelect:true,
                autoRowHeight:true,
                pagination:true,
                pageSize:10">
            <thead>
            <tr>
                <th field="inv" >Inv No</th>
                <th field="date">Date</th>
                <th field="name" >Name</th>
                <th field="amount"  align="right">Amount</th>
                <th field="price"  align="right">Price</th>
                <th field="cost"  align="right">Cost</th>
                <th field="note" >Note</th>
            </tr>
            </thead>
        </table>
    </div>
</div>


</body>
</html>
<script type="text/javascript"
        src="js/moduledata/moduleDataShowForCounty.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        // $("body").taLayout();
        $(".module_name").html($("#yzk100_desc").val())
    });
</script>
<script>
    (function($){
        function pagerFilter(data){
            if ($.isArray(data)){    // is array
                data = {
                    total: data.length,
                    rows: data
                }
            }
            var target = this;
            var dg = $(target);
            var state = dg.data('datagrid');
            var opts = dg.datagrid('options');
            if (!state.allRows){
                state.allRows = (data.rows);
            }
            if (!opts.remoteSort && opts.sortName){
                var names = opts.sortName.split(',');
                var orders = opts.sortOrder.split(',');
                state.allRows.sort(function(r1,r2){
                    var r = 0;
                    for(var i=0; i<names.length; i++){
                        var sn = names[i];
                        var so = orders[i];
                        var col = $(target).datagrid('getColumnOption', sn);
                        var sortFunc = col.sorter || function(a,b){
                            return a==b ? 0 : (a>b?1:-1);
                        };
                        r = sortFunc(r1[sn], r2[sn]) * (so=='asc'?1:-1);
                        if (r != 0){
                            return r;
                        }
                    }
                    return r;
                });
            }
            var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
            var end = start + parseInt(opts.pageSize);
            data.rows = state.allRows.slice(start, end);
            return data;
        }

        var loadDataMethod = $.fn.datagrid.methods.loadData;
        var deleteRowMethod = $.fn.datagrid.methods.deleteRow;
        $.extend($.fn.datagrid.methods, {
            clientPaging: function(jq){
                return jq.each(function(){
                    var dg = $(this);
                    var state = dg.data('datagrid');
                    var opts = state.options;
                    opts.loadFilter = pagerFilter;
                    var onBeforeLoad = opts.onBeforeLoad;
                    opts.onBeforeLoad = function(param){
                        state.allRows = null;
                        return onBeforeLoad.call(this, param);
                    }
                    var pager = dg.datagrid('getPager');
                    pager.pagination({
                        onSelectPage:function(pageNum, pageSize){
                            opts.pageNumber = pageNum;
                            opts.pageSize = pageSize;
                            pager.pagination('refresh',{
                                pageNumber:pageNum,
                                pageSize:pageSize
                            });
                            dg.datagrid('loadData',state.allRows);
                        }
                    });
                    $(this).datagrid('loadData', state.data);
                    if (opts.url){
                        $(this).datagrid('reload');
                    }
                });
            },
            loadData: function(jq, data){
                jq.each(function(){
                    $(this).data('datagrid').allRows = null;
                });
                return loadDataMethod.call($.fn.datagrid.methods, jq, data);
            },
            deleteRow: function(jq, index){
                return jq.each(function(){
                    var row = $(this).datagrid('getRows')[index];
                    deleteRowMethod.call($.fn.datagrid.methods, $(this), index);
                    var state = $(this).data('datagrid');
                    if (state.options.loadFilter == pagerFilter){
                        for(var i=0; i<state.allRows.length; i++){
                            if (state.allRows[i] == row){
                                state.allRows.splice(i,1);
                                break;
                            }
                        }
                        $(this).datagrid('loadData', state.allRows);
                    }
                });
            },
            getAllRows: function(jq){
                return jq.data('datagrid').allRows;
            }
        })
    })(jQuery);

    function getData(){
        var rows = [];
        for(var i=1; i<=800; i++){
            var amount = Math.floor(Math.random()*1000);
            var price = Math.floor(Math.random()*1000);
            rows.push({
                inv: 'Inv No '+i,
                date: $.fn.datebox.defaults.formatter(new Date()),
                name: 'Name '+i,
                amount: amount,
                price: price,
                cost: amount*price,
                note: 'Note '+i
            });
        }
        return rows;
    }

    $(function(){
        $('#dg').datagrid({data:getData()}).datagrid('clientPaging');
    });
</script>
