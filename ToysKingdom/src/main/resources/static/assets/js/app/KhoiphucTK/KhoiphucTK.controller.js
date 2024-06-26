angular.module('ToysKingdom').controller('KhoiphucTKCtrl', function($scope, $http, $location, $rootScope) {
    // Hàm gửi yêu cầu OTP
    $scope.sendOTP = function() {
        console.log($scope.email);

        // Gửi yêu cầu đến backend để gửi OTP
        $http.post('/api-public/khoiphuctaikhoan/getotp', $scope.email) // Chỉnh sửa ở đây
            .then(function(response) {
                if(response.data.success) {
                    Swal.fire({
                        title: "Đã gửi mã OTP",
                        text: "Vùi lòng kiểm tra email của bạn!",
                        icon: "success"
                    });
                    $rootScope.email = $scope.email;
                    $location.path('/doiMK');
                }else{
                    Swal.fire({
                        title: "Email không hợp lệ",
                        text: "Vui lòng thử lại",
                        icon: "warning"
                    });
                }
            })
            .catch(function(error) {
                // Xử lý khi gửi email thất bại
                alert("Có lỗi xảy ra. Vui lòng thử lại.");
                console.error(error);
            });
    };
});
