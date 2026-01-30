Tệp trong đâu được sử dụng để làm linux env cho tất cả các tệp taddocs

- Chạy tệp env.sh để lấy về các gói cài đặt cần thiết
- Sau khi hoàn thành, tất cả sẽ được cài đặt trong thư mục linux-venv
- Vào các thư mục con trong từng phần, sử dụng lệnh để soft link vào thư mục này ở trong các tệp tài liệu

```
ln -s ../linux-venv/linux-venv linux-venv
```

Các tệp tài liệu đó sẽ trỏ đến tệp này và gọi đến các công cụ tương ứng để sử dụng.


