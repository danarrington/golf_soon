$(document).ready(function() {
    $('.filter .selected').click(function(){
        $(this).siblings().children('.unselected').toggleClass('hidden');
    });

    $('.filter .unselected.option').click(function(){
        var filter = $(this).data('filter');
        $('.js-value-'+ filter).val($(this).data('value'));
        $('.js-filter-form').submit();
    })
});
