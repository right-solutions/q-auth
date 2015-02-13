# module PoodleValidators

#   def generate_validation_options(attribute, options)
#     reg_exp = /\A[a-zA-Z1-9\-\ \(\)\.+]*\z/i
#     options.reverse_merge!(
#       presence: true,
#       min_length: 3,
#       max_length: 256,
#       format: reg_exp,
#       uniqueness: false,
#       mandatory: false
#     )

#     if options.has_key?(:condition_method) && !options[:condition_method].blank?
#       condition_proc = proc {|obj| obj.send(options[:condition_method])}
#     elsif options.has_key?(:mandatory) && options[:mandatory] == false
#       condition_proc = proc {|obj| !obj.send(attribute).blank?}
#     else
#       condition_proc = nil
#     end

#     voptions = {
#       presence: options[:presence],
#       length: { minimum: options[:min_length], maximum: options[:max_length]},
#       format: {:with => options[:format]}
#     }
#     voptions.merge!(uniqueness: options[:uniqueness]) if options[:uniqueness]
#     voptions.merge!(if: condition_proc) if condition_proc

#     voptions
#   end

#   def validate_string(attribute, **options)
#     voptions = generate_validation_options(attribute, options)
#     validates attribute, **voptions
#   end

#   def validate_username(attribute, **options)
#     reg_exp = /\A[a-zA-Z0-9\_]*\z/
#     options.merge!(mandatory: true, max_length: 3, max_length: 128, format: reg_exp, :uniqueness => {:case_sensitive => false})
#     voptions = generate_validation_options(attribute, options)
#     validates attribute, **voptions
#   end

#   def validate_email(attribute, **options)
#     reg_exp = /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/i
#     options.merge!(mandatory: true, format: reg_exp, :uniqueness => {:case_sensitive => false})
#     voptions = generate_validation_options(attribute, options)
#     validates attribute, **voptions
#   end

#   def validate_password(attribute, **options)
#     reg_exp = /\A(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9!@$#&*_\.,;:])/
#     options.merge!(mandatory: true, format: reg_exp, min_length: 7, max_length: 256)
#     voptions = generate_validation_options(attribute, options)
#     validates attribute, **voptions
#   end

# end