%dw 2.0
import try, orElse from dw::Runtime
type ResponseIsCNPJ = { valid: Boolean, message: String }

/**
* Validate that they are not sequential numbers
*
* === Parameters
*
* [%header, cols="1,1,3"]
* |===
* | Name | Type | Description
* | `cnpj` | String | CNPJ number
* |===
*
* === Example
*
* This example shows how to see if a number is not a sequential number
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* import cnpjNumberSequence from CNPJ
* output application/json
* ---
* cnpjNumberSequence("00000000000000")
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
*
* ----
*
*/
fun cnpjNumberSequence(cnpj: String): Boolean =
    cnpj match {
        case "00000000000000" -> true
        case "11111111111111" -> true
        case "22222222222222" -> true
        case "33333333333333" -> true
        case "44444444444444" -> true
        case "55555555555555" -> true
        case "66666666666666" -> true
        case "77777777777777" -> true
        case "88888888888888" -> true
        case "99999999999999" -> true
        else -> false
    }

/**
* Validate whether the CNPJ has the correct check digits
*
* === Parameters
*
* [%header, cols="1,1,3"]
* |===
* | Name | Type | Description
* | `cnpj` | String | CNPJ number
* |===
*
* === Example
*
* This example shows how to validate whether a CNPJ has the correct check digits
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* import isValidCNPJ from CNPJ
* output application/json
* ---
* isValidCNPJ("19999981000150")
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
*
* ----
*
*/
fun isValidCNPJ(cnpj: String): Boolean =try(() -> do {
        var digitMultipliers1 = [ 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2 ]
        var digitMultipliers2 = [ 6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2 ]
        var cnpjCharacterArray = (cnpj splitBy "") map ((item, index) -> item as Number)
        var verifyingDigit1 = cnpjCharacterArray[12] as Number
        var verifyingDigit2 = cnpjCharacterArray[13] as Number
        var sumBetweenDigitsAndMultiples1 = sum(cnpjCharacterArray[0 to 11] map ((item, index) -> item * digitMultipliers1[index]))
        var sumBetweenDigitsAndMultiples2 = sum(cnpjCharacterArray[0 to 12] map ((item, index) -> item * digitMultipliers2[index]))
        var remainderOfDivisionOfDigit1 = sumBetweenDigitsAndMultiples1 mod 11
        var remainderOfDivisionOfDigit2 = sumBetweenDigitsAndMultiples2 mod 11
        var calculationDigit1 = if (remainderOfDivisionOfDigit1 < 2) 0 else 11 - remainderOfDivisionOfDigit1
        var calculationDigit2 = if (remainderOfDivisionOfDigit2 < 2) 0 else 11 - remainderOfDivisionOfDigit2
        ---
        (calculationDigit1 == verifyingDigit1) and (calculationDigit2 == verifyingDigit2)
    }) orElse (() -> false)

/**
* Validate whether the CNPJ is valid
*
* === Parameters
*
* [%header, cols="1,1,3"]
* |===
* | Name | Type | Description
* | `cnpj` | String | CNPJ number
* |===
*
* === Example
*
* This example shows how to validate whether a CPF is valid
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* import isCNPJ from CNPJ
* output application/json
* ---
* isCNPJ("19999981000150")
*
* ----
*
* ==== Output
*
* [source,Json,linenums]
* ----
*
* ----
*
*/
fun isCNPJ(cnpj: String): ResponseIsCNPJ =
    if (sizeOf(cnpj) != 14)
        {
            "valid": false,
            "message": "CNPJ possui tamanho diferente de 14"
        }
    else if (cnpjNumberSequence(cnpj))
        {
            "valid": false,
            "message": "Numeros sequenciais"
        }
    else if (!isValidCNPJ(cnpj))
        {
            "valid": false,
            "message": "CNPJ inválido"
        }
    else
        {
            "valid": true,
            "message": "CNPJ válido"
        }