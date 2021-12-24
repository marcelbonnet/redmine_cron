match '/cron_tasks/change_status/', :to => 'cron_tasks#bulk_edit', :via => [:put]

resources :cron_tasks

resources :cron_tasks do
	collection do
		put '/:id/toggle', to:'cron_tasks#toggle', as: :toggle
	end
end