/**
 * Created by Dan on 4/30/14.
 */

$(document).ready(function() {
    $('.js-pick-course-button').click(function(){
        $(this).toggleClass('alert');
        return false;
    });
    $('.js-pick-courses-form').submit(function(){
        var selected_course_ids = $('.js-pick-course-button.alert').map(function () {
            return $(this).data('course_id')
        }).get();
        $('#course_ids').val(selected_course_ids);
    });
});
