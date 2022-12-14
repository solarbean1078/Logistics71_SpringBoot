<%--<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="J2H" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css">
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-balham.css">
    <script src="${pageContext.request.contextPath}/js/modal.js?v=<%=System.currentTimeMillis()%>" defer></script>
    <script src="${pageContext.request.contextPath}/js/datepicker.js" defer></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/datepicker.css">


    <script>
        // O setting datapicker
        $(function () {
            // set default dates
            let start = new Date();
            start.setDate(start.getDate() - 365);
            // set end date to max one year period:
            let end = new Date(new Date().setYear(start.getFullYear() + 1));
            // o set searchDate
            $('#datepicker').datepicker({
                todayHiglght: true,
                autoHide: true,
                autoaShow: true,
            });
            // o set searchRangeDate
            $('#fromDate').datepicker({
                startDate: start,
                endDate: end,
                minDate: "-10d",
                todayHiglght: true,
                autoHide: true,
                autoaShow: true,
                // update "toDate" defaults whenever "fromDate" changes
            })
            $('#toDate').datepicker({
                startDate: start,
                endDate: end,
                todayHiglght: true,
                autoHide: true,
                autoaShow: true,
            })
            $('#fromDate').on("change", function () {
                //when chosen from_date, the end date can be from that point forward
                var startVal = $('#fromDate').val();
                $('#toDate').data('datepicker').setStartDate(startVal);
            });
            $('#toDate').on("change", function () {
                //when chosen end_date, start can go just up until that point
                var endVal = $('#toDate').val();
                $('#fromDate').data('datepicker').setEndDate(endVal);
            });

        });
    </script>
    <style>
        .fromToDate {
            margin-bottom: 7px;
        }

        .button1 {
            background-color: #506FA9;
            border: none;
            color: white;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 17px;
            border-radius: 3px;
            margin-bottom: 10px;
        }

        .button2 {
            background-color: #dc3170;
            border: none;
            color: white;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 17px;
            border-radius: 3px;
            margin-bottom: 10px;
        }

        .button3 {
            background-color: #506FA9;
            border: none;
            color: white;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 17px;
            padding-bottom: 4px;
            padding-top: 4px;
            border-radius: 3px;
            margin-bottom: 20px;
        }
        .button4 {
            background-color: #dc3170;
            border: none;
            color: white;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            padding-bottom: 4px;
            padding-top: 4px;
            font-size: 17px;
            border-radius: 3px;
            margin-bottom: 10px;
        }

        #amountList{
            display:none;
        }

        #reverseTypeList{
            display:none;
        }

        @media (min-width: 768px) {
            .modal-xl {
                width: 90%;
                max-width: 1200px;
            }
        }

        /*?????? ????????????*/
        .ag-header-cell-label {
            justify-content: center;
        }

        .ag-cell-value {
            padding-left: 50px;
        }
    </style>
</head>
<body>

<article class="contract">
    <div class="contract__Title">
        <h5>???? ??????</h5>
        <div style="color: black;">
            <b>?????? ??????</b><br/>
        </div>

        <form autocomplete="off">
            <div class="fromToDate">
                <input type="text" id="fromDate" placeholder="YYYY-MM-DD ????" size="15" style="text-align: center">
                &nbsp; ~ &nbsp;<input type="text" id="toDate" placeholder="YYYY-MM-DD ????" size="15"
                                      style="text-align: center">
                &nbsp;&nbsp;&nbsp;&nbsp;<div class="button1" type="button" id="contractCandidateSearchButton">&nbsp;&nbsp;??????
                ?????? ??????&nbsp;&nbsp;
            </div>
                <div class="button2" type="button" id="ReturnRegistersButton">&nbsp;&nbsp;?????? ??????&nbsp;&nbsp;</div>

            </div>

        </form>
        <button class="search" id="amountList" data-toggle="modal"
                data-target="#amountModal">??????
        </button>
        <button class="search" id="reverseTypeList" data-toggle="modal"
                data-target="#listModal">????????? ??????
        </button>

        <input type="hidden" button id="mpsModalBtn"></div>
    </div>
</article>
<article class="contractMpsGrid">
    <div align="center">
        <div id="myGrid" class="ag-theme-balham" style="height:30vh; width:auto; text-align: center;"></div>
    </div>
</article>
<br>
<br>
<div>
    <h5>???? ?????? ?????? &nbsp;&nbsp;<div class="button3" type="button" id="returnListSearchButton">&nbsp;&nbsp;?????? ?????? ??????&nbsp;&nbsp; </div>
        <div class="button4" type="button" id="deleteListButton">&nbsp;&nbsp;??????&nbsp;&nbsp;</div></h5>

