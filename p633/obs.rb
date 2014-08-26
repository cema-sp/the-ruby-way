# observable module
module DRbObservable
	def add_observer(observer)
		@observer_peers ||= []
		unless observer.respond_to?(:update)
			raise NameError, "#{observer.to_s} has no \"update method\""
		end
		@observer_peers << observer
	end

	def delete_observer(observer)
		@observer_peers.delete observer if defined? @observer_peers
	end

	def notify_observers(*arg)
		return unless defined? @observer_peers
		for i in @observer_peers.dup
			begin
				i.update(*arg)
			rescue
				delete_observer(i)
			end
		end
	end
end