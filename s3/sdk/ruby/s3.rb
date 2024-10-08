require 'aws-sdk-s3'          # AWS SDK for S3, used to interact with Amazon S3 service
require 'pry'                 # Pry is a debugging tool (optional, only needed for debugging)
require 'securerandom'        # SecureRandom library for generating unique identifiers (UUIDs)

# Load bucket name from environment variables
bucket_name = ENV['BUCKET_NAME']
if bucket_name.nil? || bucket_name.empty?
    puts "Error: BUCKET_NAME environment variable not set."
    exit
  end
# Set AWS region for S3 bucket creation
region = 'eu-west-2'

# Initialize an S3 client to interact with AWS S3 services
client = Aws::S3::Client.new

# Create an S3 bucket with the specified name and region
resp = client.create_bucket({
    bucket: bucket_name,
    create_bucket_configuration: {
        location_constraint: region
    }
})



# Generate a random number of files to create and upload (between 1 and 6 files)
number_of_files = 1 + rand(6)
puts "number_of_files: #{number_of_files}"  # Output the number of files to be created

# Iterate over the range of number_of_files to create and upload each file
number_of_files.times.each do |i|
    puts "i: #{i}"  # Output the current file index

    # Define the filename in the format "file_i.txt" where i is the index
    filename = "file_#{i}.txt"
    # Set the file path to store the temporary file in the /tmp/ directory
    output_path = "/tmp/#{filename}"

    # Open the file in write mode, and write a random UUID to the file
    File.open(output_path, "w") do |f|
        f.write SecureRandom.uuid  # Write a unique identifier to the file
    end

    # Open the file in binary mode for uploading to S3
    File.open(output_path, 'rb') do |f|
        # Upload the file to the S3 bucket with the generated filename as the key
        client.put_object(
            bucket: bucket_name,  # Target bucket
            key: filename,        # Key (name) of the file in the S3 bucket
            body: f               # File data to upload
        )
    end
end
