unit htmldoc;

{$mode objfpc}{$H+}

interface

uses
//  Classes, SysUtils,ExtCtrls,htmlproc,unix,StdCtrls, LCLIntf, LCLType,Controls,LazFileUtils, LMessages, Messages;
Classes, SysUtils, ZConnection, ZDataset, LazFileUtils, Forms, Controls, Graphics,
Dialogs, ExtCtrls, StdCtrls, Buttons,
{$IFDEF UNIX}
unix,

{$ENDIF}
LCLIntf, LCLType,	DateUtils,htmlproc,platproc;

procedure primer1(); //Пример вывода HTML отчета
procedure startbrowser(FileHtmlName:string); //Пример вывода HTML отчета
procedure FillReportVars(ZZ: TZconnection; ZQ: TZQuery); // ЗАПОЛНЕНИЕ МАССИВА ПЕРЕМЕННЫХ ОТЧЕТОВ
procedure BeginReport(ZZ: TZconnection; ZQ: TZQuery; repid: integer; tip: byte); /// РАЗБОР ЗАПИСИ ИЗ ТАБЛИЦЫ ОТЧЕТОВ
procedure DoHead(sHead: string); //разбор текстовой части отчета
procedure DoColumns(sTt: string); // разбор ИМЕН КОЛОНОК
function GetZapros(sZap: string):string; // разбор запроса
procedure SelectReport(m: integer); // перечень внеших процедур для печати отчета
//procedure Report_sostav_shedule(); //Состав расписания
//procedure Report_shedule_tarif(); //Цена билетов по основному тарифу расписания
procedure Report_sezonATP(); //отчет по пересечению сезонностей всех атп на расписании

var
  ar_repcols : array of array of string;
  fileR:TextFile;

implementation
uses
 report_main, report_vibor,mainopp, shedule_edit;

var

   rep_id, rep_type, rep_grup : integer;
   rep_name, rep_grname, rep_Ch : string;
   rep_Shead, rep_sDown, rep_sCol, rep_sZap : string;


 //--------------------------------------------------------------------------------------------
//------------------//отчет по пересечению сезонностей всех атп на расписании   ---------------------------------------
//--------------------------------------------------------------------------------------------
procedure Report_SezonATP();
var
  n,x:integer;
begin
  // Начало HTML
  if StartHTML(ExtractFilePath(Application.ExeName)+'shedule_sezonATP.html')=false then exit;
  SetHTMLString('Пересечение календарных планов выхода перевозчиков на расписании.',3,3,4,'000000');
 // SetHTMLString('Маршрут № '+form16.Edit3.Text+'- '+form16.Edit2.Text,3,2,2,'FF0000');
  //SetHTMLString('Расписание № '+form16.Edit6.Text+'- '+form16.Edit5.Text,3,2,2,'080000');
  SetHTMLString('',3,2,2,'000000');
  SetHTMLString('',3,2,2,'000000');
  // Таблица - Начало
  StartTableHTML(1,'',3);
  StartRowTableHTML('');
  CellsTableHTML('Дата:',3,3,1,'',0,0);
  for n:=2 to form16.StringGrid6.RowCount-1 do
    begin
      CellsTableHTML(trim(form16.StringGrid6.Cells[1,n]),4,3,2,'',0,0);
    end;
  EndRowTableHTML();
  FOR n:=0 to Length(arSatp)-1 do
    begin
       //проверка, есть ли пересечение
      If trim(arSatp[n,1])<>'2' then continue;
       StartRowTableHTML('');
        for x:=0 to form16.StringGrid6.RowCount-1 do
          begin
             if x=1 then continue; //пропустить колонку признака пересечения
             If x=0 then CellsTableHTML(arSatp[n,x],1,3,1,'',0,0)
             else
               begin
                 If arSatp[n,x]='1' then
                     CellsTableHTML('+',3,4,2,'',0,0)
                 else
                     //CellsTableHTML(arSatp[n,x],3,3,2,'',0,0);
                   CellsTableHTML('',3,3,2,'',0,0);
               end;
          end;
        EndRowTableHTML();
      end;
  //Таблица - Конец
  EndTableHTML();
  EndHTML(); // Конец HTML (fileHTML:десткриптор файла)
  startbrowser(ExtractFilePath(Application.ExeName)+'shedule_sezonATP.html');
