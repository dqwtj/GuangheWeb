rake assets:precompile RAILS_ENV=production
i1=`cat tmp/pids/unicorn.pid|awk '{print $1}'` 
kill -USR2 $i1
