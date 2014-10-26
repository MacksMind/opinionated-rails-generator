# Temporary workaround for https://github.com/rails/sass-rails/issues/242

module Sass
  module Rails
    class SassImporter < Sass::Importers::Filesystem
      def marshal_dump
        # Return some kind of unique fingerprint to Sass
        @_marshal_id ||= object_id.to_s(16)
      end
      def marshal_load(*args)
        # Do nothing, we don't actually care if this is Marshalable
      end
    end
  end
end
