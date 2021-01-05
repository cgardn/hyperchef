namespace :action_array do
  desc "Converts Recipe actions from hash to array of [title, body]"
  task :convert => :environment do
    actionArr = []
    Recipe.all.each do |r|
      r.actions.keys.sort.each do |k|
        actionArr.push( [r.actions[k][0], r.actions[k][1]] )
      end
      r.action_array = actionArr
      r.save
    end
  end
end


