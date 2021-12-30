unit Reports;

{$mode objfpc}{$H+}
{
 Модуль отчетов
}
interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Buttons, Grids, RtfDoc, RtfPars,platproc;

 // procedure ColSize(Grid : TStringGrid); //расчет ширины колонки RTF пропорционально ширине колонки в гриде
  procedure PSheduleSostav(RtfName : string); //печать состава расписания

implementation

uses
   shedule_edit;
// печать состава расписания
procedure PSheduleSostav(RtfName : string);
var
  i,n,pageTw: integer;
  lyam: single;
  //nTem,pageCm: extended;
  //cTem: string;
begin
  with TRtfDoc.Create do  {Create TRtfDoc object}
    begin
    try
      try
        Start(RtfName+'.rtf');  {Create RTF file}
      except
        on EInOutError do  {File read-only or some other I/O error}
          begin
          showmessagealt('Ошибка создания файла ! : '+#13+RtfName);
          Exit;
          end;
        end;

      PageA4;
      BeginPar(0, 0, rtfQuadCenter);
      WriteString('РАСПИСАНИЕ', 0, 20, rtfBold);
      WriteString('движения автобусов', 0, 18, rtfBold);
      WriteString('<<'+trim(Form16.Edit5.text)+'>> № '+trim(Form16.Edit6.Text), 0, 20, rtfBold);
      WriteString('по маршруту '+copy(trim(form16.Edit13.text),1,Length(trim(form16.Edit13.Text))-3)+'ого сообщения', 0, 18, rtfBold);
      WriteString('<<'+trim(Form16.Edit2.text)+'>> № '+trim(Form16.Edit3.Text), 0, 18, rtfBold);

      //WriteString('Тип маршрута: '+trim(Form16.Edit13.Text), 0, 20, rtfBold);
      WriteString('', 0, 16, rtfBold);
      //WriteLine((PageWidth-PageMLeft-PageMRight),'dplinesolid',20);
      //BeginPar(0, 0, rtfQuadLeft);
      EndPar;

      //таблица
      BeginTable(8,0,rtfQuadCenter);
      SetFont(0,14,rtfBold);
      //определяем ширину столбцов
        with Form16.StringGrid7 do
        begin
        For n:=1 to ColCount do
        begin
        lyam := RtfColSize(ColWidths[n-1],Width);
        arTblWidths[n] := lyam;
       // arTblValues[n] := FloatToStr(lyam);
        end;
        end;

      arTblValues[4] := 'ПРИБЫТИЕ';
      arTblValues[6] := 'ОТРАВЛЕНИЕ';
      WriteRow;
      EndTable;

      //таблица
      BeginTable(10,0,rtfQuadCenter);
      //рисуем заголовок

      //определяем ширину столбцов
      With Form16.StringGrid1 do
      begin
        For n:=1 to ColCount do
        begin
        lyam := RtfColSize(ColWidths[n-1],Width);
        arTblWidths[n] := lyam;
        arTblValues[n] := IntToStr(Round(lyam));
        end;
      end;
      SetFont(0,14,rtfBold);
      arTblValues[1] := 'Код о/п';
      arTblValues[2] := 'Наименование остановочного пункта';
      arTblValues[4] := 'Плат. приб';
      arTblValues[5] := 'Время приб';
      arTblValues[6] := 'Время стоянки';
      arTblValues[7] := 'Плат. отпр';
      arTblValues[8] := 'Время отпр';
      arTblValues[9] := 'Расстоян';
      arTblValues[10] := 'Средн скор';

      WriteRow;

      SetFont(0,14,rtfPlain);
      //рисуем данные
      With Form16.StringGrid1 do
      begin
      For i:=1 to RowCount-1 do
        begin
        For n:=1 to ColCount do
        begin
        arTblValues[n] := trim(Cells[n-1,i]);
      //    arTblValues[n] := FloatTOStr(arTblWidths[n]);
        end;
        WriteRow;
        end;
      end;
      EndTable;
      //Закрыть RTF
      Done;

    finally
      Free; //освободить из памяти
      end;
    end;
    showmessagealt('Успешно !');
end;

{//расчет ширины колонки RTF пропорционально ширине колонки в гриде
procedure Col1Size(Grid : TStringGrid);
var
  i,n,pageTw: integer;
  lyam: single;
  nTem,pageCm: single;//extended;
  cTem: string;
begin
     //определяем ширину столбцов
        For n:=1 to Grid.ColCount do
        begin
        //переводим ширину страницы в см (PageWidth константа в RTFdoc)
        With TRtfDoc.Create do
        begin
        PageTw := PageWidth-PageMLeft-PageMRight;
        pageCm := pageTw*2.54/1440;
        end;
        //расчет размера колонок из расчета ширины грида
        //ширина колонки rtf = ширина страницы* ширина столбца грида / ширину грида
        lyam:= pageCm*Grid.ColWidths[n-1]/Grid.Width;
        cTem:= FloatToStrF(lyam,fffixed,5,2);//в строку и отсекаем дробную часть до 2 знаков после запятой
        arTblWidths[n] := ColSize(Grid.ColWidths,Grid.Width);
        end;
end;
 }
end.

