host { 'node1':
  ip => '192.168.0.1'
}

host { 'node2':
  ip => '192.168.0.2'
}

host { 'node3':
  ip => '192.168.0.3'
}


node 'node1' {
  include cluster
}

node 'node2' {
  include cluster
}

node 'node3' {
  include cluster
}


