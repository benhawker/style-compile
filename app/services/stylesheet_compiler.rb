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
  REQUIRED_KEYS = ["brand-success", "brand-primary",
    "brand-info", "brand-danger", "brand-warning"]

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

  def compile!
    validate_payload!

    tree = parser.parse(interpolated_less)
    tree.to_css
  end

  private

  def parser
    Less::Parser.new
  end

  def interpolated_less
    template = ERB.new(File.read(less_file_path))
    template.result(binding)
  end

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