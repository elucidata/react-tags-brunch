react_dom= require('react').DOM
tagParser= /_?this\.([\w|_]*)\(/g
escapedTag= /[\w]*_$/
taglist= null

module.exports= (source, blacklist=[])->
  taglist=[]

  source.replace tagParser, (fragment, tag)->

    return fragment if tag in blacklist

    if escapedTag.test(tag)
      shortTag= tag.substring(0, tag.length - 1)

      if shortTag in blacklist
        taglist.push shortTag unless shortTag in taglist
        return "React.DOM.#{ shortTag }("

    if react_dom.hasOwnProperty(tag)
      taglist.push tag unless tag in taglist
      return "React.DOM.#{ tag }("

    return fragment

module.exports.lastTags= -> taglist
