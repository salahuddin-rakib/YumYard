class ApplicationController < ActionController::API

  def paginate_records(records, params)
    return [] if records.blank?

    page = params.fetch(:page, 0).to_i
    limit = params.fetch(:per_page, 10).to_i
    offset = page * limit

    records.limit(limit).offset(offset)
  end
end
