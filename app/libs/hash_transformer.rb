class HashTransformer
  def self.camelize(parameters, upper_case: true, mutable: false)
    if parameters.is_a?(Array)
      parameters.map { |x| HashTransformer.camelize(x, upper_case: upper_case, mutable: mutable) }
    else
      if mutable
        if parameters.instance_of?(ActionController::Parameters) || parameters.is_a?(Hash)
          upper_case ?
            parameters.transform_keys!(&:camelize) :
            parameters.transform_keys! { |x| x.camelize(:lower) }

          HashTransformer.parameters_iterator(parameters) do |_k, v|
            HashTransformer.camelize(v, upper_case: upper_case, mutable: mutable)
          end
        else
          parameters
        end
      else
        if parameters.instance_of?(ActionController::Parameters) || parameters.is_a?(Hash)
          result = upper_case ?
                     parameters.transform_keys(&:camelize) :
                     parameters.transform_keys { |x| x.camelize(:lower) }

          HashTransformer.parameters_iterator(result) do |_k, v|
            HashTransformer.camelize(v, upper_case: upper_case, mutable: mutable)
          end
        else
          parameters
        end
      end
    end
  end

  def self.snake_case(parameters, mutable: false)
    if parameters.is_a?(Array)
      parameters.map { |x| HashTransformer.snake_case(x, mutable: mutable) }
    else
      if mutable
        if parameters.instance_of?(ActionController::Parameters) || parameters.is_a?(Hash)
          parameters.transform_keys!(&:underscore)
          HashTransformer.parameters_iterator(parameters) do |_k, v|
            HashTransformer.snake_case(v, mutable: mutable)
          end
        else
          parameters
        end
      else
        if parameters.instance_of?(ActionController::Parameters) || parameters.is_a?(Hash)
          result = parameters.transform_keys(&:underscore)
          HashTransformer.parameters_iterator(result) do |_k, v|
            HashTransformer.snake_case(v, mutable: mutable)
          end
        else
          parameters
        end
      end
    end
  end

  def self.parameters_iterator(parameters)
    parameters.each do |key, value|
      if value.instance_of?(ActionController::Parameters) || value.is_a?(Hash)
        parameters[key] = yield(key, value)
      elsif value.is_a?(Array)
        parameters[key] = yield(key, value)
      end
    end
    parameters
  end
end
