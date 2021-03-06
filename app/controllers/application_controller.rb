class ApplicationController < ActionController::Base
  helper Openseadragon::OpenseadragonHelper
  # Adds a few additional behaviors into the application controller
  include Blacklight::Controller
  layout 'blacklight'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_fabrique

  skip_after_action :discard_flash_if_xhr

  def set_fabrique
    #question how to manage changes here when deployed to heroku?
    #set footer_bar variables
    site = "https://dev-britishart-yale-edu-d8.pantheonsite.io"
    #site = "https://britishart.yale.edu"
    site = ENV["SITE"]
    @footer_bar_links = Array.new
    @footer_bar_links.push({:href=>"/", :title=>"Privacy and cookies"})
    @footer_bar_links.push({:href=>"https://usability.yale.edu/web-accessibility/accessibility-yale", :title=>"Accessibility at Yale"})
    @footer_bar_links.push({:href=>"#{site}/contact-us", :title=>"Contact us"})

=begin
    @footeritems = Array.new
    item1 = {:href=>"?", :title=>"Privacy & cookies"}
    items = [item1]
    @footeritems.push({:title=>"", :text=>"1080 Chapel Street,<br/>New Haven, Connecticut",:linked_list =>items})
    item1 = {:property=>"Tue &mdash; Sat", :value=>"10am &mdash; 5pm"}
    item2 = {:property=>"Sunday", :value=>"12am &mdash; 5pm"}
    item3 = {:property=>"Monday", :value=>"Closed"}
    items = [item1,item2,item3]
    @footeritems.push(:title=>"", :text=>"Admission is free",:definition_list=>items})
    item1 = {:href=>"?",:title=>"What to expect"}
    item2 = {:href=>"?",:title=>"Tours & guides"}
    item3 = {:href=>"?",:title=>"City & the region"}
    item4 = {:href=>"?",:title=>"Accessibility"}
    items = [item1,item2,item3,item4]
    @footeritems.push(:title=>"",:linked_list=>items})
    item1 = {:title=>}
=end

    @footeritems = [{text:"1080 Chapel Street<br/>New Haven, Connecticut",
                     link_list:[["Closure notice","#{site}/closure-notice-archived"]]},
                     #link_list:[["Visitor guidelines","#{site}/visitor-guidelines"]]},
                    {text:"Admission is free",
                     #definition_list:[["Tue &mdash; Sat","10am &mdash; 5pm"],
                     #           ["Sunday","12am &mdash; 5pm"],
                     #           ["Monday","Closed"]]},
                    },
                    {link_list:[["Tours","#{site}/tours"],
                                ["City and region","#{site}/city-and-region"],
                                ["Directions and parking","#{site}/directions-and-parking"],
                                ["Accessibility","#{site}/accessibility"],
                                ["Museum Shop","#{site}/museum-shop"]]},
                    {follow_buttons:"true"},
                    {title:"Exhibitions and programs",
                     link_list:[["Now and upcoming","#{site}/exhibitions-programs"],
                                ["Past exhibitions","#{site}/exhibitions-programs-past"]]},
                    {title:"Collections",
                     link_list:[["Search the collections","https://collections.britishart.yale.edu"],
                                ["Conservation","#{site}/conservation"]
                      #          ["Highlights","?"],
                      #          ["How to use the collection","?"]]},
                    ]},
                    {title:"Research and Learning",
                     link_list:[["Community","#{site}/community"],
                                ["K—12 teachers","#{site}/k-12-teachers"],
                                ["Colleges and universities","#{site}/colleges-and-universities"],
                                ["Yale community","#{site}/yale-community"],
                                ["Residential scholars","#{site}/residential-scholars"],
                                ["Publications","#{site}/publications"],
                                ["Reference Library","#{site}/reference-library-and-photograph-archive"],
                                ["Study Room","#{site}/study-room"]]},
                    {title:"About us",
                     link_list:[["Our story","#{site}/our-story"],
                                ["Paul Mellon, Founder","#{site}/stories/paul-mellon-founder"],
                                ["From the Director","#{site}/director"],
                                ["Architecture","#{site}/architecture"],
                                ["News and Press","#{site}/news-and-press"],
                                ["Videos","#{site}/videos"],
                                ["Get involved","#{site}/get-involved"],
                                ["Contact us","#{site}/contact-us"]]}]
  end
end
