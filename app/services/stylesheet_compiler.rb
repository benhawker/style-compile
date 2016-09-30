# Error that is raised when there are keys that are required that are not passed.
class InvalidPayloadError < StandardError
  def initialize(missing_keys)
    super("Payload missing required keys: #{missing_keys.join(", ")}")
  end
end

class StylesheetCompiler
  attr_reader :user, :params

  DEFAULT_COLOR = "#000000"

  # For the purposes of this app we have 5 required keys.
  REQUIRED_KEYS = ["brand-success"]  #, "brand-primary",
  #   "brand-info", "brand-danger", "brand-warning"]

  # Creates a new +StylesheetCompiler+.
  #
  # params - the request payload of LESS variables for compilation.
  def initialize(user, params)
    @user = user
    @params = params
  end

  def less_file_path
    Rails.root.join('app', 'views', 'v1', 'stylesheets', "template.less.erb")
  end

  def less_file_content
    File.read(less_file_path)
  end

  # The styles which are rendered through app/views/v1/stylesheets/template.less.erb
  # Supply local variables which can be accessed in the style view.
  def styles
    V1::StylesheetsController.new.render_to_string 'template',
      formats: [:less],
      layout:  false,
      locals:  { params: params }
  end

  def compile!
    # puts "printing params"
    # puts params
    puts self.styles
    validate_payload!

    # parser = Less::Parser.new

    # tree = parser.parse(less_file_content)
    # tree.to_css

    File.read(less_file_path)

#Sample return
# %Q(
# @brand-success: #{params[:'brand-success']}  || DEFAULT_COLOR
# @brand-primary": #{params[:'brand-primary']} || DEFAULT_COLOR
# @brand-info" : #{params[:'brand-info']}      || DEFAULT_COLOR
# @brand-danger": #{params[:'brand-danger']}   || DEFAULT_COLOR
# @brand-warning": #{params[:'brand-warning']} || DEFAULT_COLOR
# )
  end

  private

  def validate_payload!
    required_keys = REQUIRED_KEYS.dup
    missing_keys = []

    required_keys.each do |key|
      if params[key].blank?
        missing_keys << key
      end
    end

    if missing_keys.present?
      raise InvalidPayloadError.new(missing_keys)
    end
  end
end