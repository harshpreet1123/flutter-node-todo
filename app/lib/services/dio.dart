import 'dart:io';

import 'package:cpto/models/model.dart';
import 'package:dio/dio.dart';

class DioClient {
  final dio = Dio();
  var url=Platform.isAndroid?"http://10.0.2.2:3000":"http://192.168.1.69:3000";

  Future<void> addTodo({Todo? todo}) async {
    try {
      await dio.post('$url/add-todo', data: todo!.toJson());
    } catch (e) {
      print('Error: $e');
    }
  }
  Future<List<dynamic>> getTodos() async{
    try{
      var response = await dio.get('$url/todos',);
      List<dynamic> todo = response.data; 
      return todo;
    }catch(e){
      throw e;
    }
    
  }

  Future<void> delete({dynamic id}) async{
    try{
      await dio.delete('$url/todo/$id',data: {id:id});
    }catch(e){
      throw e;
    }
  }

  Future<void> toggleTodo({id}) async{
    try{
      await dio.put('$url/todo/$id',data: {id:id});
    }catch(e){
      throw e;
    }
  }
}
