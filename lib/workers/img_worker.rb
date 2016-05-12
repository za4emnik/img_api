class ImgWorker
	include Sidekiq::Worker
	def perform(params)
	  task = TaskFactory.getInstance.getObj(params)
	  task.processed(params)
	end
end
