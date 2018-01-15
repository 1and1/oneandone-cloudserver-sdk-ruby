OneAndOne.start('<API-TOKEN>') # Init module with API key

ssh_key = OneAndOne::SshKey.new()

# Create a new SSH Key
response = ssh_key.create(name: 'Test SSH Key',
                          description: 'Test Description',
                          public_key: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC6U+LbJPFNDkORkrVUSg78IJjNDSBY1NgDzhr0S9rLvRVInHDT+3DsojZDqXglCpaLwNcdIQM1saGlIKlmxJro8Qw2kJRKqhP/DZLmvcz+niUKZ/0ho1a5HAlTJl6ct8DFto/z+hhDIHTRL4i7n+M/n9SNGjQ28EQy6SztsqwV8yheiUIgNO2lOXDi1Pjs7znBLFE305AHpf6pv4jlUE7r280+WAuloZJaNtu2YL4XXKsemBliDet54OJaW/4e+/5TexX0wZwkibdhuCSFJvhCJ6jbJZbdUwCyqlz6tiu75bSUTV7WGlxWtUjZCY0KBO9BPwbTDhxmIAeigDxnSRhekC/5b7cYUVys0JgvxBKiBVg6Bc32c7fjeOrNpUixzVxtm6UQtZDYyOa+1OvPKPpHg1Ugy28aUtqV4yRYQbltkLB8JSKaZvCqzm9d6qXhkCKV2GmMs5glBE0MyZMiwgoc+Ar0HuN3RnYNzIWIZc1CYTfKB+otHEwmb8V4hS6/k50obPa4J81RJekLU/8yY0WDRWVven6hyriBhNJXpI3V84XqSB4cl1HNcFgeat+EbM5e5QuLUn3Uwdt15kugQt5t9LqVK1jyqWQ4CrJ+Yg7/uU7l7fPHH0rvk9LvSv4BXlHETbScUDOnaZnr8m+4HJyucVq1tXdPCCDSyGGNO/IFBw== test@email.com')

puts JSON.pretty_generate(response)


# List all SSH Key's on your account
response = ssh_key.list

puts JSON.pretty_generate(response)


# Retrieve an SSH Key
response = ssh_key.get(ssh_key_id: '<SSH-KEY-ID>')

puts JSON.pretty_generate(response)


# Modify an SSH Key
response = ssh_key.modify(ssh_key_id: '<SSH-KEY-ID>',
                          name: 'New Name',
                          description: 'New Description')

puts JSON.pretty_generate(response)


# Delete an SSH Key
ssh_key = OneAndOne::SshKey.new()

response = ssh_key.delete(ssh_key_id: '<SSH-KEY-ID>')

puts JSON.pretty_generate(response)
