# Auto Layout Guide

_Written by **Nguyen Minh Tam**_

Trong tài liệu này có đề cập đến một số kiến thức cơ bản của auto layout và một số ứng dụng của trong thực tế thường gặp khi develop một iOS application. Tài liệu này được recommend cho các bạn đã làm quen với auto layout trước đó nhe. Trong thời gian tới, mình sẽ viết tài liệu auto layout in iOS for begginer. Nhưng bây giờ hãy xem thử auto layout sẽ làm được gì trước nhé. Let's check it out! 💥

<center>
	<img src="./Image/img-app-menu.png" height="200">
	<img src="./Image/img-app-hello.png" height="200">
	<img src="./Image/img-app-signin.gif" height="200">
	<img src="./Image/img-app-detail.gif" height="200">
</center>

**Menu**

- [Understanding Auto Layout](#understanding-auto-layout)
	- [Introduce Auto Layout](#introduce-auto-layout)
	- [Auto layout Versus Frame-based layout](#auto-layout-vs-frame-based-layout)
- [Anatomy of a Constraint](#anatomy-of-a-constraint)
	- [Auto Layout Attributes](#auto-layout-attributes)
	- [Creating Nonambiguous, Satisfiable Layouts](#creating-nonambiguous-satisfiable-layouts)
	- [Constraint Priorities](#constraint-priorities)
	- [Intrinsic Content Size](#intrinsic-content-size)
	- [Intrinsic Content Size Versus Fitting Size](#intrinsic-content-size-versus-fitting-size)
- [Auto Layout With Stack View](#auto-layout-with-stack-view)

## Understanding Auto Layout

### Introduce Auto Layout

Auto layout có nhiệm vụ tính toán kích thước và vị trí của tất cả các view trong view hierarchy, dựa vào constraint được cài đặt trong các view đó.

Nhờ hệ thống constraint trong design này mà nó cho phép chúng ta build UI có thể thay đổi linh hoạt theo sự thay đổi của cả bên trong (internal change) và bên ngoài (external change).

#### External Change

External change xảy ra khi size hay hình dạng của supperview thay đổi.

Hầu hết những thay đổi này thường xảy ra lúc runtime và đương nhiên app sẽ phải yêu cầu UI phản hồi liên tục ứng với những thay đổi đó.

Một ví dụ khác nữa, đối với yêu cầu support cho những screen size khác nhau, app cần phải hiển thị phù hợp tương ứng với từng môi trường. Mặc dù đối với trường hợp này, screen size không thay đổi trong suốt runtime, việc tạo nên adaptive interface sẽ hỗ trợ app chạy mượt trên cả iPhone 4S, iPhone 6 Plus và cả trên iPad.

#### Internal Change

Internal change xảy ra khi size của view / control ở phía bên trong UI thay đổi.

Khi content của app thay đổi, chính content này có thể yêu cầu layout khác so với layout cũ. Ví dụ phổ biến nhất là sự thay đổi của nội dung text / image.

Bên cạnh đó, quá trình quốc tế hoá bắt buộc app phải có khả năng thay đổi tương thích với từng ngôn ngữ, vùng miền và văn hoá khác nhau. Layout cho một app mang tính quốc tế thực sự cần quan tâm đến vấn đề này, làm sao để hiển thị một cách chính xác ứng với tất cả các ngôn ngữ và vùng miền mà app đó hỗ trợ.

Sự quốc tế hoá có 3 tác động chính lên layout:

- Khi thay đổi ngôn ngữ, các label yêu cầu chiếm một lượng diện tích khác. Chả hạn như tiếng Đức sẽ chiếm diện tích nhiều hơn tiếng Anh, trong khi đó thường thì tiếng Nhật sẽ tốn ít hơn.

- Format sử dụng cho ngày tháng hay số liệu có thể bị thay đổi theo từng vùng miền, ngay khi ngôn ngữ vẫn giữ nguyên. Mặc dù những thay đổi này tinh vi hơn nhiều so với thay đổi ngôn ngữ, UI vẫn cần phải điều chỉnh lại cho phù hợp với sự biến đổi nhỏ về mặt kích thước đó.

- Thay đổi ngôn ngữ không chỉ thay đổi kích thước của text, mà còn tái cấu trúc lại layout. Đối với từng loại ngôn ngữ khác nhau sẽ có thứ tự sắp xếp layout (layout direction) khác nhau. Ví dụ điển hình như, tiếng Anh có layout direction trái sang phải, nhưng tiếng Ả-rập lại có layout từ phải sang trái. Xét về tổng thể, thứ tự các thành phần trong UI phải tương xứng với layout direction. Nếu một button nằm ở góc dưới bên phải của view ở tiếng Anh, thì nó phải ở góc dưới bên trái ở tiếng Ả-rập.

- Nếu iOS app support dynamic type, đồng nghĩa với việc người dùng có thể thay đổi font size trong app. Điều này dẫn tới việc thay đổi chiều cao lẫn chiều rộng của mọi thành phần chứa text trong UI. Nếu người dùng đổi font size khi app đang chạy, cả font lẫn layout đều phải điều chỉnh.

### Auto layout Versus Frame-based layout

Có ba cách chính để sắp xếp UI:

- Programmatically lay out UI.

- Sử dụng autoresizing mask để tự động hoá việc điều chỉnh ứng với external change.

- Auto layout.

#### Programmatically lay out UI

Về cơ bản app sắp xếp UI bởi việc setting frame cho mỗi view trong view hierarchy. Frame giúp xác định origin, height và width của view nằm trong hệ quy chiếu của superview.

<center>
	<img src="./Image/img-constraint-vs-frame-1.png" height="300">
</center>

Có thể nói rằng, define frame của view là cách linh hoạt và chính xác nhất. Tuy nhiên, vì chúng ta phải quản lý tất cả các thay đổi đó, nên với một UI đơn giản đã cần nhiều effort để design, debug và maintain. Việc tạo ra một adaptive UI đúng nghĩa đối với trường hợp này càng khó khi độ phức tạp view càng lớn.

#### Autoresizing mask

Sử dụng autoresizing mask giúp giảm nhẹ effort phải bỏ ra. Autoresizing mask xác định cái cách view frame thay đổi đối ứng với cách superview frame thay đổi. Giải pháp này đơn giản hoá công việc quản lý layout tương thích với external change

Tuy nhiên, autoresizing mask chỉ hỗ trợ đối với một số layout. Đối với UI phức tạp, chúng ta cần sử dụng autoresizing mask kèm thêm programmatically lay out UI. Ngoài ra, autoresizing mask chỉ điều chỉnh theo external change, không hỗ trợ cho internal change.

Autoresizing mask về cơ bản là một giải pháp tương tự programmatic layout, tuy nhiên auto layout lại là một khái niệm khác hẳn. Thay vì nghĩ đến view frame, chúng ta sẽ phân tích về các mối quan hệ giữa chúng.

#### Auto layout

Auto layout điều khiển UI bằng cách sử dụng một chuỗi các constraint. Một constraint mô tả một mối quan hệ giữa 2 view. Sau đó, auto layout tính toán size và vị trí của mỗi view dựa trên những constraint này. Điều này giúp cho layout thay đổi linh hoạt cho cả internal change và external change.

<center>
	<img src="./Image/img-constraint-vs-frame-2.png" height="300">
</center>

Để mastering auto layout cần:

- Hiểu logic của constraint-based layout.
- API.

Phần tiếp theo mình sẽ phân tích sâu hơn về constraint trong auto layout.

## Anatomy of a Constraint

*Written by: __Nguyễn Minh Tâm__*

Layout của hệ thống view được xác định bởi một series các linear equation (đẳng thức tuyến tính). Mỗi constraint thể hiện một đẳng thức. Nhiệm vụ của chúng ta là tạo ra một series đẳng thức, mà đẳng thức đó chỉ có duy nhất một nghiệm (possible solution).

Ví dụ đẳng thức sau:

<center>
	<img src="./Image/img-constraint-1.png" height="300">
</center>

Constraint này nói rằng leading edge của red view  được neo với trailing edge của blue view và cách 8.0 point. Đẳng thức của constraint này bao gồm một số phần:

- Item 1, Item 2
- Attribute 1, Attribute 2
- Relationship: Mối quan hệ giữa vế bên trái và vế bên phải. Relationship có thể có các dạng sau: =, >=, <=.
- Multipler: Giá trị của attribute 2 được nhân với số float multipler này.
- Constant: Là gía trị được cộng thêm vào vế bên attribute 2.

Một constraint có thể làm được:

<center>
	<img src="./Image/img-constraint-2.png" height="250">
</center>

### Auto Layout Attributes

Trong auto layout, attribute định nghĩa các đặc điểm sẽ được constrain sau:

<center>
	<img src="./Image/img-constraint-3.png" height="250">
</center>

Ví dụ: Với requirement như sau, bạn sẽ chọn cách nào để giải quyết?

<center>
	<img src="./Image/img-app-hello.png" height="400">
</center>

Bạn có thể chọn một trong những cách sau:

- Sử dụng stack view.
- Layout các view từ trên xuống dưới.
- Dùng một view lớn contain những view nhỏ, các view nhỏ được layout từ trên xuống dưới.
- ... x1001 cách khác

Rõ ràng là auto layout luôn luôn cho chúng ta vô số cách để giải quyết cho cùng một vấn đề. Lý tưởng nhất là chúng ta chọn một solution mô tả ý đồ một cách rõ ràng nhất. Tuy nhiên, đối với các developer khác nhau trong những trường hợp khác nhau sẽ có những solution khác nhau, khó mà đánh giá được solution nào là tốt nhất được. Vậy nên lời khuyên đưa ra là ` being consistent is better than being right`. Vì chúng ta sẽ gặp ít vấn đề hơn trong một khoảng thời gian dài khi chúng ta chọn một cách tiếp cận và `stick with it`.

### Creating Nonambiguous, Satisfiable Layouts

Khi sử dụng auto layout, goal của chúng ta là cung cấp một series đẳng thức chỉ có duy nhất một possible solution. 

Các lỗi khi bạn cung cấp các đẳng thức không cho ra một nghiệm duy nhất:

- Những `Ambiguous constraint` có nhiều hơn một possible solution. 
- Trong khi đó các `Unsatisfiable constraint` thì không có solution.

Ví dụ, auto layout sau đây có lỗi là gì?

```
RedView.Top = 1.0 x SuperView.Top + 10
RedView.Leading = 1.0 x SuperView.Leading + 10
```

Vì chưa xác định kích thước cụ thể cho view nên nó sẽ hiển thị lỗi `Unsatisfiable constraint`.

<center>
	<img src="./Image/img-view.png" height="200">
</center>

Để sửa lỗi, chỉ cần cung cấp thêm kích thước cho nó:

```
RedView.Top = 1.0 x SuperView.Top + 10
RedView.Leading = 1.0 x SuperView.Leading + 10
RedView.Width = 30.0
RedView.Height = 30.0
```

Về mặt tổng quát, khi đã sử dụng auto layout, ta cần phải khai báo constraint đầy đủ size và position cho tất cả view. 

### Constraint Priorities

Phần kiến thức dễ bị bỏ sót khi làm việc với Auto layout: Constraint priorities. Trong mỗi constraint có property `priority` mô tả độ ưu tiên của constraint đó so với những constraint khác.

Mặc định, tất cả constraint đều là `required`. Chúng ta có thể tạo ra một optional constraint. Mọi constraint có priority từ 1 đến 1000. Constraint với priority = 1000 là `required constraint`. Còn lại là `optional constraint`.

Cách thức tính toán của auto layout như sau:

- Auto layout sẽ tính toán solution có thể thoả mãn tất cả constraint.
- Nếu nó không tính ra solution thì nó sẽ in ra error cùng các unsatisfiable constraint lên console và chọn một constraint nào đó rồi bỏ nó đi.
- Sau đó nó lại tính toán solution lại một lần nữa mà không có đẳng thức của constraint vừa bị bỏ.
- Khi tính toán solution, autolayout sẽ hướng việc thoả mãn các constraint có priority theo thứ tự từ cao đến thấp.
- Nếu nó không thoả mãn được một optional constraint nào đó, constraint đó sẽ được bỏ qua và đến constraint tiếp theo.
- Mặc dù optional constraint có thể không được thoả mãn, nó vẫn có ảnh hưởng đến layout. Tức là nếu sau khi skip constraint, layout chưa được tính toán rõ ràng, hệ thống sẽ chọn solution thích hợp nhất đối với constraint đó. Trong trường hợp này, unsatisfied optional constraint sẽ kéo các view về phía nó.

Các optional constraint và các bất đẳng thức hay được làm việc cùng với nhau. Bằng cách cung cấp nhiều priority khác nhau các bất đẳng thức.

> Note: Chúng ta không bắt buộc luôn luôn sử dụng giá trị priority 1000. Thực ra, priority được hệ thống phân loại như sau: low (250), medium (500), high (750), và required (1000). Chúng ta nên đặt các constraint priority tránh những value trên để tránh sự mâu thuẫn.

Ví dụ: Mở `DemoAutoLayoutGuide.xcodeproj` và tới file `SignInVC.xib`.

<center>
	<img src="./Image/img-app-signin.gif" height="400">
</center>

```
// Constraint height của image view
ImageView.Height = 50 (priority: 950)

// Thay đổi priority của constraint so top của container view với top của super view
ContainerView.Top = 1.0 x SuperView.Top + 100
(priority: 900 → 800)
ContainerView.Top = 1.0 x SuperView.Top + 50
(priority: 850)
```
Cách thức tính toán layout trong trường hợp này:

- Bỏ qua constraint height của image view.
- Thoả mãn các constraint so top của container view với top của super view theo priority từ cao đến thấp.

Trước khi tìm hiểu phần tiếp theo, chúng ta hãy quay lại ví dụ RedView lỗi unstatisfied layout ở phía trên:

```
RedView.Top = 1.0 x SuperView.Top + 10
RedView.Leading = 1.0 x SuperView.Leading + 10
```

Nếu thay đổi RedView thành RedLabel thì kết quả sẽ như thế nào?

```
RedLabel.Top = 1.0 x SuperView.Top + 10
RedLabel.Leading = 1.0 x SuperView.Leading + 10
```

Câu trả lời là đối với trường hợp RedLabel này, layout không hề bị lỗi. Là do super power của RedLabel chăng? Lý do sẽ được giải thích cụ thể trong phần dưới.

<center>
	<img src="./Image/redlabel.jpg" height="100">
</center>
