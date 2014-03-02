# Description:
#   Search for HTAs
#
# Dependencies:
#   HtaHub - https://github.com/gaving/htahub/
#   Htaize - https://github.com/gaving/htaize/
#
# Configuration:
#   None
#
# Commands:
#   hubot hta me (.*)
#
# Author:
#   gaving
#

querystring = require('querystring')

htaHub = process.env.HUBOT_HTAHUB_URL or 'http://localhost/htahub/'

htaMe = (msg, query) ->
  params = querystring.stringify(name: query, url: query)
  msg.http("#{htaHub}app/htas?#{params}")
    .get() (err, res, body) ->
      results = JSON.parse body
      results.forEach (hta) ->
        msg.send("#{hta.name} => #{hta.url.replace('http', 'hta')}")

module.exports = (robot) ->
  robot.respond /hta me (.*)/i, (msg) ->
    htaMe msg, msg.match[1]
