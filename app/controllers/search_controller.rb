class SearchController < ApplicationController
	def list
		
		# jobs_get = RestClient.get Rails.application.config.api_server_url + "jobs", {:params => 
  #     {:current_position => params[:current_position], :distance => params[:distance], :role => params[:job_role_id], 
  #       :hourly_rate => params[:hourly_rate], :contract_type => params[:contract_type], :job_type => params[:job_type], 
  #       :shift => params[:shift_id], :page => 1, :size => 20}, :Authorization => Rails.application.config.api_authorization, "Content-Type" => "application/json"}


	 #  job_roles_get = RestClient.get Rails.application.config.api_server_url + "job_roles", {:Authorization => Rails.application.config.api_authorization,
  #       "Content-Type" => "application/json"}

	 #  @jobs = Hash.from_xml(jobs_get)

	 #  @job_roles = Hash.from_xml(job_roles_get)

	  redirect_to :controller => 'search', :action => 'index', :anchor => 'search_results', :location => params[:location], 
	  	:current_position => params[:current_position], :distance => params[:distance], :job_role_id => params[:job_role_id], 
      :hourly_rate => params[:hourly_rate], :contract_type => params[:contract_type], :job_type => params[:job_type], 
      :shift_id => params[:shift_id]

	end

	def index
		
		# jobs_get = RestClient.get Rails.application.config.api_server_url + "jobs", {:params => 
		# 		{:current_position => params[:current_position], :distance => "50", :role => "-1", :hourly_rate => "-1", 
		# 			:contract_type => "-1", :job_type => "-1", :shift => "-1", :page => 1, :size => 20}, :Authorization => 
		# 				Rails.application.config.api_authorization, "Content-Type" => "application/json"}
		
	  jobs_get = RestClient.get Rails.application.config.api_server_url + "jobs", {:params => 
      {:current_position => params[:current_position], :distance => params[:distance], :role => params[:job_role_id], 
        :hourly_rate => params[:hourly_rate], :contract_type => params[:contract_type], :job_type => params[:job_type], 
        :shift => params[:shift_id], :page => 1, :size => 20}, :Authorization => Rails.application.config.api_authorization, "Content-Type" => "application/json"}
	    
	  job_roles_get = RestClient.get Rails.application.config.api_server_url + "job_roles", {:Authorization => Rails.application.config.api_authorization,
        "Content-Type" => "application/json"}

	  @jobs = Hash.from_xml(jobs_get)

	  @job_roles = Hash.from_xml(job_roles_get)

	end
end
