class StorageItemsResponse {
  List<String> data;

  StorageItemsResponse(
    this.data,
  );

  static StorageItemsResponse fromJson(Map<String, dynamic> json) =>
      StorageItemsResponse(json['data'].cast<String>());
}
