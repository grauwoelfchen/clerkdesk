module ApplicationHelper
  def capture_to_local(var, &block)
    set_var = block.binding.eval("lambda { |x| #{var} = x }")
    set_var.call(capture(&block))
  end
end
