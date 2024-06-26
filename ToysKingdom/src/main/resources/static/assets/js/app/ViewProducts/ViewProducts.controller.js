angular.module('ToysKingdom').controller('ViewProductsCtrl', function ($scope, $http, $location, $rootScope) {

    console.log('View Products');
    $scope.productsData = [];
    $scope.categoriesData = [];
    $scope.currentPage = 1;
    $scope.totalPages = 1;
    $scope.isLoading = false;

    $scope.loadData = function (page) {
        $scope.isLoading = true;
        $scope.productsData = [];
        $http.get('http://localhost:8080/api-public/products/homePageProduct', { params: { page: page } })
            .then(function (response) {
                $scope.productsData = response.data.data;
                $scope.isLoading = false;
            }, function (error) {
                console.error(error.message);
                $scope.isLoading = false;
            });
    };

    $scope.getTotalProducts = function () {
        $scope.isLoading = true;
        $http.get('http://localhost:8080/api-public/products/countFeatureProducts')
            .then(function (response) {
                const totalProducts = response.data.data;
                $scope.totalPages = Math.ceil(totalProducts / 12); // 12 sản phẩm mỗi trang
                $scope.isLoading = false;
            }, function (error) {
                console.error(error.message);
                $scope.isLoading = false;
            });
    };

    $scope.getData = function () {
        $scope.isLoading = true;
        $http.get('http://localhost:8080/api-public/categories/getAllCategories')
            .then(function (response) {
                $scope.categoriesData = response.data.data;
                $scope.isLoading = false;
            }, function (error) {
                console.error(error.message);
                $scope.isLoading = false;
            });

        $scope.getTotalProducts();
        $scope.loadData(1);
    };

    $scope.getData();
    $rootScope.getCart();
  


    


});
