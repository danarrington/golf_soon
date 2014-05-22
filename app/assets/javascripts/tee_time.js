$(document).ready(function() {
    $('.filter .selected').click(function(){
        $('.unselected').toggleClass('hidden');
    });

    $('.filter .unselected.option').click(function(){
        $('.js-value-days').val($(this).data('value'));
        $('.js-filter-form').submit();
    })
});
