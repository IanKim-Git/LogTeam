var eflag = false;	//email검증
var pflag = false;	//비밀번호 검증
var pflag2 = false;	//비밀번호 확인 검증
var nflag = false;	//이름 검증

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

//숫자 형식 검증 함수
function isNumValid(num){
	var numFormat = /^([0-9]+)$/;
	if(num.search(numFormat) == -1){
		return false;
	}
	return true;
}