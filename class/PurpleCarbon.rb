#!/usr/bin/env ruby
require 'Nokogiri'
require 'YAML'

class PurpleCarbon

  def CreateConfig(project)

    config = YAML.load_file('../carbon.yaml')

    @doc = Nokogiri::XML(File.read "../config.xml")

    # Name of App
    name = @doc.at_css "widget name"
    name.content = config['apps'][project]['name']

    # Description of app
    description = @doc.at_css "widget description"
    description.content = config['apps'][project]['description']

    # Informations of Author
    author = @doc.at_css "widget author"
    author.content = config['apps'][project]['author']['name']
    author['email'] = config['apps'][project]['author']['email']
    author['href'] = config['apps'][project]['author']['href']

    # Informations of App
    widget = @doc.at_css "widget"
    widget['id'] = config['apps'][project]['widget']['id']
    widget['version'] = config['apps'][project]['widget']['version']

    File.open("../config.xml", "w") {|f| f.write(@doc.to_xml) }

    system("cd ../ && ionic cordova resources")

    # system("cd ../ &&
    #         ionic cordova plugin save &&
    #         ionic cordova platform rm ios &&
    #         ionic cordova platform add ios &&
    #         ionic cordova prepare ios &&
    #         ionic cordova build ios")

    system("cd ../ &&
            ionic cordova prepare android &&
            ionic cordova build android")

    # system("cd ../ && ionic cordova run android --device")

  end

end
