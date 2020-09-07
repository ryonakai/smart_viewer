data = []
columns = []
column_names = []
Dir.glob('data/*').each do |f|
    d = File.read(f)
    fam = d.scan(/Model Family:\s+(.*)$/)[0][0] rescue ''
    mod = d.scan(/Device Model:\s+(.*)$/)[0][0] rescue ''
    da = d.scan(/^\s*\d+\s+[A-Z].*$/).map{
        |e| f =e.strip.split(' ')
        f[0] = f[0].to_i
        f
    }
    data.push({family: fam, model: mod, data: da})
    columns += da.map{|e| e[0]}#.to_i}
    da.each{|e| 
        column_names[e[0]] = e[1]
    }
    #p d.scan('No Errors Logged')
end
columns =  columns.uniq.sort
p data
p column_names

txt = ""
th1 = '<tr><th>Family</th>'
th2 = '<tr><th>Model</th>'
th3 = ''

for d in data
    th1 << "<th>#{d[:family]}</th>"
    th2 << "<th>#{d[:model]}</th>"
end
for c in columns
    th3 <<  "<tr><th>#{c}: #{column_names[c]}</th>"
    for d in data
        _d = d[:data].select{|e| e[0] == c}[0] rescue ''
        th3 << "<td>#{_d}</td>"
    end
    th3 << "</tr>"
end

File.write('out.html', <<"EOF"
    <table>
    #{th1}</tr>
    #{th2}</tr>
#{th3}
</table>
EOF
)