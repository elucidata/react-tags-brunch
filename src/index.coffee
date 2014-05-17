parser= require('./tag-parser')

module.exports = class ReactTagsPlugin
  brunchPlugin: yes
  type: 'javascript'
  pattern: /\.js|\.coffee/

  constructor: (@config) ->
    @filter= @config?.plugins?.reactTags?.fileFilter or /^(app|test)/
    @blacklist= @config?.plugins?.reactTags?.blacklist or 'object data map var'.split(' ')
    @verbose= @config?.plugins?.reactTags?.verbose or no

  compile: (params, callback) ->
    source= params.data

    return callback null, data:source unless @filter.test(params.path)

    try
      output= parser(source, @blacklist)
      taglist= parser.lastTags()

    catch err
      console.log "ERROR", err if @verbose
      return callback err.toString()

    if @verbose and taglist.length > 0
      console.log " - #{params.path}: #{ taglist.sort().join ', ' }"

    callback null, data:output
