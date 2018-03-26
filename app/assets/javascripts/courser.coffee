# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

actioncable_methods =
  connected: ->
    console.log 'connected to CourseChannel'

  disconnected: ->

  received: (data) ->
    console.log "Receive message #{data.currency_sign}:#{data.rate} from CourseChannel"
    App.vue.receiveMessage data


App.course_sync = App.cable.subscriptions.create { channel: "CourseChannel" }, actioncable_methods


$ ->
  $('#datetimepicker').datetimepicker({
    format: 'Y-M-D h:mm a ZZ'
    })
  return
