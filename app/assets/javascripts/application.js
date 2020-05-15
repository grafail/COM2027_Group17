// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require popper
//= require jquery.slick
//= require magnific-popup
//= require owl.carousel
//= require gmaps/google
//= require activestorage
//= require turbolinks
//= require_tree .
//= require main
//= require events
//= require bootstrap-sprockets
//= require bootstrap-slider
//= require toastr
//= require rails.validations

document.addEventListener('DOMContentLoaded', function() {
    AOS.init();
});

$('.input-daterange').datepicker({
    clearBtn: true,
    autoclose: true,
    todayHighlight: true
});

$(function(){
    $('.slider-range').slider({
        range: true,
        values: [ 25, 100 ],
        min: 0,
        max: 250,
        step: 5,
        slide: function( event, ui ) {
            $("#max").val("£" + ui.values[1]);
            $("#min").val("£" + ui.values[0]);
        }
    });
    $( "#max" ).val( "£" + $( ".slider-range" ).slider( "values", 1 ));
    $( "#min" ).val( "£" + $( ".slider-range" ).slider("values", 0 ));
});

$(document).on('shown.bs.modal', '.modal', function() {
    $('form[data-client-side-validations]').enableClientSideValidations();
});
