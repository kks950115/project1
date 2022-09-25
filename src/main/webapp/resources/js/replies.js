
console.log("Reply Module...............");

// var test = (function(){ 여기에 함수들 넣어서 쓴다. 클래스 생성하듯이 쓰네 })();
var replyService = (function(){

    // 리플생성
    function add(reply, callback,error){//reply객체, 콜백함수
        console.log('add(reply, callback) invoked...',reply, callback);

        $.ajax({
            type:'POST',
            url: '/replies/new',
            data: JSON.stringify(reply),//json으로 변환
            contentType: 'application/json; charset=utf-8',
            success: function(result,status,xhr){//백에서 리턴받은 결과값과 상태코드
                console.log('result:',result);
                console.log('status:',status);
                console.log('xhr:',xhr);

                if(callback){//인자로 받은 콜백함수가 있다면
                    callback(result);
                }//if

            },//success
            error : function(xhr,status,er){
                console.log('xhr:',xhr);
                console.log('status:',status);
                console.log('er:',er);

                if(error){
                    error(er);
                }//if
            }//error
        })//ajax
    }//add
    

    // 리플리스트 출력
    function getList(param, callback, error){
        var bno = param.bno;
        console.log('bno:',bno);

        var page = param.page || 1;
        console.log('page:',page);    
        
        $.getJSON("/replies/pages/"+bno+"/"+page, function(data){

                if(callback){//콜백함수가 있다면
                    callback(data.list, data.replyCnt);
                }//if
            }).fail(function(xhr,status,er){
                if(error){
                    error(er);
                }//if
        });//getJSON ( function(data).fail() )
        
    }//getList

// 댓글 삭제
    function remove(reno, callback, error){
        $.ajax({
            type : 'delete',
            url : '/replies/'+reno,
            success : function(deleteResult, status, xhr){
                if(callback){//콜백함수가 있다면
                    callback(deleteResult);
                }//if
            },//success
            error : function(xhr,status,er){
                if(error){
                    error(er);
                }//if
            }//error
        })//.ajax
        
    }//remove


// 댓글 수정
    function update(reply, callback, error){
        console.log(reply.reno);

        $.ajax({
            type: 'put',
            url: '/replies/'+reply.reno,
            data: JSON.stringify(reply),
            contentType: 'application/json; charset=utf-8',
            success: function(result,status,xhr){
                if(callback){
                    callback(result);
                }//if
            },//success
            error: function(xhr,status,er){
                if(error){
                    error(er);
                }//if
            }//error
        })//ajax

    }//update


// 댓글 한개 조회
    function get(reno, callback, error){
        console.log("reno:",reno)
        $.get("/replies/"+reno,function(result){
            
            if(callback){
                callback(result);//vo한개 받아옴
            }//if

        }).fail(function(xhr,status,err){
            if(error){
                error(err);
            }//if
        });//.get ( function(result).fail() )
    }//get


    // 시간변환
    function displyTime(timeValue){
        var today = new Date();//현재날짜 객체 생성
        var gap = today.getTime() - timeValue;//현재시간 - 등록시간

        var dateObj = new Date(timeValue);//등록일자 객체 생성

        if( gap < (1000 * 60 * 60 * 24 )){//24시간보다 작을 때 시간으로 표기
            var hh = dateObj.getHours();
            var mi = dateObj.getMinutes();
            var ss = dateObj.getSeconds();

            //2자릿수로 맞추기(join함수는 연결용)
            return [ (hh > 9 ? '' : '0')+ hh, ':',(mi > 9 ? '':'0')+ mi, ':', (ss > 9 ? '':'0')+ ss].join('');

        } else {// 24시간이 지났을 때 날짜로 표기
            var yy = dateObj.getFullYear();
            var mm = dateObj.getMonth()+1; //기본이 0월이라 1을 더해줌
            var dd = dateObj.getDate();

            return [ yy,'/',(mm > 9 ? '' : '0')+ mm,'/',(dd > 9 ? '' : '0')+dd].join('');
        }//if-else

    }//displyTime


    return {
        add: add, //add함수 리턴
        getList : getList, //getList함수 리턴
        remove : remove,
        update : update,
        get : get,
        displyTime : displyTime
    };//return
})();//replyService


