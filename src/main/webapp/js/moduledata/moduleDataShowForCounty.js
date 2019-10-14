var zbType="val";
var RankingType="org";
var zbValSelectNum=0;
var zbScoreSelectNum=0;
var zbScorePageparam={
    "dto.star":0,
    "dto.limit":8
}
var zbValPageparam={
    "dto.star":0,
    "dto.limit":8
}
/**
 * 查询按钮事件
 */
function fnQuery() {
    //风险系数
    fnQueryRiskCoefficient()
    //指标
    zbValSelectNum=0;
    zbScoreSelectNum=0;
    zbScorePageparam["dto.star"]=0;
    zbValPageparam["dto.star"]=0;
    fnQueryZbByType()
    //趋势
    fnQueryChangeTrend()
    //排名
    fnQueryRankingByType(RankingType)
    $(".module_name").html(Base.getValue("yzk100Txt"));
}
/**
 * 查询风险系数
 */
function fnQueryRiskCoefficient() {
    Base.submit("frm_query", "getRiskCoefficient.do",
        null, null, true, function (data) {
            var tempData=data.fieldData.data;
            if (tempData==null){
                $("#fxxs").html("");
                $("#fxxstb").html("");
                $("#fxxshb").html("");
                $("#cityrank").html("");
                $("#cityprop").html("");
            }else{
                $("#fxxs").html(tempData.yze002+"%");
                if(tempData.yze003 >= 0){
                    $(".tb_icon_up").css("display","inline-block");
                    $(".tb_icon_down").css("display","none");
                }else{
                    $(".tb_icon_up").css("display","none");
                    $(".tb_icon_down").css("display","inline-block");
                }
                if(tempData.yze004 >= 0){
                    $(".hb_icon_up").css("display","inline-block");
                    $(".hb_icon_down").css("display","none");
                }else{
                    $(".hb_icon_up").css("display","none");
                    $(".hb_icon_down").css("display","inline-block");
                }
                $("#fxxstb").html(Math.abs(Number(tempData.yze003) * 100) +"%");
                $("#fxxshb").html(Math.abs(Number(tempData.yze004) * 100)+"%");
                $("#cityrank").html(tempData.rank_yze002);
                $("#cityprop").html(tempData.risk_yze002*100+"%");
            }
        },function () {});
}
/**
 * 查询 模型 指标情况 分页查询
 * @param type
 */
function fnQueryZbByType(type){
    if (type!=undefined) {
        zbType=type;
        if (zbValSelectNum>0&&zbType=="val"){
            if (zbValPageparam["dto.star"]!=0){
                zbValPageparam["dto.star"]=zbValPageparam["dto.star"]-zbValPageparam["dto.limit"];
            }
        }
        if (zbScoreSelectNum>0&&zbType=="score"){
            if (zbScorePageparam["dto.star"]!=0){
                zbScorePageparam["dto.star"]=zbScorePageparam["dto.star"]-zbScorePageparam["dto.limit"];
            }
        }
    }
    if (zbType=="val"){
        fnQueryZbVal()
    }
    if (zbType=="score"){
        fnQueryZbScore()
    }
}

/**
 * 查询指标得分
 */
function  fnQueryZbVal() {
    var pageParam=fnGetZbPageParam();
    Base.submit("frm_query", "getZbVal.do",
        pageParam, null, true, function (data) {
            var tempData=data.lists.data;
            fnCreateZBDiv(tempData.list)
            fnZbPage(tempData,zbValPageparam)
            zbValSelectNum=zbValSelectNum+1
        },function () {});
}

/**
 * 查询指标值
 */
function  fnQueryZbScore() {
    var pageParam=fnGetZbPageParam();
    Base.submit("frm_query", "getZbScore.do",
        pageParam, null, true, function (data) {
            var tempData=data.lists.data;
            fnCreateZBDiv(tempData.list)
            fnZbPage(tempData,zbScorePageparam)
            zbScoreSelectNum=zbScoreSelectNum+1
        },function () {
        });
}
/**
 * 创建指标展示内容
 * @param data
 */
