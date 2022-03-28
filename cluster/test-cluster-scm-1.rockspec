package = 'test-cluster'
version = 'scm-1'
source  = {
    url = '/dev/null',
}
-- Put any modules your app depends on here
dependencies = {
    'tarantool >= 2.8',
    'lua == 5.1',
    'cartridge == 2.7.3-1',
    'crud == 0.10.0-1',
    'migrations == 0.4.2-1',
	'ddl = 1.6.0',
}
build = {
    type = 'none';
}
