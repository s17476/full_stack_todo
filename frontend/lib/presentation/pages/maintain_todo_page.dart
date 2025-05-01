import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_todo/presentation/blocs/cubit/todos_cubit.dart';
import 'package:models/models.dart';

class MaintainTodoPage extends StatefulWidget {
  const MaintainTodoPage({super.key, this.todo});

  final Todo? todo;

  @override
  State<MaintainTodoPage> createState() => _MaintainTodoPageState();
}

class _MaintainTodoPageState extends State<MaintainTodoPage> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();
  final FocusNode checkBoxFocusNode = FocusNode();
  final FocusNode buttonFocusNode = FocusNode();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  bool _completed = false;
  bool _validated = false;
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  void _checkAutoValidationStatus() {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      final isValidated = _formKey.currentState!.validate();

      if (_validated != isValidated) {
        setState(() {
          _autoValidateMode = AutovalidateMode.always;
          _validated = isValidated;
        });
      }
    } else if (_validated) {
      setState(() {
        _validated = false;
      });
    }
  }

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.todo?.title);
    _descriptionController = TextEditingController(
      text: widget.todo?.description,
    );
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.todo == null ? 'Create' : 'Edit'} Todo'),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: _autoValidateMode,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                focusNode: titleFocusNode,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(),
                ),

                onChanged: (_) => _checkAutoValidationStatus(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },

                onEditingComplete: descriptionFocusNode.requestFocus,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _descriptionController,
                focusNode: descriptionFocusNode,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(),
                ),
                onChanged: (_) => _checkAutoValidationStatus(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description is required';
                  }
                  return null;
                },
                onEditingComplete: checkBoxFocusNode.requestFocus,
              ),
              if (widget.todo != null) const SizedBox(height: 14),
              if (widget.todo != null)
                CheckboxListTile(
                  focusNode: checkBoxFocusNode,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Mark Completed'),
                  value: _completed,
                  onChanged:
                      (v) => setState(() {
                        _completed = v ?? false;
                      }),
                ),
              const Spacer(),
              if (!_validated)
                const SizedBox.shrink()
              else
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    focusNode: buttonFocusNode,
                    onPressed: () {
                      //TODO
                    },

                    // onPressed: context.read<TodosCubit>().handleTodo,
                    child: BlocBuilder<TodosCubit, TodosState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          );
                        }

                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.save, size: 30),
                            SizedBox(width: 10),
                            Text('Save', style: TextStyle(fontSize: 20)),
                          ],
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
