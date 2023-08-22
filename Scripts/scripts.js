$(function () {

    $("#pnlSuccess").fadeTo(4000, 1).slideUp(2000, function () {
        $("#pnlSuccess").remove(); 
    });

    $('[data-toggle="tooltip"]').tooltip();

    $('.popover-trigger').popover('toggle');

    // Tooltips
    $(function () {
        $('[rel="tooltip"]').tooltip();
    })
    
    // Navbar highlighting active
    var url = window.location;
    $('.sidebar .sidebar-menu').find('.active').removeClass('active');
    $('.sidebar .sidebar-menu li a').each(function () {
        if (this.href == url) {
            $(this).parent().addClass('active');
        }
    });

    // Navbar - Make Parent active when child is active
    $('.sidebar .sidebar-menu li a[href$="' + $(location).attr('pathname') + '"]').parents('li.dropdown').addClass('active');
    
    $('.datetimepicker').datetimepicker({
        format: 'd-M-Y h:i a',
        ampm: true,
        defaultTime: '00:00',
        yearStart: '1900',
        maxDate: moment().format('DD-MMM-YYYY'),
        scrollMonth: false,
        scrollTime: false,
        scrollInput: false,
        step: 30
    });

    $('.datepicker').datetimepicker({
        timepicker: false,
        yearStart: '1900',
        format: 'd-M-Y',
        scrollMonth: false,
        scrollTime: false,
        scrollInput: false,
        maxDate: moment().format('DD-MMM-YYYY')
    });

    $('.timepicker').datetimepicker({
        datepicker: false,
        format: 'H:i a',
        ampm: true,
        yearStart: '1900',
        scrollMonth: false,
        scrollTime: false,
        scrollInput: false,
        step: 15
    });
    
    $('.datepickerFuture').datetimepicker({
        timepicker: false,
        yearStart: '1900',
        scrollMonth: false,
        scrollTime: false,
        scrollInput: false,
        format: 'd-M-Y'
    });
})