</div>
<article class="salesMpsGrid">
    <div align="center" class="ss">
        <div id="myGrid2" class="ag-theme-balham" style="height:30vh;width:auto;"></div>
    </div>
</article>

<%--<div class="modal fade" id="mpsModal" role="dialog">
    <div class="modal-dialog modal-xl">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">MPS LIST</h5>
                <button type="button" class="close" data-dismiss="modal" style="padding-top: 0.5px">&times;</button>
            </div>
            <div class="modal-body">
                <div id="mpsGrid" class="ag-theme-balham" style="height:600px;width:auto;">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>--%>

<div class="modal fade" id="amountModal" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">

            <!-- ?????? ??????- -->
            <div class="modal-header">
                <h5 class="modal-title">AMOUNT</h5>
                <button type="button" class="" data-dismiss="modal" style="padding-top: 0.5px">&times;</button>
            </div>

            <!-- ?????? ??????- -->
            <div class="modal-body">
                <div style="width:auto; text-align:left">
                    <label style='font-size: 20px; margin-right: 10px'>????????????</label>
                    <input type='text' id='returnAmountBox'  autocomplete="off"/><br>
                    <label for='unitPriceOfReturnBox' style='font-size: 20px; margin-right: 10px'>????????????</label>
                    <input type='text' id='unitPriceOfReturnBox' autocomplete="off" readonly/><br>
                    <label for='sumPriceOfReturnBox' style='font-size: 20px; margin-right: 30px'>?????????  </label>
                    <input type="text" id='sumPriceOfReturnBox' autocomplete="off"/>
                </div>
            </div>
            <div class="modal-footer"> <!-- ?????? ??????-->
                <button type="button" id ="amountSave" class="btn btn-default" data-dismiss="modal">Save</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<J2H:listModal/>

