nconf = require 'nconf'
md5   = require 'MD5'
fs    = require 'fs'
nconf.add 'server', type: 'file', file: './conf/server.' + process.env.NODE_ENV + '.json'

class ImageHelper
  constructor: () ->

  saveImage: (image) ->
    #code for saving an image
    imagePath = nconf.get 'paths:imagePath'
    base64Data = image.replace /^data:image\/png;base64,/, ""
    md5String = md5 base64Data
    console.log 'md5: ' + md5String
    fs.mkdir imagePath + '/' + md5String, (err) ->
      #we don't care if the folder exists
      return

    fs.writeFile imagePath + '/' + md5String + '/input.png', base64Data, 'base64', (err) ->
      console.log err
      return
    return imagePath + '/' + md5String + '/input.png'

module.exports = ImageHelper