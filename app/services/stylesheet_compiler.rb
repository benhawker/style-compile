class StylesheetCompiler

  # Error that is raised when there are keys that are required that are not passed.
  class InvalidPayloadError < StandardError
    def initialize(missing_keys)
      super("Payload missing required keys: #{missing_keys.join(", ")}")
    end
  end

  attr_reader :user, :params

  DEFAULT_COLOR = "#000000"

  # For the purposes of this app we have 5 required keys.
  REQUIRED_KEYS = ["brand-success", "brand-primary",
    "brand-info", "brand-danger", "brand-warning"]

  # Creates a new +StylesheetCompiler+.
  #
  # params - the request payload of LESS variables for compilation.
  def initialize(params)
    @params = params
  end

  def compile!
    validate_payload!

    #Sample return
%Q(
@brand-success: #{params[:'brand-success']}  || DEFAULT_COLOR
@brand-primary": #{params[:'brand-primary']} || DEFAULT_COLOR
@brand-info" : #{params[:'brand-info']}      || DEFAULT_COLOR
@brand-danger": #{params[:'brand-danger']}   || DEFAULT_COLOR
@brand-warning": #{params[:'brand-warning']} || DEFAULT_COLOR
)
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