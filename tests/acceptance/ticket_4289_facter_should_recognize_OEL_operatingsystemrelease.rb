# 2010-08-02 Nan Liu
#
# http://projects.puppetlabs.com/issues/4289
#
# NL: Facter should return OS version instead of kernel version for OEL
# test script only applicable to OEL, provided based on ticked info, not verified.

test_name "#4289: facter should recognize OEL operatingsystemrelease"

# REVISIT: We don't actually have support for this yet - we need a "not
# applicable" option, I guess, that can be based on detected stuff, which is
# cleaner than this is...
agents.each do |host|
  step "determine the operating system of #{host}"
  facter host, "operatingsystem"
  if stdout =~ /oel/i then
    step "test operatingsystemrelease fact on OEL host #{host}"
    facter host, "operatingsystemrelease"
    stdout =~ /^\d\.\d$/ or fail_test "operatingsystemrelease not as expected"
  end
end
