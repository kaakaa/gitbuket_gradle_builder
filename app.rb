require 'sinatra'
require 'json'
require 'haml'

get '/' do
	@projects = Dir.glob('./build/*')
	haml :index
end

get '/:project' do
	project_name = params[:project]
	log_file = "./build/#{project_name}/build.log"
	if File.exists?(log_file) then
		@text= File.open(log_file).read
	else
		@text= "NO BUILD LOG"
	end
	haml :log
end

post '/build-hook' do
	p @params
end

post '/hook' do
	p @params['payload']
	params = JSON.parse @params['payload']

	url = params['repository']['url']
	name = params['repository']['name']

	project_root = "./build/#{name}"
	
	if Dir.exists?(project_root) then
	  git_version = `git --version`.split[2]
	  work_dir = "-C #{project_root}"
		if git_version < 1.8.5 then
			work_dir = "--work-tree #{project_root} --git-dir #{project_root}"
		end
		p `git -C #{work_dir} pull`
	else
		p `git clone #{url} #{project_root}`
		`chmod -R +x #{project_root}`
	end
	`#{project_root}/gradlew#{'.bat' if RUBY_PLATFORM.include('mswin')} clean build -p #{project_root} > #{project_root}/build.log`

	if $? then
		p 'BUILD SUCCECC'
	else
		p 'BUILD FAILURE'
	end
end

__END__

@@ layout
%html
  %head
    %title= 'builder'
  %body
    = yield
    %a{:href => "/"}= "TOP"

@@ index
%h1= 'Projects'
%ul
  - @projects.each do |p|
    %li
      %a{:href => "/#{File.basename(p)}"}= "#{File.basename(p)}"

@@ log
%pre= @text
