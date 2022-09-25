/**mypage/replymanage.js
 * 
 */

$(function () {
    console.debug('jq started...2');
    
 

    // 리스트 
    $('#bname').on('change',function () {
        console.debug('bname on change event triggered');
        
        // alert(this.value);

        let searchForm = $('#replyForm');
        
        searchForm.attr('action', '/mypage/replymanage');
        searchForm.attr('method', 'GET');
        if(searchForm.find('select[name=bname]').val() == 'null'){
            searchForm.find('select[name=bname]').val('');
        }//if
        searchForm.submit();
    }); //on change
});//.jq