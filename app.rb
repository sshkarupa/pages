
require 'sinatra'
require 'slim'
require 'sass'


# get('/styles.css'){ sass :styles, :style => :compressed, :views => './' }
get('/styles.css'){ content_type 'text/css', :charset => 'utf-8' ; sass :styles }

set :pages, %w[images videos maps news shopping]

helpers do
  def current?(path='') ; request.path_info=='/'+path ? 'current':  nil ; end
  def link_to_unless_current(url,text=url)
    link=request.path_info==url ? "" : "<a href=\"#{url}\">"
    link << text
    link << "</a>" unless request.path_info==url
    link
  end
end

get '/' do
  @title='Web'
  slim :web
end

settings.pages.each do |page|
  get '/'+page do
    @title = page.capitalize
    slim :page
  end
end


__END__
@@layout
doctype 5
html lang="en"
  head
    meta(charset="utf-8")
    meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport"
    title= @title || 'Give me a title!'
    link rel="stylesheet" href="/styles.css"
    /[if lt IE 9]
      script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"
  body
    == slim :nav
    img#logo src="http://www.seomofo.com/downloads/new-google-logo-official.png"
    == yield
    == slim :footer


@@nav
nav role="navigation"
  ul#google
    li
      a class=current? href='/' Home
    - settings.pages.each do |link|
      li
        a href='/#{link.downcase}' class=current?(link.downcase)
          =link.capitalize

@@footer
nav role="navigation"
  ul#footer
    li
      ==link_to_unless_current('/','Home')
    - settings.pages.each do |link|
      li
        ==link_to_unless_current('/'+link,link.capitalize)


@@web
form
  input size=41

@@page
#page
  h1= @title
  p This is the #{@title} page.

@@styles
html, body
  font: 13px/27px Arial,sans-serif
#logo
  width: 280px
  display: block
  margin: 10px auto
h1
  font-size: 28px
  color: blue
  line-height: 2
form
  width: 280px
  margin: 0 auto
#page
  width: 480px
  margin: 0 auto

#google
  background: #2d2d2d
  overflow: hidden
  li
    float: left
    display: inline
    list-style-type: none
    margin: 0
    line-height: 27px
  li a, li a:link
    padding: 0 5px
    text-decoration: none
    display: block
    color: white
    border-top: 2px solid transparent
  li a:hover
    background: #4d4d4d
  li a.current
    font-weight: bold
    border-top-color: #DD4B39

#footer
  overflow: hidden
  padding: 10px
  width: 300px
  margin: 100px auto 0
  li
    float: left
    display: inline
    list-style-type: none
    margin: 0
    font-weight: bold
    color: #DD4B39
  li a, li a:link
    padding: 0 5px
    text-decoration: none
    display: block
    color: blue
    font-weight: normal
  li a:hover
    text-decoration: underline