function fnCreateZBDiv(data) {
    var conStr="";
    for(var i=0;i<data.length;i++){
        var doData=data[i];
        conStr+='<div class="div_zb fl">' +
            '                        <div class="div_zb_top">' +
            '                            <p class="zb_txt"  onclick="fnOpenWinZbfx('+doData.ykz001+')">'+doData.ykz002+'</p>' +
            '                            <p class="zb_val">'+doData.val+''+doData.ykz006+'</p>' +
            '                            <div class="div_info" title="'+doData.ykz005+'"></div>' +
            '                        </div>' +
            '                        <div class="div_zb_bottom">' +
            '                            <span class="zb_txt">同比</span>' +
            '                            <span class="tb_icon_up"></span>' +
            '                            <span class="zb_val">'+doData.tbval+''+doData.ykz006+'</span>' +
            '                            <span class="zb_txt">环比 </span>' +
            '                            <span class="hb_icon_down"></span>' +
            '                            <span class="zb_val">'+doData.hbval+''+doData.ykz006+'</span>' +
            '                        </div>' +
            '                    </div>';
    }
    $("#box_zb").html(conStr);
}

/**
 * 获取指标分页参数
 * @param type
 */
function fnGetZbPageParam() {
 if(zbType=="val"){
     return zbValPageparam;
 }else{
     return zbScorePageparam;
 }
}
/**
 * 处理指标分页
 * @param data
 */
function fnZbPage(data,pageParam) {
    var total=data.total;
    var start=data.start;
    var limit=pageParam["dto.limit"];
    if (total==0||start+limit==total){
        $("#span_page").html("下一页");
        $("#span_page").css("display","none");
    }else{
        if (start>=total||start+limit>=total){
            pageParam["dto.star"]=0;
            $("#span_page").html("首页");
            $("#span_page").css("display","inline-block");
        } else {
            pageParam["dto.star"]=start+limit;
            $("#span_page").html("下一页");
            $("#span_page").css("display","inline-block");
        }
    }
}
/**
 * 打开指标分析
 * @param ykz001 指标ID
 * @param aaa167 规则名称
 * @param aaa005 阈值
 */
function fnOpenWinZbfx(ykz001, aaa167,aaa005) {
    var param = {
        "dto.ykz001": ykz001,
        "dto.aaa167": aaa167,
        "dto.aaa005": aaa005
    };
    Base.openWindow("analyse", "指标分析", "openAnalyse.do",
        param, "100%", "100%", null, function (data) {}, true);
}
/**
 * 查询 模型全市风险系数变化趋势
 */
function fnQueryChangeTrend() {
    Base.submit("frm_query", "getChangeTrend.do",
        null, null, true, function (data) {
            var tempData=data.lists.data;
            fnCreateLine(tempData.list)
        },function () {});
}
/**
 * 查询模型 类型  风险系数排名
 * @param type
 */
function fnQueryRankingByType(type) {
    if (type!=undefined){
        RankingType=type;
    }
    Base.submit("frm_query", "getRanking.do",
        {"dto.type":RankingType}, null, true, function (data) {
            var tempData=data.lists.grd_rank;
            fnCreateBar(tempData.list)
        },function () {});
}
/**
 * 打开排名 更多
 */
function fnOpenRanking() {
    var param = {
        "dto.type": RankingType,
        "dto.aae043":Base.getValue("aae043"),
        "dto.ape032":Base.getValue("ape032"),
        "dto.yzk100":Base.getValue("yzk100"),
    };
    Base.openWindow("ranking", "排名", "openRanking.do",
        param, "50%", "50%", null, function (data) {}, true);
}
/**
 * 创建折线图
 * @param data
 */
