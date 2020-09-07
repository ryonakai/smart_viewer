disks =  `sudo smartctl -d sat --scan`.scan(/^\/dev\/sd\S*/)
for d in disks
    f = d.split('/').last
    `sudo smartctl -d sat -a #{d} > data/#{f}`
end