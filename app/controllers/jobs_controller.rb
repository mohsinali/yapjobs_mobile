class JobsController < ApplicationController
  require 'rest-client'
  require 'json'
  
  def index

    jobs_get = RestClient.get Rails.application.config.api_server_url + "jobs", {:params => 
        {:current_position => params[:current_position], :distance => "50", :role => "-1", :hourly_rate => "-1", 
          :contract_type => "-1", :job_type => "-1", :shift => "-1", :page => 1, :size => 20}, :Authorization => 
            Rails.application.config.api_authorization, "Content-Type" => "application/json"}

    @jobs = Hash.from_xml(jobs_get)

  end

  def show

    job_get = RestClient.get Rails.application.config.api_server_url + "jobs/job_search", 
      {:params => {:job_id => params[:id]}, :Authorization => Rails.application.config.api_authorization,
        "Content-Type" => "application/json"}
 
    @job = Hash.from_xml(job_get)["hash"]["job"]

  end
end
