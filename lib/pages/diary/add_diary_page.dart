import 'package:anxiety_app/bloc/diary/add_diary/add_diary_cubit.dart';
import 'package:anxiety_app/bloc/diary/add_diary/add_diary_state.dart';
import 'package:anxiety_app/widgets/alert_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AddDiaryPage extends StatefulWidget {
  const AddDiaryPage() : super();

  static PageRoute<dynamic> route({
    required String? userId,
  }) =>
      MaterialPageRoute(
        builder: (context) => BlocProvider<AddDiaryCubit>(
          create: (context) => AddDiaryCubit(
            userId: userId,
          ),
          child: AddDiaryPage(),
        ),
      );

  @override
  State<AddDiaryPage> createState() => _AddDiaryState();
}

class _AddDiaryState extends State<AddDiaryPage> {
  AddDiaryCubit get _cubit => context.read<AddDiaryCubit>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _diaryController = TextEditingController();

  final FocusNode _titleNode = FocusNode();
  final FocusNode _diaryNode = FocusNode();

  String? _titleErrorText;
  String? _diaryErrorText;

  @override
  Widget build(BuildContext context) => Material(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          backgroundColor: Colors.lightBlue,
          body: BlocConsumer<AddDiaryCubit, AddDiaryState>(
            listener: _listener,
            builder: _builder,
          ),
        ),
      );

  void _listener(BuildContext context, AddDiaryState state) async {
    if (state.added) {
      await showDialog(
        context: context,
        builder: (context) => AlertWidget(
          dialogType: DialogType.confirm,
          message: 'ANOTAÇÃO ADICIONADA COM SUCESSO AO SEU DIÁRIO !',
        ),
      ).whenComplete(
        () => Navigator.of(context).pop(),
      );
    }
  }

  Widget _builder(BuildContext context, AddDiaryState state) {
    _makeErrorTexts(state);
    return _makeBody(state);
  }

  void _makeErrorTexts(AddDiaryState state) {
    if (state.errorType == AddDiaryError.emptyTitle) {
      _titleErrorText = 'Digite um título para sua anotação!';
    } else {
      _titleErrorText = null;
    }

    if (state.errorType == AddDiaryError.emptyDiary) {
      _diaryErrorText = 'Não deixe de escrever como você está !';
    } else {
      _diaryErrorText = null;
    }
  }

  Widget _makeBody(AddDiaryState state) => Column(
        children: [
          Text(
            'Anotação',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 26.0,
            ),
          ),
          _makeTitleTextField(),
          _makeDiaryTextField(),
          _makeButton(state),
        ],
      );

  Widget _makeTitleTextField() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
              width: 2.0,
              color: Colors.white,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              right: 15.0,
              left: 15.0,
              bottom: 10.0,
            ),
            child: TextFormField(
              controller: _titleController,
              focusNode: _titleNode,
              decoration: InputDecoration(
                hintText: 'Meu diário',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                errorText: _titleErrorText,
              ),
              maxLength: 50,
              keyboardType: TextInputType.text,
            ),
          ),
        ),
      );

  Widget _makeDiaryTextField() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
              width: 2.0,
              color: Colors.white,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              right: 15.0,
              left: 15.0,
              bottom: 10.0,
            ),
            child: TextFormField(
              controller: _diaryController,
              focusNode: _diaryNode,
              decoration: InputDecoration(
                hintText: 'Escreva aqui sobre como você está se sentindo',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                errorText: _diaryErrorText,
              ),
              maxLines: 15,
              maxLength: 300,
              keyboardType: TextInputType.text,
            ),
          ),
        ),
      );

  Widget _makeButton(AddDiaryState state) => Padding(
        padding: const EdgeInsets.only(
          right: 20.0,
          left: 20.0,
          bottom: 15.0,
        ),
        child: Container(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onPressed: () => _cubit.onValidateFields(
              title: _titleController.text,
              diary: _diaryController.text,
            ),
            child: state.isLoading
                ? SpinKitThreeBounce(
                    color: Colors.white,
                    size: 25.0,
                  )
                : Text(
                    'ADICIONAR ANOTAÇÃO',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      );

  @override
  void dispose() {
    _titleNode.dispose();
    _diaryNode.dispose();

    _titleController.dispose();
    _diaryController.dispose();

    super.dispose();
  }
}
