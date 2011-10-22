require 'facter/util/with_puppet'

# This fact helps the master determine the progress
# of the agent through the migration steps.
# The agent receives a class for step2 and step4

module Facter
  class AgentStep
    # Provides the with_puppet method
    extend Facter::Util::WithPuppet

    def self.add_facts
      with_puppet do
        Facter.add(:agent_cve20113872_step) do
          setcode do
            notfound = lambda { 0 }
            10.downto(0).find(notfound) do |x|
              File.exists? File.join(Puppet[:vardir],"cve20113872","agent_at_step#{x}")
            end
          end
        end
      end
    end
  end
end

Facter::AgentStep.add_facts
