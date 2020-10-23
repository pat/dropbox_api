module DropboxApi::Endpoints::Files
  class MoveBatchCheck < DropboxApi::Endpoints::Rpc
    Method      = :post
    Path        = '/2/files/move_batch/check_v2'.freeze
    ResultType  = DropboxApi::Results::RelocationBatchResult
    ErrorType   = DropboxApi::Errors::PollError

    # Returns the status of an asynchronous job for {Client#move_batch}. It
    # returns a list of results for each entry.
    #
    # @param async_job_id [String] Id of the asynchronous job.
    #   This is the value of a response returned from the method that
    #   launched the job.
    # @return [:in_progress, Array] This could be either the `:in_progress`
    #   flag or a list of job statuses.
    add_endpoint :move_batch_check do |async_job_id|
      perform_request :async_job_id => async_job_id
    end
  end
end
