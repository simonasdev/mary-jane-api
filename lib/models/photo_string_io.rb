class PhotoStringIO < StringIO
  attr_accessor :original_filename, :content_type

  def initialize name, content_type, data
    @original_filename = name
    @content_type = content_type
    super data
  end
end