module DropboxApi::Endpoints::Files
  class MoveBatch < DropboxApi::Endpoints::Rpc
    Method      = :post
    Path        = "/2/files/move_batch_v2".freeze
    ResultType  = DropboxApi::Results::MoveBatchResult

    include DropboxApi::OptionsValidator

    # Move multiple files or folders to different locations at once in the
    # user's Dropbox.
    #
    # This will either finish synchronously, or return a job ID and do
    # the async copy job in background. Please use {Client#move_batch_check}
    # to check the job status.
    #
    # Note: No errors are returned by this endpoint.
    #
    # @param entries [Array<Hash>] List of entries to be moved.
    #   Each entry must be a hash with two keys: `:from_path` & `:to_path`.
    # @option options autorename [Boolean] If there's a conflict with any file,
    #   have the Dropbox server try to autorename that file to avoid the
    #   conflict. The default for this field is `false`.
    # @option options allow_ownership_transfer [Boolean] Allow moves by owner
    #   even if it would result in an ownership transfer for the content being
    #   moved. The default for this field is `false`.
    # @return [String, Array] Either the job id or the list of job statuses.
    add_endpoint :move_batch do |entries, options = {}|
      validate_options([
        :autorename,
        :allow_ownership_transfer
      ], options)
      options[:autorename] ||= false
      options[:allow_ownership_transfer] ||= false

      perform_request(options.merge({
        :entries => entries
      }))
    end
  end
end
