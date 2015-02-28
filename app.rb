require 'sinatra'
require 'json'

get '/' do
	p 'hello'
end

post '/hook' do
	p @params['payload']
	params = JSON.parse @params['payload']

	url = params['repository']['url']
	name = params['repository']['name']

	project_root = "./build/#{name}"
	if Dir.exists?(project_root) then
    p `git -C #{project_root} pull`
	else
    p `git clone #{url} #{project_root}`
	  `chmod +x #{project_root}/gradlew`
	end
	p `#{project_root}/gradlew build -p #{project_root}`

	if $? then
		p 'BUILD SUCCECC'
	else
		p 'BUILD FAILURE'
	end
end

