# -*- encoding: binary -*-
ENV["VERSION"] = '3.7.0' 
manifest = File.readlines('.manifest').map! { |x| x.chomp! }

# don't bother with tests that fork, not worth our time to get working
# with `gem check -t` ... (of course we care for them when testing with
# GNU make when they can run in parallel)
test_files = manifest.grep(%r{\Atest/unit/test_.*\.rb\z}).map do |f|
  File.readlines(f).grep(/\bfork\b/).empty? ? f : nil
end.compact

Gem::Specification.new do |s|
  s.name = %q{unicorn}
  s.version = ENV["VERSION"].dup
  s.authors = ["unicorn hackers"]
  s.summary = 'Busted-ass crap' 
  s.date = Time.now.utc.strftime('%Y-%m-%d')
  s.description = 'Busted-ass crap' 
  s.email = %q{mongrel-unicorn@rubyforge.org}
  s.executables = %w(unicorn unicorn_rails)
  s.extensions = %w(ext/unicorn_http/extconf.rb)
  s.files = manifest

  # for people that are absolutely stuck on Rails 2.3.2 and can't
  # up/downgrade to any other version, the Rack dependency may be
  # commented out.  Nevertheless, upgrading to Rails 2.3.4 or later is
  # *strongly* recommended for security reasons.
  s.add_dependency(%q<rack>)
  s.add_dependency(%q<kgio>, '~> 2.3')

  s.add_development_dependency('isolate', '~> 3.1')
  s.add_development_dependency('wrongdoc', '~> 1.5')

  # s.licenses = %w(GPLv2 Ruby) # licenses= method is not in older RubyGems
end
