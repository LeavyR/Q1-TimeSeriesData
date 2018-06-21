//统一的Ajax Json数据处理
function FBaseJSonDeal(FData, FFuncOK, FFuncErr, FShowMsg, FSync) {
    if (FSync == undefined)
        FSync = true;
    if (FShowMsg == undefined)
        FShowMsg = true;

    if (FShowMsg)

        $.ajax({
            type: "POST",
            url: "framePublic/pubJSONAjax.aspx",
            dataType: "Json",
            data: FData,
            async: FSync,
            error: function () {
               

            },
            success: function (data) {

                var str = "var obj=" + data;

                //eval(str);
                //if (obj.success)
                if (FFuncOK != null)
                    FFuncOK(data);

            }
        });
}