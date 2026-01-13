#!/usr/bin/env ruby

require 'pg'
require 'time'
require 'uri'
require './utils'

if File.exist?('env.rb')
  #Default environment variables
  require './env'
end

$stdout.sync = true

orgId = ENV['ORG_ID']
documentId = ENV['DOCUMENT_ID']
documentName = ENV['DOCUMENT_NANE']
documentType = ENV['DOCUMENT_TYPE'] 
documentBucket = ENV['DOCUMENT_BUCKET'] 
documentPath = ENV['DOCUMENT_PATH']

jobId = fallback(ENV['JOB_ID'], '')

puts("INFO : ### Start document extracting.")

puts("INFO : ### ORG_ID=[#{orgId}]")
puts("INFO : ### DOCUMENT_ID=[#{documentId}]")
puts("INFO : ### DOCUMENT_NANE=[#{documentName}]")
puts("INFO : ### DOCUMENT_TYPE=[#{documentType}]")
puts("INFO : ### DOCUMENT_BUCKET=[#{documentBucket}]")
puts("INFO : ### DOCUMENT_PATH=[#{documentPath}]")

puts("INFO : ### JOB_ID=[#{jobId}]")

pgHost = ENV["PG_HOST"]
pgDb = ENV["PG_DB"]
conn = connect_db(pgHost, pgDb, ENV["PG_USER"], ENV["PG_PASSWORD"])
if (conn.nil?)
  puts("ERROR : ### Unable to connect to PostgreSQL --> Host=[#{pgHost}], DB=[#{pgDb}] !!!")
  exit 101
end
puts("INFO : ### Connected to PostgreSQL [#{pgHost}] [#{pgDb}]")

update_job_status(conn, jobId, 'Running') unless jobId == ""

### Do something here... ###

message = "Done extracting document" 
update_job_done(conn, jobId, 1, 0, message) unless jobId == ""
