$ = jQuery

@Sync =

  ready: false
  readyQueue: []

  init: ->
    $ =>
      return unless SyncConfig? && Sync[SyncConfig.adapter]
      @adapter ||= new Sync[SyncConfig.adapter]
      return if @isReady() || !@adapter.available()
      @ready = true
      @connect()
      @flushReadyQueue()
      @bindUnsubscribe()


  # Handle Turbolinks teardown, unsubscribe from all channels before transition
  bindUnsubscribe: ->
    $(document).bind "page:before-change", => @adapter.unsubscribeAll()
    $(document).bind "page:restore", => @reexecuteScripts()


  # Handle Turbolinks cache restore, re-eval all sync script tags
  reexecuteScripts: ->
    for script in $("script[data-sync-id]")
      eval($(script).html())


  onConnectFailure: (error) -> #noop

  connect: -> @adapter.connect()

  isConnected: -> @adapter.isConnected()

  onReady: (callback) ->
    if @isReady()
      callback()
    else
      @readyQueue.push callback


  flushReadyQueue: ->
    @onReady(callback) for callback in @readyQueue
    @readyQueue = []


  isReady: -> @ready

  camelize: (str) ->
    str.replace /(?:^|[-_])(\w)/g, (match, camel) -> camel?.toUpperCase() ? ''


  # Find View class to render based on partial and resource names
  # The class name is looked up based on
  #  1. The camelized version of the concatenated snake case resource
  #     and partial names.
  #  2. The camelized version of the snake cased partialName.
  #
  # Examples
  #   partialName 'list_row', resourceName 'todo', order of lookup:
  #   Sync.TodoListRow
  #   Sync.ListRow
  #   Sync.View
  #
  # Defaults to Sync.View if no custom view class has been defined
  viewClassFromPartialName: (partialName, resourceName) ->
    Sync[@camelize("#{resourceName}_#{partialName}")] ?
    Sync[@camelize(partialName)] ?
    Sync.View


class Sync.Adapter

  subscriptions: []

  unsubscribeAll: ->
    subscription.cancel() for subscription in @subscriptions
    @subscriptions = []

  # If the channel is already subscribed, we do two things:
  #   1. cancel() the subscription
  #   2. remove the channel from our @subscriptions array
  unsubscribeChannel: (channel) ->
    for sub, index in @subscriptions when sub.channel is channel
      sub.cancel()
      @subscriptions.splice(index, 1)
      return

  subscribe: (channel, callback) ->
    @unsubscribeChannel(channel)
    subscription = new Sync[SyncConfig.adapter].Subscription(@client, channel, callback)
    @subscriptions.push(subscription)
    subscription


class Sync.Faye extends Sync.Adapter

  subscriptions: []

  available: ->
    !!window.Faye

  connect: ->
    @client = new window.Faye.Client(SyncConfig.server)

  isConnected: -> @client?.getState() is "CONNECTED"


class Sync.Faye.Subscription

  constructor: (@client, channel, callback) ->
    @channel = channel
    @fayeSub = @client.subscribe channel, callback

  cancel: ->
    @fayeSub.cancel()


class Sync.Pusher extends Sync.Adapter

  subscriptions: []

  available: ->
    !!window.Pusher

  connect: ->
    opts =
      encrypted: SyncConfig.pusher_encrypted

    opts.wsHost = SyncConfig.pusher_ws_host if SyncConfig.pusher_ws_host
    opts.wsPort = SyncConfig.pusher_ws_port if SyncConfig.pusher_ws_port
    opts.wssPort = SyncConfig.pusher_wss_port if SyncConfig.pusher_wss_port

    @client = new window.Pusher(SyncConfig.api_key, opts)

  isConnected: -> @client?.connection.state is "connected"

  subscribe: (channel, callback) ->
    @unsubscribeChannel(channel)
    subscription = new Sync.Pusher.Subscription(@client, channel, callback)
    @subscriptions.push(subscription)
    subscription


class Sync.Pusher.Subscription
  constructor: (@client, channel, callback) ->
    @channel = channel

    pusherSub = @client.subscribe(channel)
    pusherSub.bind 'sync', callback

  cancel: ->
    @client.unsubscribe(@channel) if @client.channel(@channel)?



class Sync.View

  removed: false

  constructor: (@$el, @name) ->

  beforeUpdate: (html, data) -> @update(html)

  afterUpdate: -> #noop

  beforeInsert: ($el, data) -> @insert($el)

  afterInsert: -> #noop

  beforeRemove: -> @remove()

  afterRemove: -> #noop

  isRemoved: -> @removed

  remove: ->
    @$el.remove()
    @$el = $()
    @removed = true
    @afterRemove()


  bind: -> #noop

  show: -> @$el.show()

  update: (html) ->
    $new = $($.trim(html))
    @$el.replaceWith($new)
    @$el = $new
    @afterUpdate()
    @bind()


  insert: ($el) ->
    @$el.replaceWith($el)
    @$el = $el
    @afterInsert()
    @bind()


class Sync.WhiteboardWhiteboardcondition extends Sync.View
    afterUpdate: -> `$(document).ready(function(){

              $("#whiteboardsend").click(function(){
                $("#whiteboardform").submit();
              });

              $("#whiteboardchange").click(function(){
                $("#whiteboardchangeform").submit();
              });
            });`


