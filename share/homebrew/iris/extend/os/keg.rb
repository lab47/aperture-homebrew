class Keg
  def initialize(path)
    path = path.resolved_path if path.to_s.start_with?("#{HOMEBREW_PREFIX}/opt/")
    # raise "#{path} is not a valid keg" unless path.parent.parent.realpath == HOMEBREW_CELLAR.realpath
    raise "#{path} is not a directory" unless path.directory?

    @path = path
    @name = path.parent.basename.to_s
    @linked_keg_record = HOMEBREW_LINKED_KEGS/name
    @opt_record = HOMEBREW_PREFIX/"opt/#{name}"
    @require_relocation = false
  end
end
