# StylesheetPublisher - organizes the process of generating, compressing and uploading
# i.e. (full publishing process) for a stylesheet.
#
# The goal of this class is to handle all the components involved in the publishing process.

class StylesheetPublisher
  attr_reader :user, :params, :random_code
  # user - the +User+ that is making the request.
  # params - the request payload given by the user
  def initialize(user, params)
    @user = user
    @params = params
    @random_code = SecureRandom.hex(2)
  end

  def publish!
    stylesheet = user.stylesheets.build
    stylesheet.data = build_stylesheet_file
    stylesheet.url = absolute_url

    stylesheet.save!
    stylesheet
  rescue => e
    stylesheet.error_message = e.message
  end

  def created_successfully?
    stylesheet.persisted?
  end

  private

  def stylesheet
    @stylesheet ||= user.stylesheets.build
  end

  def build_stylesheet_file
    file = create_file

    file << compiler.compile!
    file.close
    file
  end

  def compiler
    StylesheetCompiler.new(user, params)
  end

  def create_file
    File.open(path + filename, "w")
  end

  def absolute_url
    "#{path}#{filename}"
  end

  def filename
    ["#{user.name}_#{random_code}", "css"].join(".")
  end

  def path
    Rails.root.join("public/stylesheets/")
  end
end