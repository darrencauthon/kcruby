require_relative '../test_helper'

describe Meetup do

  describe "getting people from the meetup api" do

    describe "there are three people" do

      let(:first_page) do
        d = <<EOF
  {"results":[
    {"lon":-97.76,"hometown":"Austin","status":"active","link":"http:\/\/www.meetup.com\/members\/5818999","state":"TX","self":{"common":{}},"photo":{"photo_link":"http:\/\/photos1.meetupstatic.com\/photos\/member\/3\/b\/1\/c\/member_109455132.jpeg","thumb_link":"http:\/\/photos3.meetupstatic.com\/photos\/member\/3\/b\/1\/c\/thumb_109455132.jpeg","photo_id":109455132},"lang":"en_US","country":"us","city":"Austin","id":5818999,"visited":1358897864000,"topics":[{"id":455,"urlkey":"php","name":"PHP"},{"id":10117,"urlkey":"businessnetwork","name":"Business Strategy and Networking"},{"id":10209,"urlkey":"web","name":"Web Technology"},{"id":9696,"urlkey":"newtech","name":"New Technology"},{"id":563,"urlkey":"opensource","name":"Open Source"},{"id":17627,"urlkey":"programming","name":"Programming"},{"id":3833,"urlkey":"softwaredev","name":"Software Developers"},{"id":58162,"urlkey":"nosql","name":"NoSQL"},{"id":121802,"urlkey":"mongodb","name":"mongoDB"},{"id":16673,"urlkey":"couchdb","name":"couchdb"},{"id":101547,"urlkey":"couchapp","name":"Couchapp"},{"id":10553,"urlkey":"django","name":"Django"},{"id":1064,"urlkey":"python","name":"Python"},{"id":1040,"urlkey":"ruby","name":"Ruby"},{"id":15167,"urlkey":"cloud-computing","name":"Cloud Computing"},{"id":10361,"urlkey":"postgresql","name":"PostgreSQL"},{"id":33167,"urlkey":"sql","name":"SQL"}],"joined":1279120851000,"name":"Travis A","other_services":{},"lat":30.24},
    {"lon":-94.59,"status":"active","link":"http:\/\/www.meetup.com\/members\/8883285","state":"MO","self":{"common":{}},"photo":{"photo_link":"http:\/\/photos2.meetupstatic.com\/photos\/member\/d\/3\/3\/8\/member_86694072.jpeg","highres_link":"http:\/\/photos4.meetupstatic.com\/photos\/member\/d\/3\/3\/8\/highres_86694072.jpeg","thumb_link":"http:\/\/photos4.meetupstatic.com\/photos\/member\/d\/3\/3\/8\/thumb_86694072.jpeg","photo_id":86694072},"lang":"en_US","country":"us","city":"Kansas City","id":8883285,"visited":1361389986000,"topics":[{"id":1488,"urlkey":"agile","name":"Agile Software"},{"id":37339,"urlkey":"kanban","name":"Kanban"},{"id":123343,"urlkey":"lean-agile-project-management","name":"Lean-Agile Project Management"},{"id":198631,"urlkey":"limited-work-in-progress-wip","name":"Limited Work in Progress (WIP)"},{"id":3833,"urlkey":"softwaredev","name":"Software Developers"},{"id":19882,"urlkey":"entrepreneurship","name":"Entrepreneurship"},{"id":21681,"urlkey":"startup-businesses","name":"Startup Businesses"},{"id":17627,"urlkey":"programming","name":"Programming"},{"id":68186,"urlkey":"mobile-applications","name":"mobile applications"},{"id":7029,"urlkey":"javascript","name":"JavaScript"},{"id":128575,"urlkey":"node-js","name":"node.js"},{"id":21441,"urlkey":"mobile-development","name":"Mobile Development"},{"id":16471,"urlkey":"iphone-developers","name":"iPhone developers"},{"id":1040,"urlkey":"ruby","name":"Ruby"},{"id":17158,"urlkey":"startup-ventures","name":"Startup Ventures"},{"id":10579,"urlkey":"technology","name":"Internet & Technology"},{"id":827,"urlkey":"dotnet","name":".NET"},{"id":9696,"urlkey":"newtech","name":"New Technology"},{"id":16216,"urlkey":"mobile-technology","name":"Mobile Technology"},{"id":121863,"urlkey":"asp-net-mvc","name":"ASP.NET MVC"},{"id":15582,"urlkey":"web-development","name":"Web Development"},{"id":10209,"urlkey":"web","name":"Web Technology"},{"id":122994,"urlkey":"high-tech-startups","name":"High-Tech Startups"}],"joined":1358875372000,"bio":"Software developer, Agile and Lean software enthusiast.","name":"Troy T","other_services":{"twitter":{"identifier":"@troy"}},"lat":39.04},
    {"lon":-94.86,"hometown":"Dodge City, KS","status":"active","link":"http:\/\/www.meetup.com\/members\/7843790","state":"KS","self":{"common":{}},"photo":{"photo_link":"http:\/\/photos3.meetupstatic.com\/photos\/member\/b\/0\/b\/5\/member_9825237.jpeg","highres_link":"http:\/\/photos1.meetupstatic.com\/photos\/member\/b\/0\/b\/5\/highres_9825237.jpeg","thumb_link":"http:\/\/photos1.meetupstatic.com\/photos\/member\/b\/0\/b\/5\/thumb_9825237.jpeg","photo_id":9825237},"lang":"en_US","country":"us","city":"Shawnee","id":7843790,"visited":1366110997000,"topics":[{"id":1040,"urlkey":"ruby","name":"Ruby"},{"id":20837,"urlkey":"ruby-on-rails","name":"Ruby On Rails"},{"id":188,"urlkey":"linux","name":"Linux"}],"joined":1246888677000,"bio":"I have limited programming experience and would like to get to know Ruby better with some of the local pros.","name":"Tyler","other_services":{"twitter":{"identifier":"@trutch"}},"lat":39}
  ],"meta":{"lon":"","count":14,"link":"http:\/\/api.meetup.com\/2\/members.json\/","next":"","total_count":3,"url":"","id":"","title":"Meetup Members v2","updated":1394381278000,"description":"API method for accessing members of Meetup Groups","method":"Members","lat":""}}
EOF
        d.gsub("\n", "")
      end

      let(:second_page) do
        d = <<EOF
  {"results":[],"meta":{"lon":"","count":14,"link":"http:\/\/api.meetup.com\/2\/members.json\/","next":"","total_count":3,"url":"","id":"","title":"Meetup Members v2","updated":1394381278000,"description":"API method for accessing members of Meetup Groups","method":"Members","lat":""}}
EOF
        d.gsub("\n", "")
      end

      let(:meetup) { Meetup.new(name: 'thename', key: 'thekey') }

      before do
        HTTParty.stubs(:get).with("http://api.meetup.com/2/members.json/?group_urlname=thename&key=thekey&offset=0").returns first_page
        HTTParty.stubs(:get).with("http://api.meetup.com/2/members.json/?group_urlname=thename&key=thekey&offset=1").returns second_page
      end

      it "should return three people" do
        meetup.all_members.count.must_equal 3
      end

    end

  end

end
