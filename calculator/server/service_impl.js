const { SumResponse } = require('../proto/sum_pb')
const { PrimesResponse } = require('../proto/primes_pb');

exports.sum = (call, callback) => {
    console.log("Sum was invoked");
    const res = new SumResponse()
        .setResult(
            call.request.getFirstNumber() + call.request.getSecondNumber()
        )
    callback(null, res);
};

exports.primes = (call, _) => {
    console.log ("Primes was invoked");
    const res = new PrimesResponse();
    
    let N = call.request.getNumber();
    let k = 2;
    while (N > 1) {
        if (N % k === 0) {
            res.setResult(k);
            call.write(res);
            N = N / k; // Divide N by k to get the remaining number
        } else {
            k = k + 1; // Increment k if it doesn't evenly divide into N
        }
    } 
    call.end();
} 