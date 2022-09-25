/**
 * Javascript reply ajax Module
 */



console.log("Reply Module....")



//var test = (function(){})
var replyService = (function(){

    // a라는 결과로 어떻게 할지 모르기 때문에, 이 함수를 사용한 쪽에서 활용하는 것으로 목적을 둔다.
	// 그리하여 callback 함수를 넣고 리턴한다. 오류가 날 수 있으므로 error를 전달한다.
	// 필요에 따라 사용하되, 순서는 지키면 된다. 
    // 댓글 추가
    function add(reply, callback, error) {
        console.debug("- js - add(reply, callback, error) invoked.");
        console.log("\t+ reply: " + reply);
        console.log("\t+ callback: " + callback);
        console.log("\t+ error: " + error);


        $.ajax({
            url: '/reply/new',
            type: 'POST',
            data: JSON.stringify(reply),      //json으로 변환

            //내가 전달할 데이터의 타입이 무엇인가. 안에 내장된 내용의 타입을 보내는 것
            contentType: "application/json; charset=utf-8",
            success: function (result, status, xhr) {//백에서 리턴받은 결과값과 상태코드
                console.log('result:',result);
                console.log('status:',status);
                console.log('xhr:',xhr);

                if(callback){//인자로 받은 콜백함수가 있다면
                    callback(result);

                }//if
                
            },//success
            error: function (xhr,status, er) {
                console.log('xhr:',xhr);
                console.log('status:',status);
                console.log('result:',result);

                if(error){
                    error(er);
                    
                }//if

            }//error
            
        })//.ajax

    }//add()
    
    // 댓글목록
    // 받을때는 json으로 받는다.
    function getList(param, callback, error) {
        console.debug("- js - getList(param, callback, error) invoked.");
        console.log("\t+ param: {}, callback: {}, error: {}", param, callback, error);
        // console.log("\t+ param: " + param);
        // console.log("\t+ callback: " + callback);
        // console.log("\t+ error: " + error);

        var bno = param.bno;
        console.log("\t+ var bno: " + bno); //5
        
        var page = param.page || 1;
        console.log("\t+ var page: " + page); //2

        $.getJSON("/reply/pages/" + bno + "/" + page, 
            function (data) {
                console.dir("\t+ data" + data);

                if(callback){//콜백함수가 있다면
                    // callback(data);       //댓글목록만 가져오는경우
                    callback(data.replyCnt, data.list); //댓글 숫자와 목록을 가져오는 경우
                    
                }//if
            }).fail(function (xhr, status, err) {
                if(error){
                    error();
                    
                }//if
            
        }); //$.getJSON()
        
    }//getList


    //댓글삭제
    function remove(reno, callback, error) {
        console.debug("- js - remove(reno, callback, error) invoked.");
        console.log("\t+ reno: " + reno);
        console.log("\t+ callback: " + callback);
        console.log("\t+ error: " + error);

        $.ajax({
            url: '/reply/' + reno,
            type: 'DELETE',
            success: function (deleteResult, status, xhr) {
                if(callback){
                    callback(deleteResult);

                }//if
                
            },//success
            error: function (xhr, status, er) {
                if(error){
                    error(er);
                }//if
                
            }//error
            
        });//.ajax

    }//remove


    //댓글수정
    function update(reply, callback, error) {
        console.debug("update(reply, callback, error) invoked.");
        console.log("\t+ reply: " + reply);
        console.log("\t+ callback: " + callback);
        console.log("\t+ error: " + error);

        $.ajax({
            url: '/reply/' + reply.reno,
            type: 'PUT',
            data: JSON.stringify(reply),
            contentType: "application/json; charset=utf-8",
            success: function (result, status, xhr) {
                if(callback){
                    callback(result);
                    
                }//if
                
            },//success
            error: function (xhr, status, er) {
                if(error){
                    error(er)

                }//if
                
            }//error
            
        })//ajax

    }//modify


    //댓글조회
    function get(reno, callback, error) {
        console.debug("get(reno, callback, error) invoked.");
        console.log("\t+ reno: " + reno);
        console.log("\t+ callback: " + callback);
        console.log("\t+ error: " + error);


        $.get("/reply/" + reno, function (result) {
            if(callback){
                callback(result);
            }//if
        }).fail(function (xhr, status, err) {
            if(error){
                error();
            }//if
        });
    }//get


    //시간포매팅
    function displayTime(timeValue) {
        console.debug("displayTime(timeValue) invoked.");

        var today = new Date();
        var gap = today.getTime() - timeValue;

        var dateObj = new Date(timeValue);
        var str = "";

        if(gap < (1000 * 60 * 60 * 24)){
            var hh = dateObj.getHours();
            var mi = dateObj.getMinutes();
            var ss = dateObj.getSeconds();

            return [ 
                (hh > 9 ? '' : '0') + hh, ':', 
                (mi > 9 ? '' : '0') + mi, ':', 
                (ss > 9 ? '' : '0') + ss ].join('');

        }else{
            var yy = dateObj.getFullYear();
            var mm = dateObj.getMonth() + 1; // getMonth() is zero-based
            var dd = dateObj.getDate();

            return [yy, '/', (mm > 9 ? '' : '0') + mm, '/', (dd > 9 ? '' : '0') + dd].join('');
        }
    }

    return {
        add:add,
        getList:getList,
        remove:remove,
        update:update,
        get:get,
        displayTime:displayTime
    };

})();