class Sync.MessageNewmessages extends Sync.View

      `var temp = true;`
      beforeInsert: ($el, data) ->
        `$(document).ready(function(){

            var elem = $('#chatbox');
            if(elem[0].scrollHeight - elem.scrollTop() <= elem.outerHeight()){
                temp = true;

            } else {
                temp = false;
            }

        });`

        @insert($el)

      afterInsert: -> `$(document).ready(function(){


                  if($('#checkpoint').val() == "false"){
                    $('#checkpoint').val("true");
                    $("#messagelookall").submit();
                  }
                  var newval = $('#messagelookid').val();
                  $('#messagelookid').val(parseInt(newval)+1);
                  $("#messagelook").submit();
                  if(temp){
                      var images = document.getElementsByClassName('imagemessages');
                      images[images.length-1].addEventListener("load", imgload);
                      var ta = document.getElementById('chatbox');
                      ta.scrollTop = ta.scrollHeight;

                  }
                });`

class Sync.Partial

  attributes:
    name: null
    resourceName: null
    resourceId: null
    authToken: null
    channelUpdate: null
    channelDestroy: null
    selectorStart: null
    selectorEnd: null
    refetch: false

    subscriptionUpdate: null
    subscriptionDestroy: null

  # attributes
  #
  #   name - The String name of the partial without leading underscore
  #   resourceName - The String undercored class name of the resource
  #   resourceId
  #   authToken - The String auth token for the partial
  #   channelUpdate - The String channel to listen for update publishes on
  #   channelDestroy - The String channel to listen for destroy publishes on
  #   selectorStart - The String selector to mark beginning in the DOM
  #   selectorEnd - The String selector to mark ending in the DOM
  #   refetch - The Boolean to refetch markup from server or receive markup
  #             from pubsub update. Default false.
  #
  constructor: (attributes = {}) ->
    @[key] = attributes[key] ? defaultValue for key, defaultValue of @attributes
    @$start = $("[data-sync-id='#{@selectorStart}']")
    @$end   = $("[data-sync-id='#{@selectorEnd}']")
    @$el    = @$start.nextUntil(@$end)
    @view   = new (Sync.viewClassFromPartialName(@name, @resourceName))(@$el, @name)
    @adapter = Sync.adapter


  subscribe: ->
    @subscriptionUpdate = @adapter.subscribe @channelUpdate, (data) =>
      if @refetch
        @refetchFromServer (html) => @update(html)
      else
        @update(data.html)

    @subscriptionDestroy = @adapter.subscribe @channelDestroy, => @remove()


  update: (html) -> @view.beforeUpdate(html, {})

  remove: ->
    @view.beforeRemove()
    @destroy() if @view.isRemoved()


  insert: (html) ->
    if @refetch
      @refetchFromServer (html) => @view.beforeInsert($($.trim(html)), {})
    else
      @view.beforeInsert($($.trim(html)), {})


  destroy: ->
    @subscriptionUpdate.cancel()
    @subscriptionDestroy.cancel()
    @$start.remove()
    @$end.remove()
    @$el?.remove()
    delete @$start
    delete @$end
    delete @$el


  refetchFromServer: (callback) ->
    $.ajax
      type: "GET"
      url: "/sync/refetch.json"
      data:
        auth_token: @authToken
        partial_name: @name
        resource_name: @resourceName
        resource_id: @resourceId
      success: (data) -> callback(data.html)


class Sync.PartialCreator

  attributes:
    name: null
    resourceName: null
    authToken: null
    channel: null
    selector: null
    direction: 'append'
    refetch: false

  # attributes
  #
  #   name - The String name of the partial without leading underscore
  #   resourceName - The String undercored class name of the resource
  #   channel - The String channel to listen for new publishes on
  #   selector - The String selector to find the element in the DOM
  #   direction - The String direction to insert. One of "append" or "prepend"
  #   refetch - The Boolean to refetch markup from server or receive markup
  #             from pubsub update. Default false.
  #
  constructor: (attributes = {}) ->
    @[key] = attributes[key] ? defaultValue for key, defaultValue of @attributes
    @$el = $("[data-sync-id='#{@selector}']")
    @adapter = Sync.adapter


  subscribe: ->
    @adapter.subscribe @channel, (data) =>
      @insert data.html,
              data.resourceId,
              data.authToken,
              data.channelUpdate,
              data.channelDestroy,
              data.selectorStart,
              data.selectorEnd


  insertPlaceholder: (html) ->
    switch @direction
      when "append"  then @$el.before(html)
      when "prepend" then @$el.after(html)



  insert: (html, resourceId, authToken, channelUpdate, channelDestroy, selectorStart, selectorEnd) ->
    @insertPlaceholder """
      <script type='text/javascript' data-sync-id='#{selectorStart}'></script>
      <script type='text/javascript' data-sync-el-placeholder></script>
      <script type='text/javascript' data-sync-id='#{selectorEnd}'></script>
    """
    partial = new Sync.Partial(
      name: @name
      resourceName: @resourceName
      resourceId: resourceId
      authToken: authToken
      channelUpdate: channelUpdate
      channelDestroy: channelDestroy
      selectorStart: selectorStart
      selectorEnd: selectorEnd
      refetch: @refetch
    )
    partial.subscribe()
    partial.insert(html)

Sync.init()
