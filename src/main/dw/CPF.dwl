%dw 2.0
import try, orElse from dw::Runtime
type ResponseIsCPF = { valid: Boolean, message: String }

/**
* Validate that they are not sequential numbers
*
* === Parameters
*
* [%header, cols="1,1,3"]
* |===
* | Name | Type | Description
* | `cpf` | String | CPF number
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
* import cpfNumberSequence from CPF
* output application/json
* ---
* cpfNumberSequence("15772321005")
* ----
*
* ==== Output
*
* [source,Boolean,linenums]
* ----
* true
* ----
*
*/
fun cpfNumberSequence(cpf: String): Boolean =
    cpf match {
        case "00000000000" -> true
        case "11111111111" -> true
        case "22222222222" -> true
        case "33333333333" -> true
        case "44444444444" -> true
        case "55555555555" -> true
        case "66666666666" -> true
        case "77777777777" -> true
        case "88888888888" -> true
        case "99999999999" -> true
        else -> false
    }

/**
* Validate whether the CPF has the correct check digits
*
* === Parameters
*
* [%header, cols="1,1,3"]
* |===
* | Name | Type | Description
* | `cpf` | String | CPF number
* |===
*
* === Example
*
* This example shows how to validate whether a CPF has the correct check digits
*
* ==== Source
*
* [source,DataWeave,linenums]
* ----
* %dw 2.0
* import isValidCPF from CPF
* output application/json
* ---
* isValidCPF("15772321005")
*
* ----
*
* ==== Output
*
* [source,Boolean,linenums]
* ----
*
* ----
*
*/
fun isValidCPF(cpf: String): Boolean =try(() -> do {
        var digitMultipliers1 = [10, 9, 8, 7, 6, 5, 4, 3, 2]
        var digitMultipliers2 = [11, 10, 9, 8, 7, 6, 5, 4, 3, 2]
        var cpfCharacterArray = (cpf splitBy "") map ((item, index) -> item as Number)
        var verifyingDigit1 = cpfCharacterArray[9] as Number
        var verifyingDigit2 = cpfCharacterArray[10] as Number
        var sumBetweenDigitsAndMultiples1 = sum(cpfCharacterArray[0 to 8] map ((item, index) -> item * digitMultipliers1[index]))
        var sumBetweenDigitsAndMultiples2 = sum(cpfCharacterArray[0 to 9] map ((item, index) -> item * digitMultipliers2[index]))
        var remainderOfDivisionOfDigit1 = sumBetweenDigitsAndMultiples1 mod 11
        var remainderOfDivisionOfDigit2 = sumBetweenDigitsAndMultiples2 mod 11
        var calculationDigit1 = if (remainderOfDivisionOfDigit1 < 2) 0 else 11 - remainderOfDivisionOfDigit1
        var calculationDigit2 = if (remainderOfDivisionOfDigit2 < 2) 0 else 11 - remainderOfDivisionOfDigit2
        ---
        (calculationDigit1 == verifyingDigit1) and (calculationDigit2 == verifyingDigit2)
    }) orElse (() -> false)

/**
* Validate whether the CPF is valid
*
* === Parameters
*
* [%header, cols="1,1,3"]
* |===
* | Name | Type | Description
* | `cpf` | String | CPF number
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
* import isCPF from CPF
* output application/json
* ---
* isCPF("15772321005")
*
* ----
*
* ==== Output
*
* [source,Boolean,linenums]
* ----
*
* ----
*
*/
fun isCPF(cpf: String): ResponseIsCPF =
    if (sizeOf(cpf) != 11)
        {
            "valid": false,
            "message": "CPF possui tamanho diferente de 11"
        }
    else if (cpfNumberSequence(cpf))
        {
            "valid": false,
            "message": "Numeros sequenciais"
        }
    else if (!isValidCPF(cpf))
        {
            "valid": false,
            "message": "CPF inválido"
        }
    else
        {
            "valid": true,
            "message": "CPF válido"
        }