function fnCreateLine(data) {
    var aaa123 = Base.getValue("aaa027_desc");
    var xdata=[]
    var sdata_city=[];
    var sdata_area=[];
    if (data.length>0){
        for(var i=0;i<data.length;i++){
            var doData=data[i];
            xdata.push(doData.aae043);
            sdata_city.push(doData.yze002_city);
            sdata_area.push(doData.yze002_area);
        }
    }else{
        xdata.push("无数据")
        sdata_city.push("0");
        sdata_area.push("0");
    }
    option = {
        grid:{
            borderWidth:0
        },
        tooltip : {
            trigger: 'axis'
        },
        legend: {
            x:'right',
            data:['全市',aaa123]
        },
        toolbox: {
            show : false
        },
        calculable : true,
        xAxis : [
            {
                type : 'category',
                data :xdata
                ,axisTick:{
                    lineStyle: {
                        color:'#cccccc'
                    }
                },
                axisLine: {
                    show: true,
                    lineStyle: {
                        color:'#cccccc'
                    }
                },splitLine: {
                    show:false
                }

            }
        ],
        yAxis : [
            {
                type : 'value',
                axisLabel : {
                    formatter: '{value} %'
                },
                axisLine: {
                    show: false
                },
                splitLine: {
                    show:true,
                    lineStyle: {
                        type: 'dashed',
                        width:1,
                        color:'#cccccc'
                    },
                }
            }
        ],
        series : [
            {
                symbol: 'none',
                name:'全市',
                type:'line',
                data:sdata_city
            },
            {
                symbol: 'none',
                name:aaa123,
                type:'line',
                data:sdata_area
            }
        ]
    };
    var myChart = echarts.init(document.getElementById('div_line'));
    // 图表清空-------------------
    myChart.clear();
    myChart.setOption(option, true);
    myChart.on("click", function(param) {
    });
}
/**
 * 创建bar
 * @param data
 */
function fnCreateBar(data) {
    var xdata=[];
    var sdata=[];
    var len=0;
    if (data.length>0){
        len=data.length>10?10:data.length;
        for(var i=0;i<len;i++){
            var doData=data[i];
            xdata.push(doData.name);
            sdata.push({"id":doData.id,"name":doData.name,"value":doData.val});
        }
    }else{
        xdata.push("无数据")
        sdata.push("0")
    }
    var option = {
        grid:{
            borderWidth:0
        },
        tooltip : {
            trigger: 'axis'
        },
        toolbox: {
            show : false
        },
        calculable : true,
        xAxis : [
            {
                type : 'category',
                data : xdata
                ,axisTick:{
                    lineStyle: {
                        color:'#cccccc'
                    }
                },
                axisLine: {
                    show: true,
                    lineStyle: {
                        color:'#cccccc'
                    }
                },splitLine: {
                    show:false
                }
            }
        ],
        yAxis : [
            {
                type : 'value',
                axisLine: {
                    show: false
                },
                axisLabel : {
                    formatter: '{value} %'
                },
                splitLine: {
                    show:true,
                    lineStyle: {
                        type: 'dashed',
                        width:1,
                        color:'#cccccc'
                    },
                }
            }
        ],
        series : [
            {
                name:'',
                barWidth:15,
                type:'bar',
                data:sdata,

            }
        ]
    };
    var myChart = echarts.init(document.getElementById('div_bar'));
    // 图表清空-------------------
    myChart.clear();
    myChart.setOption(option, true);
    myChart.on("click", function(param) {
        var data=param.data
        var paramOpen={"dto.id":data.id,
            "dto.ape032":Base.getValue("ape032"),
            "dto.aae043":Base.getValue("aae043"),
            "dto.aaa027":Base.getValue("aaa027_desc"),
            "dto.RankingType":RankingType,
            "dto.yzk100":Base.getValue("yzk100")
        }
        fnOpenWinModuleShow(paramOpen);
    });
}

/**
 * 打开 区县模型结果展示
 * @param id
 * @param name
 * @param value
 */
function fnOpenWinModuleShow(paramOpen) {
    Base.openWindow("module", "模型结果展示", "openModuleShow.do",
        paramOpen, "100%", "100%", null, function (data) {}, true);
}
/**
 * 期号选择事件
 * @param key
 * @param value
 */
function fnQbChange(key,value) {
    if (value=="3"){
        Base.showObj("aae043_3");
        Base.hideObj("aae043_0");
        Base.hideObj("aae043_1");
    }
    if (value=="1"){
        Base.showObj("aae043_1");
        Base.hideObj("aae043_0");
        Base.hideObj("aae043_3");
    }
    if (value=="0"){
        Base.showObj("aae043_0");
        Base.hideObj("aae043_3");
        Base.hideObj("aae043_1");
    }
}
/**
 * 模型选择事件
 * @param key
 * @param value
 */
function fnYzk100Change(key,value){
    Base.setValue("yzk100Txt",key);
}
/**
 * 时间控件
 * @param obj
 * @param ape032
 */
function fnDataClick(obj,ape032){
    Base.setValue("aae043",Base.getValue("aae043_"+ape032))
}
/**
 * tab绑定click事件
 */
$(".div_tab ul li").click(function () {
    $(this).addClass("li_active").siblings().removeClass("li_active");
})
