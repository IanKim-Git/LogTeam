//e-mail 형식 검증 함수
function isEmailValid(email){
	var emailFormat = /^([0-9a-zA-Z_-]+)@([a-zA-Z_-]+)(\.[a-zA-Z_-]+){1,2}$/;
	if(email.search(emailFormat) == -1){
		return false;
	}
	return true;
}

//비밀번호 형식 검증 함수
function isPasswordValid(pw){
	var pwFormat = /^[0-9a-zA-Z`~!@#$%^*]{4,20}$/;
	if(pw.search(pwFormat) == -1){
		return false;
	}
	return true;
}

//전화번호 형식 검증 함수
function isPhoneValid(phone){
	var phoneFormat = /^([0-9]{2,4})-([0-9]{3,4})-([0-9]{3,4})$/;
	if(phone.search(phoneFormat) == -1){
		return false;
	}
	return true;
}