<script>
    const myGrid = document.querySelector("#myGrid");
    const myGrid2 = document.querySelector("#myGrid2");
    const searchByDateRadio = document.querySelector("#searchByDateRadio");
    const startDatePicker = document.querySelector("#fromDate");
    const endDatePicker = document.querySelector("#toDate");
    const returnDate = document.querySelector("#returnDate");
    const amountList = document.querySelector('#amountList');
    const reverseTypeList = document.querySelector("#reverseTypeList");


    // O customerList Grid
    let Column = [
        {
            headerName: "????????????", field: "deliveryNO", suppressSizeToFit: true, headerCheckboxSelection: true,
            headerCheckboxSelectionFilteredOnly: true,
            checkboxSelection: true, width: 200
        },

        {headerName: "????????????", field: "deliveryDate", width: 250},

        {
            headerName: "????????????", field: "returnDate", editable: true, cellRenderer: function (params) {
                if (params.value == null) {
                    params.value = "YYYY-MM-DD";
                }
                return '???? ' + params.value;
            }, cellEditor: 'datePicker1'
        },

        {headerName: "????????????", field: "customerName"},

        /*{headerName: "??????", field: "reverseTypeName"},*/

       /* {headerName: "?????? ??????", field: "reverseType", hide:true},*/

        {headerName: "????????????", field: "itemCode"},

        {headerName: "????????????", field: "itemName"},

        {headerName: "???????????? ", field: "returnUnit", width: 130},

        {headerName: "????????????", field: "returnUnitPrice", width: 200},

        {headerName: "?????? ?????????", field: "returnSumPrice"},

        // {headerName: "??????", field: "description", editable: true, hide: false, width: 200},
    ];
    // event.colDef.field
    let rowData = [];
    let contractMpsRowNode;
    let itemRowNode;
    // ????????? ???????????????
    let returnAbleListGridOptions = {
        defaultColDef: {
            flex: 1,
            minWidth: 100,
            resizable: true,
        },
        columnDefs: Column,
        rowSelection: 'multiple',
        rowData: rowData,
        getRowNodeId: function (data) {
            return data.deliveryNO;
        },
        defaultColDef: {editable: false, resizable: true},
        overlayNoRowsTemplate: "?????? ????????? ???????????? ????????????.",
        onGridReady: function (event) {// onload ???????????? ?????? ready ?????? ????????? ????????? ????????????.
            event.api.sizeColumnsToFit();
        },
        onGridSizeChanged: function (event) {
            event.api.sizeColumnsToFit();
        },

        onRowClicked: function (event) {

            contractMpsRowNode = event;
        },
        getSelectedRowData() {
            let selectedNodes = this.api.getSelectedNodes();
            let selectedData = selectedNodes.map(node => node.data);
            return selectedData;
        },
        getSelectedRowDatas() {
            const selectedDatas = this.api.getSelectedRows();
            return selectedDatas;
        },
        onCellDoubleClicked: (event) => {
            if (event != undefined) {

                let rowNode = returnAbleListGridOptions.api.getDisplayedRowAtIndex(event.rowIndex);  //getDisplayedRowAtIndex: ????????? ?????? ????????? ??????
                itemRowNode = rowNode;
                console.log("#########"+itemRowNode.data.customerName);
            }

            if (event.colDef.field == "returnUnit") {
                amountList.click();
            }

            if (event.colDef.field == "reverseTypeName") { // ????????????  contractTypeName ??????
                console.log("?????????????????? ??????"); // ???????????? ??????
                reverseTypeList.click(); // ?????????????????? ??? ????????????.
            }
        },
        components: {
            datePicker1: getDatePicker(""),
            datePicker2: getDatePicker("scheduledEndDate")
        }
    }
    // ????????? ????????? ??????
    let returnListGridOptions = {
        defaultColDef: {
            flex: 1,
            minWidth: 100,
            resizable: true,
        },
        columnDefs: Column,
        rowSelection: 'multiple',
        rowData: rowData,
        // getRowNodeId: function (data) {
        //     return data.contractDetailNo;
        // },
        defaultColDef: {editable: false, resizable: true},
        overlayNoRowsTemplate: "?????? ?????? ????????? ???????????????.",
        onGridReady: function (event) {// onload ???????????? ?????? ready ?????? ????????? ????????? ????????????.
            event.api.sizeColumnsToFit();
        },
        onGridSizeChanged: function (event) {
            event.api.sizeColumnsToFit();
        },
        /*onCellEditingStarted: (event) => {
        },*/
        onRowClicked: function (event) {
            console.log(event.data);
            contractMpsRowNode = event;
        },
        getSelectedRowData() {
            let selectedNodes = this.api.getSelectedNodes();
            let selectedData = selectedNodes.map(node => node.data);
            return selectedData;
        },

        components: {
            datePicker1: getDatePicker("mpsPlanDate"),
            datePicker2: getDatePicker("scheduledEndDate")
        }
    }



    ////////////////////////////////////?????? ?????? ??????/////////////////////////////////////////////////


    const contractCandidateSearchBtn = document.querySelector("#contractCandidateSearchButton");

    contractCandidateSearchBtn.addEventListener("click", () => {
        // o contractDate or dueDateOfContract

        let startDate = startDatePicker.value;
        let endDate = endDatePicker.value;

        // o detect error
        if (startDate == "" || endDate == "") {
            Swal.fire("??????", "??????????????? ??????????????? ????????????????????????.", "info");
            return;
        }
        console.log(startDate);
        console.log(endDate);
        ableContractInfo = {"startDate": startDate, "endDate": endDate};
        ableContractInfo = encodeURI(JSON.stringify(ableContractInfo));
        // o reset Grid

        // o ajax
        let xhr = new XMLHttpRequest();
        xhr.open('GET', "${pageContext.request.contextPath}/sales/ReturnAbleList"
            + "?method=getReturnAbleList"
            // + "&searchCondition=" + searchCondition
            + "&ableContractInfo=" + ableContractInfo,
            true);

        xhr.setRequestHeader('Accept', 'application/json');
        xhr.send();
        console.log(xhr + "xhr")
        console.log(xhr);
        xhr.onreadystatechange = () => {
            if (xhr.readyState == 4 && xhr.status == 200) {
                let txt = xhr.responseText;
                txt = JSON.parse(txt);
                console.log("@@@@@")
                console.log(txt);
                let gridRowJson = txt.gridRowJson;  // gridRowJson : ???????????? ?????? json ????????? data
                if (gridRowJson == "") {
                    swal.fire("??????????????? ????????? ????????????.");
                    return;
                }

                console.log("girdRowJson?????????")
                console.log(gridRowJson);
                returnAbleListGridOptions.api.setRowData(gridRowJson);
            }
        }

    });


    /////////////////////////////////////////????????????///////////////////////////////////////////


    const returnBtn = document.querySelector("#ReturnRegistersButton");

    returnBtn.addEventListener("click", () => {
        //???????????? ???????????????????????? DB??? ??????

        let selectedNodes = returnAbleListGridOptions.api.getSelectedNodes();
        // o No seleted Nodes
        if (selectedNodes == "") {
            Swal.fire({
                position: "top",
                icon: 'error',
                title: '?????? ??????',
                text: '????????? ??????????????? ????????????.',
            })
            return;
        }

        let deliveryNO; // ???????????? ????????????
        let itemCode; //????????????
        let returnUnit; // ???????????????



        selectedNodes.map(selectedData => {
            deliveryNO=selectedData.data.deliveryNO;
            itemCode=selectedData.data.itemCode;
            returnUnit=selectedData.data.returnUnit;

            console.log("$$"+selectedData.data.deliveryNO);
            console.log("##"+selectedData.data.returnUnit);


        });

        let resultArray={"deliveryNO":deliveryNO ,"itemCode":itemCode,"returnUnit":returnUnit};

        resultArray=JSON.stringify(resultArray);

        console.log("$$$$$$$$$$"+resultArray);
        Swal.fire({
            title: '???????????? ??????',
            text:  deliveryNO + "??? ?????????????????????????",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            cancelButtonText: '??????',
            confirmButtonText: '??????',
        }).then( (result) => {
            if (result.isConfirmed) {
                let xhr = new XMLHttpRequest();

                //let today = now.getFullYear() + "-" + (now.getMonth() +1 ) + "-" +  now.getDate();
                xhr.open('POST', "${pageContext.request.contextPath}/sales/ReturnRegister?"
                    + "method=registerReturn"
                    //+ "&batchList=" + encodeURI(resultArray),
                    ,true);
                xhr.setRequestHeader('Content-Type', 'application/json');
                xhr.send(resultArray);
                xhr.onreadystatechange = () => {
                    if (xhr.readyState == 4 && xhr.status == 200) {

                        // ????????? ??????
                        let txt = xhr.responseText;
                        txt = JSON.parse(txt);

                        if (txt.errorCode < 0) {
                            Swal.fire("??????", txt.errorMsg, "error");
                            return;
                        }
                        // ?????????
                        returnAbleListGridOptions.api.setRowData([]);
                        //processPlaneGridOptions.api.setRowData([]);

                        Swal.fire({
                            title: "??????????????? ?????????????????????.",
                            html:"?????? ?????? ?????? : " + deliveryNO,
                            icon: "success",
                        });
                    }
                };
            }})
    });

    ///////////////////////////?????? ?????? ??????////////////////////////////////////////

    const showReturnList = () => {

        let xhr = new XMLHttpRequest();
        xhr.open('GET', '${pageContext.request.contextPath}/sales/ReturnList' +
            "?method=getReturnList",
            true)
        xhr.setRequestHeader('Accept', 'application/json');
        xhr.send();
        xhr.onreadystatechange = () => {
            if (xhr.readyState == 4 && xhr.status == 200) {
                let txt = xhr.responseText;
                txt = JSON.parse(txt);
                if (txt.errorCode < 0) {
                    swal.fire("??????", txt.errorMsg, "error");
                    return;
                }
                console.log(txt);
                returnListGridOptions.api.setRowData(txt.gridRowJson);
            }
        }
    }
    const returnListBtn = document.querySelector("#returnListSearchButton");

    returnListBtn.addEventListener("click", () => {
        console.log("?????? ?????? ??????")
        showReturnList();
    })

    ///////////////////////////////////?????? ?????? ??????/////////////////////////////////



    const deleteListBtn = document.querySelector("#deleteListButton")
    deleteListBtn.addEventListener("click", () => {
        deleteReturnList();
    })

    deleteReturnList=() => { // ???????????? ?????? ?????????
        //xhr??? ????????? ???????????? ????????? url?????? ???????????? ??????????????????
        selectedRows = returnListGridOptions.getSelectedRowData();
        let ableReturnIn = JSON.stringify(selectedRows);
        let ableReturnInfo = encodeURI(ableReturnIn)
        let xhr = new XMLHttpRequest();
        xhr.open('GET', "${pageContext.request.contextPath}/sales/DeleteReturnList"
            + "?method=getDeleteReturnList"
            + "&ableReturnInfo=" + ableReturnInfo
            , true);
        xhr.setRequestHeader('Accept', 'application/json');
        xhr.send();
        xhr.onreadystatechange = () => {
            if (xhr.readyState == 4 && xhr.status == 200) {
                let txt = xhr.responseText;
                txt = JSON.parse(txt);
                console.log("selectedRows")
                console.log(selectedRows)
                if (selectedRows.length == 0) {
                    Swal.fire("??????", "????????? ???????????? ??????????????????.", "error");
                    return;
                } else if (txt.errorCode < 0) {
                    Swal.fire("??????", txt.errorMsg, "error");
                    return;
                }Swal.fire("??????", "????????? ?????????????????????", "info");
                returnListGridOptions.api.setRowData(txt.gridRowJson);
            }
        }
    }


    ///////////////////////////////////////////////////////////////////////////
    // O getDataPicker
    function getDatePicker(paramFmt) {
        let _this = this;
        _this.fmt = "yyyy-mm-dd";


        // function to act as a class
        function Datepicker() {
        }

        Datepicker.prototype.init = function (params) {
            // create the cell
            this.autoclose = true;
            this.eInput = document.createElement('input');
            this.eInput.style.width = "100%";
            this.eInput.style.border = "0px";
            this.cell = params.eGridCell;
            this.oldWidth = this.cell.style.width;
            this.cell.style.width = this.cell.previousElementSibling.style.width;
            this.eInput.value = params.value;
            console.log(paramFmt);
            // Setting startDate and endDate
            let _startDate = new Date();
            let _endDate;
            let year = _startDate.getFullYear();              //yyyy
            let month = (1 + _startDate.getMonth());          //M
            month = month >= 10 ? month : '0' + month;  //month ???????????? ??????
            let day = _startDate.getDate();                   //d
            day >= 10 ? day : '0' + day;          //day ???????????? ??????
            _startDate = year + '' + month + '' + day;
            _endDate = _startDate
            console.log(contractMpsRowNode);
            if (paramFmt == "scheduledEndDate") {
                _endDate = contractMpsRowNode.data.dueDateOfContract;
                console.log(_endDate);
            }

            $(this.eInput).datepicker({
                startDate: _startDate,
                endDate: _endDate,
                dateFormat: _this.fmt
            }).on('change', function () {
                returnAbleListGridOptions.api.stopEditing();
                $(".datepicker-container").hide();
            });
        };
        // gets called once when grid ready to insert the element
        Datepicker.prototype.getGui = function () {
            return this.eInput;
        };

        // focus and select can be done after the gui is attached
        Datepicker.prototype.afterGuiAttached = function () {
            this.eInput.focus();
            console.log(this.eInput.value);
        };

        // returns the new value after editing
        Datepicker.prototype.getValue = function () {
            console.log(this.eInput);
            return this.eInput.value;
        };

        // any cleanup we need to be done here
        Datepicker.prototype.destroy = function () {
            returnAbleListGridOptions.api.stopEditing();
        };
        return Datepicker;
    }

    // O setup the grid after the page has finished loading
    document.addEventListener('DOMContentLoaded', () => {
        new agGrid.Grid(myGrid, returnAbleListGridOptions);
        new agGrid.Grid(myGrid2, returnListGridOptions);
    })

    //--------------------------------------??????---------------------------------------

    amountList.addEventListener('click', () => { // amountList ??? ???????????? ??? ???????????? ?????????
        (returnAbleListGridOptions.getSelectedRowData()).forEach((val)=>{  //val = ????????? row??????

            document.querySelector("#returnAmountBox").value=val.returnUnit;
            document.querySelector("#unitPriceOfReturnBox").value=val.returnUnitPrice;
            document.querySelector("#sumPriceOfReturnBox").value=
                document.querySelector("#returnAmountBox").value*document.querySelector("#unitPriceOfReturnBox").value;
        })
    });

    $("#amountModal").on('show.bs.modal', function () {

                $('#returnAmountBox, #unitPriceOfReturnBox').on("keyup", function () {
                    let sum =  parseInt($('#returnAmountBox').val()) *  parseInt($('#unitPriceOfReturnBox').val());  //sum?????? ??????????????? ??????????????? ????????? ?????? ????????????.
                    $('#sumPriceOfReturnBox').val(sum);  //  ????????? ??????????????? ?????? sum??? ??????
            });
        }
    );

    document.querySelector("#amountSave").addEventListener("click", () => {  //modal??? ?????? ?????? Save??? ????????? ?????????
        if (itemRowNode == undefined) {   return;}
        returnAbleListGridOptions.api.stopEditing();
        itemRowNode.setDataValue("returnUnit", $('#returnAmountBox').val());
        itemRowNode.setDataValue("returnUnitPrice", $('#unitPriceOfReturnBox').val());
        itemRowNode.setDataValue("returnSumPrice", $('#sumPriceOfReturnBox').val());
        let newData = itemRowNode.data; // ?????? ????????? ????????? ????????????,????????????,???????????? ??????????????? newData?????? ???????????? ?????????.
        itemRowNode.setData(newData);  // ????????? itemRowNode??? set?????????.  ??? ?????? ?????????????????? ??????
    })

    reverseTypeList.addEventListener("click", () => { // ???????????? ????????? ???????????????
        getListData("RL");//modal.js?????? getListDate ????????? ??????. ??????????????? ?????????
        $("#listModalTitle").text("REVERSE TYPE"); // ??????????????? ????????? contract type?????? ??????
    }, {once: true});




</script>
</body>
</html>