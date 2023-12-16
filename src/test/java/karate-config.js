function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'http://localhost:8900/',

    //Schemas
    userResponseSchema: {email: '#regex ^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$', id: '#number', name:'#string', surname:'#string'},
    errorResponseSchema: {errors: '##[]', message:'#string'},
    bookingResponseSchema: {date: '#regex \\d{4}-\\d{2}-\\d{2}', destination: '#regex [A-Z]{3}', id: '#number', origin: '#regex [A-Z]{3}', userId: '#number'}
  }
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'e2e') {
    // customize
  }
  return config;
}