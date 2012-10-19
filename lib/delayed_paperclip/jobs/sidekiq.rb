require 'sidekiq'

module DelayedPaperclip
  module Jobs
    class Sidekiq
      include Sidekiq::Worker
      sidekiq_options :queue => :paperclip

      def self.enqueue_delayed_paperclip(instance_klass, instance_id, attachment_name)
        ::Sidekiq::Client.enqueue(self, instance_klass, instance_id, attachment_name)
      end

      def perform(instance_klass, instance_id, attachment_name)
        DelayedPaperclip.process_job(instance_klass, instance_id, attachment_name)
      end
    end
  end
end
