require 'travis'
Travis::Pro.access_token = ENV['TRAVIS_TOKEN']
repos = Travis::Pro::Repository.find_all(member: Travis::Pro::User.current.login)
	.reject{|repo| repo.slug == 'lorislab/travis-configuration'}
	.select{|repo| Travis::Pro::User.current.admin_access?(repo)}
	.select{|repo| repo.active }
keys = ['BINTRAY_API_KEY']

#tmp_repo = Travis::Pro::Repository.find('lorislab/treasure')
#nv_vars = tmp_repo.env_vars
#keys.each do |key|
#    nv_vars.upsert(key, "'#{ENV[key]}'", public: false)
#end

repos.each do |repo|
    tmp_repo = repo
    nv_vars = tmp_repo.env_vars
	keys.each do |key|
		puts "Setting env var '#{key}' on project '#{repo.slug}' #{tmp_repo.last_build_number}"
		nv_vars.upsert(key, "'#{ENV[key]}'", public: false)
	end
end