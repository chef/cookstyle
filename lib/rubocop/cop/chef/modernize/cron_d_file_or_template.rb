# frozen_string_literal: true
#
# Copyright:: 2020-2022, Chef Software, Inc.
# Author:: Tim Smith (<tsmith@chef.io>)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
module RuboCop
  module Cop
    module Chef
      module Modernize
        # Use the cron_d resource that ships with Chef Infra Client 14.4+ instead of manually creating the file with template, file, or cookbook_file resources.
        #
        # @example
        #
        #   #### incorrect
        #   template '/etc/cron.d/backup' do
        #     source 'cron_backup_job.erb'
        #     owner 'root'
        #     group 'root'
        #     mode '644'
        #   end
        #
        #   cookbook_file '/etc/cron.d/backup' do
        #     owner 'root'
        #     group 'root'
        #     mode '644'
        #   end
        #
        #   file '/etc/cron.d/backup' do
        #     content '*/30 * * * * backup /usr/local/bin/backup_script.sh'
        #     owner 'root'
        #     group 'root'
        #     mode '644'
        #   end
        #
        #   file '/etc/cron.d/blogs' do
        #     action :delete
        #   end
        #
        #   file "/etc/cron.d/#{job_name}" do
        #     action :delete
        #   end
        #
        #   file File.join('/etc/cron.d', job) do
        #     action :delete
        #   end
        #
        #   #### correct
        #   cron_d 'backup' do
        #     minute '1'
        #     hour '1'
        #     mailto 'sysadmins@example.com'
        #     command '/usr/local/bin/backup_script.sh'
        #   end
        #
        #   cron_d 'blogs' do
        #     action :delete
        #   end
        #
        class CronDFileOrTemplate < Base
          extend TargetChefVersion

          minimum_target_chef_version '14.4'

          MSG = 'Use the cron_d resource that ships with Chef Infra Client 14.4+ instead of manually creating the file with template, file, or cookbook_file resources'

          def_node_matcher :file_or_template?, <<-PATTERN
            (block
              (send nil? {:template :file :cookbook_file}
                {(str $_) | (dstr (str $_) ...) | (send _ _ (str $_) ...)})
              ...
            )
          PATTERN

          def on_block(node)
            file_or_template?(node) do |file_name|
              break unless file_name.start_with?('/etc/cron.d')
              add_offense(node, severity: :refactor)
            end
          end
        end
      end
    end
  end
end
