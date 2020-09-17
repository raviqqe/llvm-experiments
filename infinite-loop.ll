declare void @print(i32)

define void @f() {
entry:
  br label %loop
loop:
  call void @print(i32 42)
  br label %loop
}
