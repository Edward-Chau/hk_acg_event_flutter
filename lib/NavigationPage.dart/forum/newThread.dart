import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_picker/image_picker.dart';

class Newthread extends StatefulWidget {
  const Newthread({super.key});

  @override
  State<Newthread> createState() => _NewthreadState();
}

class _NewthreadState extends State<Newthread> {
  final TextEditingController titleTextEditingController =
      TextEditingController();
  final QuillController _contentController = QuillController.basic();

  final ValueNotifier<bool> canSendNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    // 標題監聽
    titleTextEditingController.addListener(_updateCanSend);

    // Quill 內容監聽
    _contentController.changes.listen((event) {
      _updateCanSend();
    });
  }

  void _updateCanSend() {
    final titleNotEmpty = titleTextEditingController.text.trim().isNotEmpty;
    final contentNotEmpty =
        _contentController.document.toPlainText().trim().isNotEmpty;
    canSendNotifier.value = titleNotEmpty && contentNotEmpty;
  }

  @override
  void dispose() {
    titleTextEditingController.dispose();
    // contentTextEditingController.dispose();
    super.dispose();
  }

  Future<void> _insertImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final index = _contentController.selection.baseOffset; // 游標位置
    _contentController.document.insert(index, BlockEmbed.image(picked.path));
    // 插入後游標跳到圖片後面
    _contentController.updateSelection(
        TextSelection.collapsed(offset: index + 1), ChangeSource.local);
  }

  void onSubmit() {
    // print("送出: ${titleTextEditingController.text}");
    // print(_contentController.document.toPlainText());
    print(_contentController.document.toDelta().toJson());
  }

  @override
  Widget build(BuildContext context) {
    final double bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
          color: Colors.white,
        ),
        title: const Text('發文'),
        centerTitle: true,
        actions: [
          ValueListenableBuilder<bool>(
            valueListenable: canSendNotifier,
            builder: (context, canSend, child) {
              return IconButton(
                onPressed: canSend ? onSubmit : null,
                icon: Icon(Icons.send,
                    color: canSend
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.5)),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            IconButton(
              onPressed: _insertImage,
              icon: const Icon(Icons.photo),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
              },
              icon: const Icon(
                Icons.keyboard_hide_outlined,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: TextFormField(
                    controller: titleTextEditingController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      filled: false,
                      hintText: "輸入標題...",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.grey,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      QuillEditor.basic(
                        controller: _contentController,
                        config: const QuillEditorConfig(
                          placeholder: '敍述...',
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                // QuillSimpleToolbar(
                //   controller: _contentController,
                //   config: const QuillSimpleToolbarConfig(
                // showClipboardCut: false,
                // showLink: false,
                // showFontFamily: false,
                // showCodeBlock: false,
                // showClipboardPaste: false,
                // showDividers: false,
                // showCenterAlignment: false,
                // showSearchButton: false,
                // showClipboardCopy: false,
                // showUndo: false,
                // showRedo: false,
                // showFontSize: false,
                // showSubscript: false,
                // showSuperscript: false,
                // showIndent: false,
                // showQuote: false,
                // showHeaderStyle: false,
                // showInlineCode: false,
                // showClearFormat: false,
                // embedButtons: FlutterQuillEmbeds.toolbarButtons(
                //   videoButtonOptions: null,
                //   imageButtonOptions: QuillToolbarImageButtonOptions(
                //     imageButtonConfig: QuillToolbarImageConfig(
                //       onImageInsertCallback: (localImageUrl, controller) async {
                //         Logger().i("Image Picker Called , $localImageUrl ,");
                //         localImgUrlList.add(localImageUrl);
                //         Logger().d(localImgUrlList);
                //         // Logger().d(localImgUrlList);
                //         // URL returned by the Server
                //         controller
                //           ..skipRequestKeyboard = true
                //           ..insertImageBlock(imageSource: localImageUrl);
                //       },
                //     ),
                //   ),
                // ),
                //       ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
