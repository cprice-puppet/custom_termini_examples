require 'puppet/indirector/catalog/compiler'

# Here we're subclassing the default compiler, so that we'll
# inherit all of the default behavior and we can override
# just the methods that we care about intercepting.
class Puppet::Resource::Catalog::CustomCatalogTerminus < Puppet::Resource::Catalog::Compiler

  # We're going to override the parent class's `find` method,
  # so here we give it an alias so that we can still
  # reference the original implementation in our code.
  alias :parent_find :find

  def find(request)
    # The hostname is available as part of the request object
    host = request.key

    # Here we call the parent class's `find` method, to
    # perform the usual catalog compilation.
    catalog = parent_find(request)

    # Here we can perform some custom processing of the catalog
    custom_behavior(host, catalog)

    # Finally, we return the catalog object that the parent
    # class would have returned.
    catalog
  end

  # This is a custom method for processing the catalog
  def custom_behavior(host, catalog)
    # Here, we could write the catalog to a queue for asynchronous processing,
    # write it to a file, etc.  We could also choose to only process
    # a subset of the resources in the catalog.  We'll just print the resources
    # for now:
    puts "Compiled catalog for: #{host}"
    catalog.resources.each do |r|
       puts "\tresource: #{r.to_pson}"
    end
  end
end
