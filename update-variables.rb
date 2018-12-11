require 'travis'
Travis::Pro.access_token = ENV['TRAVIS_TOKEN']
repos = Travis::Pro::Repository.find_all(owner_name: 'lorislab')
	.reject{|repo| repo.slug == 'lorislab/travis-configuration'}
	.select{|repo| Travis::Pro::User.current.admin_access?(repo)}
keys = ['BINTRAY_API_KEY']
repos.each do |repo|
	keys.each do |key|
		puts "Setting env var '#{key}' on project '#{repo.slug}'"
		repo.env_vars.upsert(key, "'#{ENV[key]}'", public: false)
	end
end