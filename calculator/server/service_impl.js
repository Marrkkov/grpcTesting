
const { SumResponse } = require('../proto/sum_pb')

exports.sum = (call, callback) => {
    console.log("Sum was invoked");
    const res = new SumResponse()
        .setResult(
            call.request.getFirstNumber() + call.resquest.getSecondNumber()
        )
    callback(null, res);
};