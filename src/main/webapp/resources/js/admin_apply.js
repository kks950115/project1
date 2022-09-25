/* apply.jsp 
 */

$(function () {
                
    $('#agreeUpdateBtn').on('click', function () {
        console.debug('agreeUpdateBtn click event triggered.. ');

        var applyForm = $('#apply');
        
        applyForm.attr('action', '/admin/applyUpdateAgree');
        applyForm.attr('method', 'POST');

        applyForm.submit();

    });// on click event

    $('#paymentUpadateBtn').on('click', function () {
        console.debug('paymentUpadateBtn click event triggered...');

        var applyForm = $('#apply');
        
        applyForm.attr('action', '/admin/applyUpdatePayment');
        applyForm.attr('method', 'POST');

        applyForm.submit();

    });// on click event
});//.jq