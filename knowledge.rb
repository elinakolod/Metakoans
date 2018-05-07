class Module
  def attribute (a, &block)
    default = nil
    a, default = a.first if a.is_a? Hash

    inst_var = "@#{a.to_sym}"
    define_method "#{a}?" do
      send(a)
    end
    define_method "#{a}=" do |val|
      instance_variable_set(inst_var, val)
    end
    define_method a do
      if instance_variable_defined?(inst_var)
        instance_variable_get(inst_var)
      else
        block_given? ? instance_eval(&block) : default
      end
    end

  end
end
