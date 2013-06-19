require 'puppet/indirector/facts/yaml'

# Here we're subclassing the default facts terminus, so that we'll
# inherit all of the default behavior and we can override
# just the methods that we care about intercepting.
class Puppet::Node::Facts::CustomFactTerminus < Puppet::Node::Facts::Yaml

  # We're going to override the parent class's `save` method,
  # so here we give it an alias so that we can still
  # reference the original implementation in our code.
  alias :parent_save :save

  def save(request)
    # The hostname and facts are available as part of the request object
    host = request.instance.name
    facts = request.instance.values

    # Here we can perform some custom processing of the facts
    custom_behavior(host, facts)

    # Finally, we call the parent class's `save` method and return
    # the result.
    parent_save(request)
  end

  # This is a custom method for processing the facts
  def custom_behavior(host, facts)
    # Here, we could write the facts to a queue for asynchronous processing,
    # write them to a file, etc.  We could also choose to only process
    # a subset of them.  We'll just print them for now:
    puts "SAVING FACTS for host '#{host}'"
    facts.each_pair do |fact, val|
      puts "\tSAVING FACT: #{fact}: #{val}"
    end
  end

end