end;
//---------------------------------------------------------------------------------------------



//************************** перечень внешних процедур для печати отчета ****************************
procedure SelectReport(m: integer);
begin
   If m=0 then exit;
   //If m=6 then Report_shedule_tarif();
end;

//************************************* РАЗБОР ЗАПРОСА ***************************************
function GetZapros(sZap: string):string;
var
  n,m,k : integer;
  sVar, sVal : string;
begin
   If trim(sZap)='' then exit;
   Result := '';
   While Length(sZap)>1 do
   begin
     k:=Pos('&', sZap);
     If k=0 then
       begin
        Result:=Result + sZap;
        break;
       end;
     Result := Result + Copy(sZap,1,k-1);
     sZap := Copy(sZap,k+1,length(sZap));
      //определяем имя переменной
     m:=Pos(#32,sZap);
     If m=0 then
       begin
       sVar := Copy(sZap,1,length(sZap));
       sZap :='';
       end
        else
          begin
           sVar := Copy(sZap,1,m-1);
           sZap := Copy(sZap,m+1,length(sZap));
          end;
      sVal := ' '; //значение переменной
     //ищем значение переменной в массиве
       for k:=Low(ar_report) to High(ar_report) do
         begin
           If lowerCase(trim(ar_report[k,0])) = lowerCase(sVar) then
               begin
               If ar_report[k,3]='1' then
                 sVal := QuotedStr(ar_report[k,2])+' '
                 else
                   sVal := ar_report[k,2]+' ';
               break;
               end;
        end;
        Result := Result + sVal;
   end;
end;

//************************************* разбор ИМЕН КОЛОНОК ***************************************
procedure DoColumns(sTt: string);
var
  n,m,k : integer;
  sCol, sTabName, sColName : string;
begin
   If trim(sTt)='' then exit;
   SetLength(ar_repcols,0,4);

   StartRowTableHTML(''); //Начало строки заголовка
   //раскладываем колонки
   While Length(sTT)>1 do
   begin
     k:=Pos('$', sTt);
     If k=0 then break;
     n:=Pos('@', sTt);
     If n=0 then break;
     m:=Pos('|', sTt);
     If m=0 then break;

     sTabname := Copy(sTt,k+1,n-1-k);
     sColName := Copy(sTt,n+1,m-1-n);
     SetLength(ar_repcols,length(ar_repcols)+1,4);
     ar_repcols[high(ar_repcols),0] := sTabName;   //имя столбца в базе
     ar_repcols[high(ar_repcols),1] := sColName;   //имя колонки в отчете
     ar_repcols[high(ar_repcols),2] := Copy(sTt,2,1);//выравнивание в ячейке
     ar_repcols[high(ar_repcols),3] := Copy(sTt,3,1);//размер шрифта

     If k=5 then
       begin
         CellsTableHTML(sColName,strtoint(Copy(sTt,2,1)),strtoint(Copy(sTt,3,1)),strtoint(Copy(sTt,4,1)),'',0,0);
       end
     else
     CellsTableHTML(sColName,1,1,1,'',0,0);
     sTt:= Copy(sTt,m+1,length(sTt));
   end;
   //конец строки заголовка
   EndRowTableHTML();
end;

//************************************* разбор текстовой части отчета ***************************************
procedure DoHead(sHead: string);
var
  n,k,i,j: integer;
  sTmp, sStr, rvar, rval : string;
begin
   //раскладываем текстовую часть
   While Length(sHead)>1 do
   begin
     j:=Pos('@', Shead);
     If j<3 then break;
     n:=Pos('|', Shead);
     If n<5 then break;
     //showmessagealt(inttostr(n)+' | '+inttostr(k)+' | '+inttostr(length(sHead))+' | '+shead);
     k:=Pos('&', Shead);
     If (k>j) AND (k<n) then
         begin
           sStr :='';
           rVal :=' ';
           sTmp := Copy(Shead,1,n-1);
           While Pos('&',sTmp)>1 do
           begin
              k:=Pos('&',sTmp);
              sStr := sStr + Copy(sTmp,1,k-1);
              sTmp := Copy(sTMp,k+1,length(sTmp));
              //определяем имя переменной
              If Pos(#32,sTmp)=0 then
                begin
                 rvar := Copy(sTmp,1,length(sTmp));
                 sTmp := '';
                end
              else  rvar := Copy(sTmp,1,Pos(#32,sTmp)-1);

              //ищем значение переменной в массиве
              for i:=Low(ar_report) to High(ar_report) do
                begin
                  If trim(ar_report[i,0]) = rvar then
                      begin
                       rval := ' '+ar_report[i,2];
                       writeln(fileR,'&'+rvar+'|'+trim(rval)+'|');
                       break;
                      end;
                end;
              sStr := sStr + rval;
              sTmp := Copy(sTmp,Pos(#32,sTmp)+1,Length(sTmp));
           end;
         sStr := sStr + trim(sTmp);
         SetHTMLString(Copy(sStr,j+1,length(sStr)),strtoint(Copy(sStr,j-3,1)),strtoint(Copy(sStr,j-2,1)),strtoint(Copy(sStr,j-1,1)),'080000');
         end
     else
       SetHTMLString(Copy(Shead,j+1,n-1-j),strtoint(Copy(Shead,j-3,1)),strtoint(Copy(Shead,j-2,1)),strtoint(Copy(Shead,j-1,1)),'080000');

     SHead:= Copy(Shead,n+1,length(Shead));
   end;
end;


/// ********************************* РАЗБОР Полей ЗАПИСИ ИЗ ТАБЛИЦЫ ОТЧЕТОВ *******************************************
procedure BeginReport(ZZ: TZconnection; ZQ: TZQuery; repid: integer; tip: byte);
var
  nCh, n, m, i, num, k : integer;
  srow : string;
begin
  //инициализация переменных
  //SetLength(ar_repcols,0,0);
  rep_type := 0;    rep_grup :=0;
  rep_name := '';  rep_grname := '';
  rep_Shead :='';  rep_sDown :=''; rep_sCol:=''; rep_sZap:=''; rep_Ch := '';
// Подключаемся к серверу
   If not(Connect2(ZZ, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
 //запрос данных по этому отчету
   ZQ.SQL.Clear;
   ZQ.SQL.add('SELECT * FROM av_reports WHERE del=0 AND id='+inttostr(repid)+';');
  try
   ZQ.open;
  except
    showmessagealt('Выполнение команды SQL - ОШИБКА !'+#13+'Команда: '+ZQ.SQL.Text);
    ZQ.Close;
    ZZ.disconnect;
    exit;
  end;
   if ZQ.RecordCount<>1 then
     begin
      ZQ.Close;
      ZZ.disconnect;
      exit;
     end;

   //rep_id := ZQ.FieldByName('id').asInteger; //id отчета
   rep_grup := ZQ.FieldByName('grup').asInteger; //группа отчета
   rep_Ch := ZQ.FieldByName('fl_choice').asString; //код выбора табличных данных
   rep_Shead := ZQ.FieldByName('headtext').Asstring; //текст заголовка
   rep_sDown := ZQ.FieldByName('downtext').Asstring; //текст подвала
   rep_sCol := ZQ.FieldByName('rep_columns').Asstring; //колонки отчета
   rep_sZap := ZQ.FieldByName('zapros').Asstring;  //запрос отчета
   rep_type := ZQ.FieldByName('fl_type').asInteger; //тип обработки отчета
   //showmessage('ZAP '+inttostr(length(rep_sZap)));
   rep_name := ZQ.FieldByName('naim').asString; //имя отчета
   If trim(rep_name)<>'' then
     rep_name :=  StringReplace(rep_name,#32,'_',[rfReplaceAll]) + '.swd';

   // создание и открытие файла
    DeleteFile(rep_name);
    AssignFile(fileR,rep_name);
    {$I-} // отключение контроля ошибок ввода-вывода
    Rewrite(fileR); // открытие файла для чтения
    {$I+} // включение контроля ошибок ввода-вывода
    if IOResult<>0 then // если есть ошибка открытия, то
      begin
      showmessagealt('Ошибка создания файла документа !');
      ZQ.Close;
      ZZ.disconnect;
      Exit;
      end;

    if StartHTML(ExtractFilePath(Application.ExeName)+rep_name+'.html')=false then
       begin
           ZQ.Close;
           ZZ.disconnect;
           exit;
       end;
   //If rep_grup=0 then rep_grname:='shedule';

   //определяем тип обработки отчета
   // tip=1 AND rep_type=1 - все в автомате
   // tip=1 AND rep_type=0 - статический отчет, запущенный НЕ из формы (требуется разбор кода выбора)
   // tip=0 AND rep_type=0 - статический отчет, запущенный из формы (ПРОПУСТИТЬ разбор кода выбора)

    If (tip=0) AND (rep_type=0) then
      begin
         SelectReport(repid);
      end;

   IF (tip=1) then
    begin
       // ЗАПОЛНЕНИЕ МАССИВА ПЕРЕМЕННЫХ ОТЧЕТОВ
        FillReportVars(ZZ,ZQ);
       //раскодируем выбор табличных данных
       If (trim(rep_Ch)<>'') then
        begin
          If not(FormReport.ChoiceDecode(rep_Ch)) then
            begin
             showmessage('Некорректный выбор данных!');
             fl_print:=0;  //открывать другие формы в обычном режиме
             ZQ.Close;
             ZZ.disconnect;
             exit;
            end;
        end;

    If (rep_type=1) then
      begin
      //разбор текстовой части заголовка
       DoHead(rep_sHead);

      // Таблица - Начало
      writeln(fileR,'&table|');
       StartTableHTML(1,'',1);
      // разбор ИМЕН КОЛОНОК
       DoColumns(rep_sCol);

     If trim(rep_sZap)<>'' then
     begin
      // разбор запроса
       rep_sZap := GetZapros(rep_sZap);
       srow:= '';
       //*-*-*-*--*-*-*-* выполненине запроса *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       ZQ.SQL.Clear;
       ZQ.SQL.add(rep_sZap);
       //showmessage(ZQ.SQL.Text);
       try
        ZQ.open;
       if ZQ.RecordCount>0 then
        begin
         num :=0;//нумерация строк
         For n:=1 to ZQ.RecordCount do
           begin
             srow:= '';
             StartRowTableHTML(''); //Начало строки данных таблицы
             num:=num+1;
             for i:=low(ar_repcols) to high(ar_repcols) do
               begin
                 //колонка нумерации
                 If ar_repcols[i,0]='N' then
                    begin
                      srow := srow + inttostr(num) +'|' ;
                      CellsTableHTML(inttostr(num),strtoint(ar_repcols[i,2]),strtoint(ar_repcols[i,3]),1,'',0,0);
                      continue;
                     end;
                 //перебираем поля Zqery и печатаем только столбцы, совпадающие с ar_repcols
                 for m:=1 to ZQ.Fields.Count do
                   begin
                     If copy(ar_repcols[i,0],k+1,length(ar_repcols[i,0]))=ZQ.Fields[m-1].FieldName then
                       begin
                         srow := srow + ZQ.Fields[m-1].AsString +'|';
                         CellsTableHTML(ZQ.Fields[m-1].AsString,strtoint(ar_repcols[i,2]),strtoint(ar_repcols[i,3]),1,'',0,0);
                         break;
                       end;
                   end;
               end;
           writeln(FileR,srow);
           EndRowTableHTML(); //конец строки данных таблицы
           ZQ.Next;
           end;
        end;
        except
         showmessage('Выполнение команды SQL - ОШИБКА !'+#13+'Команда: '+ZQ.SQL.Text);
         ZQ.Close;
         ZZ.disconnect;
       end;
      end;

        //*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-

       //Таблица - Конец
       writeln(fileR,'&endtable|');
       EndTableHTML();
        //разбор текстовой части подвала
       DoHead(rep_sDown);

    end
    else
     begin
         SelectReport(repid);
      end;
    end;

   closefile(fileR);
   EndHTML(); // Конец HTML (fileHTML:десткриптор файла)
   startbrowser(ExtractFilePath(Application.ExeName)+rep_name+'.html');
   ZQ.Close;
   ZZ.disconnect;
end;


//******************************** ЗАПОЛНЕНИЕ МАССИВА ПЕРЕМЕННЫХ ОТЧЕТОВ *************************************
procedure FillReportVars(ZZ: TZconnection; ZQ: TZQuery);
var
  m : integer;
  sUser, sUserKOd,ss : string;
  myYear, myMonth, myDay : Word;
begin
  sUser := '';
  sUserKod := '';
  // Часы + Дата
  DecodeDate(Date, myYear, myMonth, myDay);

   // Определяем пользователя
  ZQ.SQL.Clear;
  ZQ.SQL.add('Select name from av_users where id='+inttostr(id_user)+';');
 try
  ZQ.open;
 except
   showmessagealt('Выполнение команды SQL - ОШИБКА !'+#13+'Команда: '+ZQ.SQL.Text);
   ZQ.Close;
   ZZ.disconnect;
 end;
 If ZQ.RecordCount=1 then
   begin
     sUser := ZQ.FieldByName('name').asString;
     sUserKod := inttostr(id_user);
   end;

  ZQ.SQL.Clear;
  ZQ.SQL.add('SELECT * FROM av_reports_vars WHERE del=0 ORDER BY rvar;');
 try
  ZQ.open;
 except
   showmessagealt('Выполнение команды SQL - ОШИБКА !'+#13+'Команда: '+ZQ.SQL.Text);
   ZQ.Close;
   ZZ.disconnect;
 end;
 SetLength(ar_report,0,0);
  if ZQ.RecordCount>1 then
   begin
     SetLength(ar_report,ZQ.RecordCount,4);
     for m:=low(ar_report) to High(ar_report) do
       begin
         ar_report[m,0] := ZQ.FieldByName('rvar').asString;
         ar_report[m,1] := ZQ.FieldByName('rdepend').asString;
         ar_report[m,2] := '';
         ar_report[m,3] := ZQ.FieldByName('rtype').asString;
         ss := LowerCase(ZQ.FieldByName('rvar').asString);
         If ss='user' then ar_report[m,2] := sUser;
         If ss='user_kod' then ar_report[m,2] := sUserkod;
         If ss='date' then ar_report[m,2] := IntToStr(myDay)+' '+GetMonthName(MonthOfTheYear(Date))+' '+inttostr(myYear)+' г.'; ;
         If ss='time' then ar_report[m,2] := TimeToStr(Time);
         ZQ.next;
       end;
   end;
end;


//************************************* ЗАПУСК PLATHTML ДЛЯ ПЕЧАТИ ОТЧЕТА ********************************************************************************
procedure startbrowser(FileHtmlName:string); //Пример вывода HTML отчета
begin
  {$IFDEF Win32}
    ExecuteProcess(GetEnvironmentVariable('COMSPEC'), ['/c', 'explorer.exe '+' '+trim(FileHTMLname)]);
 {$ENDIF}
 {$IFDEF UNIX}
   if not(FileExistsUTF8(ExtractFilePath(Application.ExeName)+'plathtml')) then
               begin
                showmessagealt('Отсутствует приложение '+ExtractFilePath(Application.ExeName)+'plathtml'+' !');
                exit;
               end;
                // Запускаем внешнее приложение
  fpsystem(ExtractFilePath(Application.ExeName)+'plathtml'+' '+trim(FileHTMLname)+' &');
  {$ENDIF}
end;

procedure primer1(); //Пример вывода HTML отчета
begin
  // Начало HTML
  if StartHTML(ExtractFilePath(Application.ExeName)+'test.html')=false then exit;
  //if StartHTML('/home/swforeman/Документы/lazarus_pj/plathtml/test2.html')=false then exit;
  // Создание строки HTML (fileHTML:десткриптор файла,строка,выравнивание:1-влево,2-вправо,3-центр,размер шрифта,стиль шрифта: нормальный,большой,наклонный,большой наклонный,цвет шрифта:FF0000)
  SetHTMLString('РАЗМЕР шрифта = 1',3,1,1,'080000');
  SetHTMLString('РАЗМЕР шрифта = 2',3,2,1,'080000');
  SetHTMLString('РАЗМЕР шрифта = 3',3,3,1,'080000');
  SetHTMLString('РАЗМЕР шрифта = 4',3,4,1,'080000');
  SetHTMLString('РАЗМЕР шрифта = 5',3,5,1,'080000');
  SetHTMLString('РАЗМЕР шрифта = 6',3,6,1,'080000');
  SetHTMLString('РАЗМЕР шрифта = 7',3,7,1,'080000');
  SetHTMLString('',3,2,1,'080000');
  SetHTMLString('',3,2,1,'080000');
  SetHTMLString('ПОЗИЦИЯ ВЛЕВО',1,2,1,'080000');
  SetHTMLString('ПОЗИЦИЯ ВПРАВО',2,2,1,'080000');
  SetHTMLString('ПОЗИЦИЯ ЦЕНТР',3,2,1,'080000');
  SetHTMLString('ПОЗИЦИЯ ПО ШИРИНЕ',4,2,1,'080000');
  SetHTMLString('',3,2,1,'080000');
  SetHTMLString('',3,2,1,'080000');
  SetHTMLString('Нормальный ШРИФТ',3,2,1,'080000');
  SetHTMLString('Большой ШРИФТ',3,2,2,'080000');
  SetHTMLString('Наклонный ШРИФТ',3,2,3,'080000');
  SetHTMLString('Наклонный Большой ШРИФТ',3,2,4,'080000');
  SetHTMLString('',3,2,1,'080000');
  SetHTMLString('',3,2,1,'080000');
  SetHTMLString('Цвет ШРИФТ',3,2,4,'080000');
  SetHTMLString('Цвет ШРИФТ',3,2,4,'FF0000');
  SetHTMLString('Цвет ШРИФТ',3,2,4,'FFFF00');
  SetHTMLString('Цвет ШРИФТ',3,2,4,'0000FF');
  SetHTMLString('Цвет ШРИФТ',3,2,4,'008000');
  SetHTMLString('Автоматизированная система продажи билетов PLATFORMA AV',3,1,1,'080000');
  // Таблица - Начало
  StartTableHTML(1,'',1);
  // 1 строка 2 столбца
  StartRowTableHTML('');
  CellsTableHTML('Строка=1 Столбец=1',1,3,1,'',0,0);
  CellsTableHTML('Строка=1 Столбец=2',3,1,3,'',0,0);
  EndRowTableHTML();
  // 2 строка 2 столбца
  StartRowTableHTML('');
  CellsTableHTML('Строка=2 Столбец=1',3,1,1,'',0,0);
  CellsTableHTML('Строка=2 Столбец=2',1,3,2,'',0,0);
  CellsTableHTML('Строка=2 Столбец=3',1,1,1,'',0,0);
  EndRowTableHTML();
  //Таблица - Конец
  EndTableHTML();
  EndHTML(); // Конец HTML (fileHTML:десткриптор файла)

  startbrowser(ExtractFilePath(Application.ExeName)+'test.html');
end;


end.

