//统一的Ajax Json数据处理
function FBaseJSonDeal(FData, FFuncOK, FFuncErr, FShowMsg, FSync) {
    if (FSync == undefined)
        FSync = true;

    if (FShowMsg)


        $.ajax({
            type: "POST",
            url: "framePublic/pubJSONAjax.aspx",
            dataType: "Json",
            data: FData,
            async: FSync,
            error: function () {
                alert("err");

            },
            success: function (data) {

                var str = "var obj=" + data;

                eval(str);
                if (obj.success)
                    if (FFuncOK != null)
                        FFuncOK(obj);

                if (!obj.success) {

                    if (obj.errcode == 1)
                        PubUserLogin();
                    else {

                    }

                    if (FFuncErr != null) FFuncErr(obj);
                }
            }
        });
}