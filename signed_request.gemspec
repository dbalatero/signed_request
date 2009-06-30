# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{signed_request}
  s.version = "1.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Balatero"]
  s.date = %q{2009-06-30}
  s.email = %q{dbalatero@evri.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/signed_request.rb",
     "signed_request.gemspec",
     "spec/signed_request_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/dbalatero/signed_request}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{evrigems}
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{A simple gem that allows you to sign HTTP requests between two parties with a shared secret key.}
  s.test_files = [
    "spec/signed_request_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
