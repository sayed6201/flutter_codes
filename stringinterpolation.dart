							
#String interpolation::::::::::::::::::
							Text(
                              '\$${tx.amount}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20))


#==================================
# Remove substr after certain char
#==================================
 token = token.replaceAll(STR_REM, "");
 token = token.substring(0, token.indexOf('?'));