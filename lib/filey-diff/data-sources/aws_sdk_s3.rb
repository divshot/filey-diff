module Filey
  module DataSources
    class AwsSdkS3
      def initialize(s3_bucket)
        @s3_bucket = s3_bucket
      end

      def get_fileys
        @cached if @cached
        @cached = @s3_bucket.objects.map { |s3_object|
          path = s3_object.key.scan(/(.*\/).*/).first.first
          name = s3_object.key.scan(/.*\/(.*)/).first.first
          normalised_path = ".#{path}"
          Filey.new(normalised_path, name, s3_object.last_modified)
        }
      end
    end
  end
end
