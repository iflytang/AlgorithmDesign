//
// Created by tsf on 20-7-5.
//

#include "stdafx.h"
#include "Python.h"
 
int PyCall( const char * module, const char * function, const char *format, ... )
{
 PyObject* pMod    = NULL;
 PyObject* pFunc   = NULL;
 PyObject* pParm   = NULL;
 PyObject* pRetVal = NULL;
 
 //导入模块
 if( !(pMod = PyImport_ImportModule(module) ) ){
  return -1;
 }
 //查找函数
 if( !(pFunc = PyObject_GetAttrString(pMod, function) ) ){
  return -2;
 }
 
 //创建参数
 va_list vargs;
 va_start( vargs, format );
 pParm = Py_VaBuildValue( format, vargs );
 va_end(vargs);
 
 //函数调用
 pRetVal = PyEval_CallObject( pFunc, pParm);
 
 int ret;
 PyArg_Parse( pRetVal, "i", &ret );
 return ret;
}
 
 
int _tmain(int argc, _TCHAR* argv[])
{
	Py_Initialize();
	printf( "ret = %d\n", PyCall( "pytest", "add", "(ii)",  99, 1));
	Py_Finalize();
 
	return 0;
}

