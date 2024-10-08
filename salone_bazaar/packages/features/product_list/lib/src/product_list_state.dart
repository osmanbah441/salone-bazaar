part of 'product_list_bloc.dart';

final class ProductListState extends Equatable {
  const ProductListState({
    this.itemList,
    this.nextPage,
    this.filter,
    this.error,
    this.refreshError,
    this.favoriteToggleError,
  });

  final List<Product>? itemList;
  final int? nextPage;
  final ProductListFilter? filter;
  final dynamic error;
  final dynamic refreshError;
  final dynamic favoriteToggleError;

  const ProductListState.noItemsFound(ProductListFilter? filter)
      : this(
          itemList: const [],
          nextPage: 1,
          filter: filter,
          error: null,
        );

  const ProductListState.success({
    required int? nextPage,
    required List<Product> itemList,
    required ProductListFilter? filter,
    required bool isRefresh,
  }) : this(
          nextPage: nextPage,
          itemList: itemList,
          filter: filter,
        );

  ProductListState.loadingNewTag(ProductCategory? tag)
      : this(
          filter: tag != null ? ProductListFilterByCategory(tag) : null,
        );

  ProductListState.loadingNewSearchTerm(String? searchTerm)
      : this(
          filter: searchTerm != null
              ? ProductListFilterBySearchTerm(searchTerm)
              : null,
        );

  ProductListState copyWithNewError(
    dynamic error,
  ) =>
      ProductListState(
        itemList: itemList,
        nextPage: nextPage,
        error: error,
        filter: filter,
        refreshError: null,
      );

  ProductListState copyWithNewRefreshError(
    dynamic refreshError,
  ) =>
      ProductListState(
        itemList: itemList,
        nextPage: nextPage,
        error: error,
        filter: filter,
        refreshError: refreshError,
        favoriteToggleError: null,
      );

  ProductListState copyWithUpdatedProduct(
    Product updatedProduct,
  ) {
    return ProductListState(
      itemList: itemList?.map((product) {
        if (product.id == updatedProduct.id) {
          return updatedProduct;
        } else {
          return product;
        }
      }).toList(),
      nextPage: nextPage,
      error: error,
      filter: filter,
      refreshError: null,
      favoriteToggleError: null,
    );
  }

  @override
  List<Object?> get props => [
        itemList,
        nextPage,
        filter,
        error,
        refreshError,
        favoriteToggleError,
      ];
}

abstract base class ProductListFilter extends Equatable {
  const ProductListFilter();

  @override
  List<Object?> get props => [];
}

final class ProductListFilterBySearchTerm extends ProductListFilter {
  const ProductListFilterBySearchTerm(this.searchTerm);

  final String searchTerm;

  @override
  List<Object?> get props => [searchTerm];
}

final class ProductListFilterByCategory extends ProductListFilter {
  const ProductListFilterByCategory(this.category);

  final ProductCategory category;

  @override
  List<Object?> get props => [category];
}
