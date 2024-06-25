// @override
// void dispose() {
//   ques.dispose();
//   ansctrl.dispose();
//   super.dispose();
// }

// @override
// void calcresult() {
//   try {
//     final result = evaluateExpression(eqn);
//     ans = result.toString();
//     ansctrl.text = ans;
//   } catch (e) {
//     ans = 'Error';
//     ansctrl.text = ans;
//   }
// }

// List<String> tokenize(String expression) {
//   final tokens = <String>[];
//   final buffer = StringBuffer();

//   for (int i = 0; i < expression.length; i++) {
//     final char = expression[i];

//     if (char == '' || char == '\t') {
//       continue; //skip whitespace
//     } else if (isOperator(char) || char == '(' || char == ')') {
//       if (buffer.isNotEmpty) {
//         tokens.add(buffer.toString());
//         buffer.clear();
//       }
//       tokens.add(char);
//     } else {
//       buffer.write(char);
//     }
//   }

//   if (buffer.isNotEmpty) {
//     tokens.add(buffer.toString());
//   }

//   return tokens;
// }

// bool isOperator(String char) {
//   return '+-*/'.contains(char);
// }

// List<String> infixToPostfix(List<String> tokens) {
//   final output = <String>[];
//   final operators = <String>[];

//   for (final token in tokens) {
//     if (isOperator(token)) {
//       while (operators.isNotEmpty &&
//           precedence(operators.last) >= precedence(token)) {
//         output.add(operators.removeLast());
//       }
//       operators.add(token);
//     } else if (token == '(') {
//       operators.add(token);
//     } else if (token == ')') {
//       while (operators.isNotEmpty && operators.last != '(') {
//         output.add(operators.removeLast());
//       }
//       operators.removeLast(); // remove the C
//     } else {
//       output.add(token);
//     }
//   }

//   while (operators.isNotEmpty) {
//     output.add(operators.removeLast());
//   }

//   return output;
// }

// int precedence(String operator) {
//   if (operator == '+' || operator == '-') {
//     return 1;
//   } else if (operator == '*' || operator == '/') {
//     return 2;
//   }
//   return 0;
// }

// double evaluatePostfix(List<String> postfix) {
//   final stack = <double>[];

//   for (final token in postfix) {
//     if (isOperator(token)) {
//       final b = stack.removeLast();
//       final a = stack.removeLast();
//       stack.add(applyOperator(token, a, b));
//     } else {
//       stack.add(double.parse(token));
//     }
//   }

//   return stack.last;
// }

// double applyOperator(String operator, double a, double b) {
//   switch (operator) {
//     case '+':
//       return a + b;
//     case '-':
//       return a - b;
//     case '*':
//       return a * b;
//     case '/':
//       return a / b;
//     default:
//       throw ArgumentError('Unsupported operator: $operator');
//   }
// }

// double evaluateExpression(String expression) {
// return double.parse(expression);
//   final tokens = tokenize(expression);
//   final postfix = infixToPostfix(tokens);
//   return evaluatePostfix(postfix);
// }
