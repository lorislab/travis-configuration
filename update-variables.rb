require 'travis'
Travis::Pro.access_token = ENV['TRAVIS_TOKEN']
repos = Travis::Pro::Repository.find_all(member: Travis::Pro::User.current.login)
	.reject{|repo| repo.slug == 'lorislab/travis-configuration'}
	.select{|repo| Travis::Pro::User.current.admin_access?(repo)}

keys = ['BINTRAY_API_KEY','GITHUB_TOKEN','CODACY_API_TOKEN','GITHUB_USERNAME','GITHUB_EMAIL','BINTRAY_API_KEY2']

repos.each do |repo|
    tmp_repo = repo
    nv_vars = tmp_repo.env_vars
	keys.each do |key|
		puts "Setting env var '#{key}' on project '#{repo.slug}'"
		nv_vars.upsert(key, "'#{ENV[key]}'", public: false)
	end
end