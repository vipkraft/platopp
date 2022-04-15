unit tarif_edit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, Grids, ExtDlgs, EditBtn, Spin,
  ActnList, Menus, strutils, LazUtf8;

type Tmas = array of array of string;

type

  { TFormtarif_edit }

  TFormtarif_edit = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    BitBtn1: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn15: TBitBtn;
    BitBtn16: TBitBtn;
    BitBtn17: TBitBtn;
    BitBtn18: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    DateEdit1: TDateEdit;
    Edit1: TEdit;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
    Image1: TImage;
    Image3: TImage;
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label39: TLabel;
    Label4: TLabel;
    Label40: TLabel;
    Label5: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label6: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label7: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label8: TLabel;
    Label81: TLabel;
    Label9: TLabel;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    PageControl1: TPageControl;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    PopupMenu3: TPopupMenu;
    Shape14: TShape;
    Shape28: TShape;
    Shape29: TShape;
    Shape30: TShape;
    Shape31: TShape;
    Shape32: TShape;
    Shape33: TShape;
    Shape34: TShape;
    Shape35: TShape;
    Shape36: TShape;
    Shape37: TShape;
    Shape38: TShape;
    Shape39: TShape;
    Shape40: TShape;
    Shape41: TShape;
    SpinEdit14: TSpinEdit;
    SpinEdit15: TSpinEdit;
    SpinEdit16: TSpinEdit;
    SpinEdit17: TSpinEdit;
    SpinEdit18: TSpinEdit;
    SpinEdit19: TSpinEdit;
    SpinEdit20: TSpinEdit;
    SpinEdit21: TSpinEdit;
    SpinEdit22: TSpinEdit;
    SpinEdit23: TSpinEdit;
    SpinEdit24: TSpinEdit;
    SpinEdit25: TSpinEdit;
    SpinEdit26: TSpinEdit;
    SpinEdit27: TSpinEdit;
    SpinEdit28: TSpinEdit;
    SpinEdit29: TSpinEdit;
    SpinEdit30: TSpinEdit;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    StringGrid4: TStringGrid;
    StringGrid5: TStringGrid;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn17Click(Sender: TObject);
    procedure BitBtn18Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure StringGrid1EditButtonClick(Sender: TObject);
    procedure StringGrid1EditingDone(Sender: TObject);
    procedure StringGrid2CheckboxToggled(sender: TObject; aCol, aRow: Integer;
      aState: TCheckboxState);
    procedure StringGrid2EditingDone(Sender: TObject);
    procedure StringGrid2KeyPress(Sender: TObject; var Key: char);
    procedure StringGrid3BeforeSelection(Sender: TObject; aCol, aRow: Integer);
    procedure StringGrid3Selection(Sender: TObject; aCol, aRow: Integer);
    procedure StringGrid4EditingDone(Sender: TObject);
    procedure StringGrid4KeyPress(Sender: TObject; var Key: char);
    procedure StringGrid4SelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid5CheckboxToggled(sender: TObject; aCol, aRow: Integer;
      aState: TCheckboxState);
    procedure StringGrid5EditingDone(Sender: TObject);
    procedure StringGrid5KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure BitBtn15Click(Sender: TObject);
    procedure BitBtn16Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure DateEdit1Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Uslugi(); //Первоначальная загрузка услуг в новый тариф
    procedure Lgoty();  //Первоначальная загрузка льгот в новый тариф
    procedure Load_mas(mode:integer);//загрузка массивов
    procedure update_grids();//обновить информацию на форме
    procedure update_mas(stroka:integer);
    procedure load_servers();
    procedure ShowMas(var mas : Tmas); //показать содержимое двумерного массива
  private
    {private declarations}
  public
    {public declarations}
  end; 

var
  Formtarif_edit: TFormtarif_edit;
  // Временные Массивы
  mas_tarif  : array of array of string;
  mas_bagag  : array of array of string;
       //mas_bagag[m,0] пункт
       //mas_bagag[m,1] км от
       //mas_bagag[m,2] км до
       //mas_bagag[m,3] рубли
       //mas_bagag[m,4] проценты
       //mas_bagag[m,5] '1'-редактирование, 2- добавление, 3- удаление ;//флаг изменений
       //mas_bagag[m,6] дата изменений
  mas_uslugi : array of array of string;
      //mas_uslugi[n,0] 'id_point'
      //mas_uslugi[n,1] activ'
      //mas_uslugi[n,2] id_uslugi
      //mas_uslugi[n,3] 'name'
      //mas_uslugi[n,4] 'sposob'
      //mas_uslugi[n,5] 'proc'
      //mas_uslugi[n,6] 'sum'
      //mas_uslugi[n,7] '1'-редактирование, '2'-добавление;//флаг изменений
      //mas_uslugi[n,8] дата последних изменений
  mas_predv  : array of array of string;
  mas_lgoty  : array of array of string;

implementation
 uses
   mainopp,platproc,uslugi_main,
   tarif_main;
{$R *.lfm}

const
  tarif_size=7;
  bagag_size=7;
  uslugi_size=9;
  predv_size=7;
  lgoty_size=7;

  var
    tek_tarif_ind:integer;
    tarif_id:string;
    fledit_bag,fledit_uslug,fledit_lgot,fledit_local:boolean;

{ TFormtarif_edit }


 procedure TFormtarif_edit.ShowMas(var mas : Tmas); //показать содержимое двумерного массива
 var
   n,m,k:integer;
   s:string;
 begin
  //showmessage(floattostr((strtofloat(form16.StringGrid2.Cells[0,form16.StringGrid10.Row])*strtoint(form16.StringGrid10.Cells[2,form16.StringGrid10.Row]))));
 // showmessage(floattostr(strtofloat(form16.StringGrid10.Cells[3,form16.StringGrid10.Row])));
  s:='';
  k:=0;
   for n:=low(mas) to high(mas) do
      begin
       If mas[n,0]='69'
 //          formtarif_edit.StringGrid3.Cells[0,formtarif_edit.StringGrid3.Row]
           then
         begin
          k:=k+1;
          s:=s+padl(inttostr(k),'_',3)+' | ';
       for m:=low(mas[low(mas)]) to high(mas[low(mas)]) do
          begin
            s := s + ' | ' + mas[n,m];
          end;
           s:=s +#13;
         end;
      end;
   showmessagealt(inttostr(length(mas))+#13+s);
   //showmessagealt('grid '+inttostr(form16.StringGrid10.RowCount)+' , '+inttostr(form16.StringGrid10.ColCount));
 end;


// ------------------------Доступные ЛОКАЛЬНЫЕ СИСТЕМЫ--------------------
procedure TFormtarif_edit.load_servers();
var
  n:integer;
begin
  // ------------------------Доступные ЛОКАЛЬНЫЕ СИСТЕМЫ--------------------
     // Подключаемся к серверу
     If not(Connect2(Zconnection1, flagProfile)) then
       begin
        showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
        exit;
       end;
    // Определяем значения
    formtarif_edit.ZQuery1.SQL.Clear;
    // Новый вариант  данные из администратора , таблица
     //formtarif_edit.ZQuery1.SQL.add('select point_id  ');
     //formtarif_edit.ZQuery1.SQL.add(',(select b.name FROM av_spr_point b WHERE a.point_id=b.id order by del, createdate desc limit 1) pname ');
     //formtarif_edit.ZQuery1.SQL.add('  from av_servers a where a.del=0 and a.usetarif=1 and a.real_virtual=1 ');
     //formtarif_edit.ZQuery1.SQL.add('union all ');
     //formtarif_edit.ZQuery1.SQL.add('select point_id ');
     //formtarif_edit.ZQuery1.SQL.add(',(select b.name FROM av_spr_point b WHERE a.point_id=b.id order by del, createdate desc limit 1) pname ');
     //formtarif_edit.ZQuery1.SQL.add('  from av_servers a where a.del=0 and a.usetarif=1 and a.real_virtual=0 ');
     formtarif_edit.ZQuery1.SQL.add('SELECT get_servers_list('+quotedstr('srvs')+',2,1,'+quotedstr('')+');');
     formtarif_edit.ZQuery1.SQL.add('FETCH ALL IN srvs;');
     //ORDER BY b.name;');

     //showmessagealt(formtarif_edit.ZQuery1.SQL.Text);
       try
     formtarif_edit.ZQuery1.open;
    except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+formtarif_edit.ZQuery1.SQL.Text);
      formtarif_edit.ZQuery1.Close;
      formtarif_edit.Zconnection1.disconnect;
      exit;
    end;
    //showmessagealt(formtarif_edit.ZQuery1.SQL.Text);
    //showmessagealt(inttostr(formtarif_edit.ZQuery1.RecordCount));
    if formtarif_edit.ZQuery1.RecordCount=0 then
      begin
        showmessagealt('Нет установленных локальных систем ПЛАТФОРМА АВ !');
        formtarif_edit.Zconnection1.Disconnect;
        exit;
      end;
    for n:=1 to formtarif_edit.ZQuery1.RecordCount do
      begin
       if formtarif_edit.ZQuery1.FieldByName('usetarif').asInteger=1 then
         begin
       formtarif_edit.StringGrid3.RowCount:=formtarif_edit.StringGrid3.RowCount+1;
       formtarif_edit.StringGrid3.Cells[0,formtarif_edit.StringGrid3.RowCount-1]:=formtarif_edit.ZQuery1.FieldByName('point_id').asString;
       formtarif_edit.StringGrid3.Cells[1,formtarif_edit.StringGrid3.RowCount-1]:=formtarif_edit.ZQuery1.FieldByName('pname').asString;
       end;
       //showmessage(formtarif_edit.ZQuery1.FieldByName('id').asString+' - '+ formtarif_edit.ZQuery1.FieldByName('name').asString);
       formtarif_edit.ZQuery1.Next;
      end;
      formtarif_edit.ZQuery1.Close;
      formtarif_edit.Zconnection1.disconnect;
 end;


//обновить значения массивов с формы
 procedure TFormtarif_edit.update_mas(stroka:integer);
  var
  n,m,k,j:integer;
  mas_temp:array of array of string;
  str:string;
  flpoint,flchange,flfind:boolean;
  tekpoint:integer;
   begin
     try
       tekpoint:=strtoint(trim(Formtarif_edit.StringGrid3.Cells[0,stroka]));
      except
        on exception: EConvertError do
             begin
               showmessagealt('ОШИБКА КОНВЕРТАЦИИ пункта продажи !');
               exit;
             end;
        end;

  //===================== Записываем/изменяем массив mas_tarif==========================
  //1.Удаляем из массива записи с текущим ID
  // Проставляем пустые значения для массива по условию
  setlength(mas_temp,0,0);
  for n:=0 to length(mas_tarif)-1 do
   begin
    if not(trim(mas_tarif[n,0])='') then
      begin
           try
         if strtoint(trim(mas_tarif[n,0]))=tekpoint then mas_tarif[n,0]:='';
            except
             on exception: EConvertError do
             begin
               showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!');
               continue;
             end;
             end;
      end;
      if not(trim(mas_tarif[n,0])='') then
        begin
          setlength(mas_temp,length(mas_temp)+1,tarif_size);
         for m:=0 to tarif_size-1 do
          begin
           mas_temp[length(mas_temp)-1,m]:=mas_tarif[n,m];
          end;
        end;
    end;
    SetLength(mas_tarif,0,0);
    SetLength(mas_tarif,length(mas_temp),tarif_size);
    for n:=0 to length(mas_temp)-1 do
     begin
       for m:=0 to tarif_size-1 do
        begin
         mas_tarif[n,m]:=mas_temp[n,m];
        end;
     end;
    setlength(mas_temp,0,0);

  //2.Добавляем данные в массив из Stringgrid
  if formtarif_edit.StringGrid1.RowCount>1 then
    begin
         for n:=1 to formtarif_edit.StringGrid1.RowCount-1 do
          begin
            setlength(mas_tarif,length(mas_tarif)+1,tarif_size);
            mas_tarif[length(mas_tarif)-1,0]:=inttostr(tekpoint);
             for m:=1 to StringGrid1.ColCount do
               begin
                mas_tarif[length(mas_tarif)-1,m]:=formtarif_edit.StringGrid1.Cells[m-1,n];
               end;
          end;
    end;

  //===================== Записываем/изменяем массив mas_uslugi==========================
  //1.Удаляем из массива записи с текущим ID
  // Проставляем пустые значения для массива по условию
  //setlength(mas_temp,0,0);
  //for n:=0 to length(mas_uslugi)-1 do
  // begin
  //  if not(trim(mas_uslugi[n,0])='') then
  //    begin
  //     try
  //      if strtoint(trim(mas_uslugi[n,0]))=strtoint(trim(Formtarif_edit.StringGrid3.Cells[0,stroka])) then mas_uslugi[n,0]:='';
  //       except
  //           on exception: EConvertError do
  //           begin
  //             showmessagealt('ОШИБКА КОНВЕРТАЦИИ id пункта продажи!!!');
  //             continue;
  //           end;
  //           end;
  //    end;
  //    if not(trim(mas_uslugi[n,0])='') then
  //      begin
  //        setlength(mas_temp,length(mas_temp)+1,uslugi_size);
  //       for m:=0 to uslugi_size-1 do
  //        begin
  //         mas_temp[length(mas_temp)-1,m]:=mas_uslugi[n,m];
  //        end;
  //      end;
  //  end;
  //  SetLength(mas_uslugi,0,0);
  //  SetLength(mas_uslugi,length(mas_temp),uslugi_size);
  //  for n:=0 to length(mas_temp)-1 do
  //   begin
  //     for m:=0 to uslugi_size-1 do
  //      begin
  //       mas_uslugi[n,m]:=mas_temp[n,m];
  //      end;
  //   end;
  //  setlength(mas_temp,0,0);
  //
  //  //2.Добавляем данные в массив из Stringgrid
  //if formtarif_edit.StringGrid2.RowCount>1 then
  //  begin
  //       for n:=1 to formtarif_edit.StringGrid2.RowCount-1 do
  //        begin
  //          setlength(mas_uslugi,length(mas_uslugi)+1,uslugi_size);
  //          mas_uslugi[length(mas_uslugi)-1,0]:=formtarif_edit.StringGrid3.Cells[0,stroka];
  //           for m:=1 to uslugi_size do
  //             begin
  //              mas_uslugi[length(mas_uslugi)-1,m]:=formtarif_edit.StringGrid2.Cells[m-1,n];
  //             end;
  //           mas_uslugi[length(mas_uslugi)-1,uslugi_size]:=formtarif_edit.StringGrid3.Cells[0,stroka];
  //        end;
  //  end;
 If fledit_uslug then
 begin
   if formtarif_edit.StringGrid2.RowCount>1 then
     begin
       flpoint:=false;
         for n:=1 to formtarif_edit.StringGrid2.RowCount-1 do
          begin
           //если уже нашли пункт или первый проход - ищем данные и сравниваем
            If flpoint or (n=1) then
            begin
             flfind:=false;
            for m:=0 to length(mas_uslugi)-1 do
               begin
                str:='';//$
                 flchange:=false;
                  if not(trim(mas_uslugi[m,0])='') then
                     begin
                      try
                       if strtoint(trim(mas_uslugi[m,0]))=tekpoint then
                          begin
                           flpoint:=true;
                           //ищем id услуги
                           If mas_uslugi[m,2]=formtarif_edit.StringGrid2.Cells[1,n] then
                              begin
                                flfind:=true;
                                for j:=1 to uslugi_size-3 do
                                  begin
                                    str:=str+mas_uslugi[m,j]+#13;//$
                                    If mas_uslugi[m,j]<>formtarif_edit.StringGrid2.Cells[j-1,n] then
                                       begin
                                         mas_uslugi[m,j]:=formtarif_edit.StringGrid2.Cells[j-1,n];
                                         flchange:=true;
                                        end;
                                    end;
                                 //showmessage('id_point '+mas_uslugi[m,0]+#13+str);
                                If flchange then
                                   begin
                                    //если еще не было сохранений этой услуги, то флаг не меняем
                                    If mas_uslugi[m,uslugi_size-2]<>'2' then
                                        mas_uslugi[m,uslugi_size-2]:='1';//флаг изменений
                                     mas_uslugi[m,uslugi_size-1]:=formatdatetime('dd-mm-yyyy hh:nn',now());
                                    end;
                              end;
                           If flfind then
                            begin
                             //showmessage(str);//$
                             break;
                             end;
                           end;
                      except
                        on exception: EConvertError do
                        begin
                          showmessagealt('ОШИБКА КОНВЕРТАЦИИ id пункта продажи!!!');
                          continue;
                        end;
                      end;
                     end;
                  end;
            end;
            //добавляем новую запись в массив
            If (not flpoint) or (not flfind) then
               begin
                //если не пустое значение, то добавляем
               If (formtarif_edit.StringGrid2.Cells[5,n]<>'0')
                   and (formtarif_edit.StringGrid2.Cells[5,n]<>'0.0')
                   and (formtarif_edit.StringGrid2.Cells[5,n]<>'0.00')
                   and (formtarif_edit.StringGrid2.Cells[5,n]<>'0,0') then
                begin
                 SetLength(mas_uslugi,length(mas_uslugi),uslugi_size);
                 mas_uslugi[length(mas_uslugi)-1,0]:=inttostr(tekpoint);
                    for j:=1 to uslugi_size-3 do
                       begin
                         mas_uslugi[length(mas_uslugi)-1,j]:=formtarif_edit.StringGrid2.Cells[j-1,n];
                       end;
                 mas_uslugi[length(mas_uslugi)-1,uslugi_size-2]:='2';//флаг изменений
                 mas_uslugi[length(mas_uslugi)-1,uslugi_size-1]:=formatdatetime('dd-mm-yyyy hh:nn',now());
                end;
               end;
            end;
         end;
  end;
  fledit_uslug:=false;


  //===================== Записываем/изменяем массив mas_bagag==========================
    //1.Удаляем из массива записи с текущим ID
  // Проставляем пустые значения для массива по условию
  //setlength(mas_temp,0,0);
  //for n:=0 to length(mas_bagag)-1 do
  // begin
  //  if not(trim(mas_bagag[n,0])='') then
  //    begin
  //     try
  //      if strtoint(trim(mas_bagag[n,0]))=strtoint(trim(Formtarif_edit.StringGrid3.Cells[0,stroka])) then mas_bagag[n,0]:='';
  //       except
  //           on exception: EConvertError do
  //           begin
  //             showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!');
  //             continue;
  //           end;
  //           end;
  //    end;
  //    if not(trim(mas_bagag[n,0])='') then
  //      begin
  //        setlength(mas_temp,length(mas_temp)+1,bagag_size);
  //       for m:=0 to bagag_size-1 do
  //        begin
  //         mas_temp[length(mas_temp)-1,m]:=mas_bagag[n,m];
  //        end;
  //      end;
  //  end;
  //  SetLength(mas_bagag,0,0);
  //  SetLength(mas_bagag,length(mas_temp),bagag_size);
  //  for n:=0 to length(mas_temp)-1 do
  //   begin
  //     for m:=0 to bagag_size-1 do
  //      begin
  //       mas_bagag[n,m]:=mas_temp[n,m];
  //      end;
  //   end;
  //  setlength(mas_temp,0,0);
  //
  //  //2.Добавляем данные в массив из Stringgrid
  //if formtarif_edit.StringGrid4.RowCount>1 then
  //  begin
  //       for n:=1 to formtarif_edit.StringGrid4.RowCount-1 do
  //        begin
  //          setlength(mas_bagag,length(mas_bagag)+1,bagag_size);
  //          mas_bagag[length(mas_bagag)-1,0]:=formtarif_edit.StringGrid3.Cells[0,stroka];
  //           for m:=0 to 3 do
  //             begin
  //              mas_bagag[length(mas_bagag)-1,m+1]:=formtarif_edit.StringGrid4.Cells[m,n];
  //             end;
  //        end;
  //  end;

  If fledit_bag then
 begin

         //for n:=1 to formtarif_edit.StringGrid4.RowCount-1 do
          //begin
           //если уже нашли пункт или первый проход - ищем данные и сравниваем
            //If flpoint or (n=1) then
            //begin

            //ищем отредактированные и удаленные
            for m:=0 to length(mas_bagag)-1 do
               begin
                flpoint:=false;
                flfind:=false;
                str:='';//$
                 flchange:=false;
                 //если не пустое значение массива и не удален
                  if not(trim(mas_bagag[m,0])='') and (mas_bagag[m,bagag_size-2]<>'3') then
                     begin
                      try
                       //ищем пункт продажи в массиве
                       if strtoint(trim(mas_bagag[m,0]))=tekpoint then
                          begin
                           flpoint:=true;
                           //ищем грид = массив
                             for n:=1 to formtarif_edit.StringGrid4.RowCount-1 do
                                begin
                           //ищем km от и km до
                                   If (mas_bagag[m,1]=formtarif_edit.StringGrid4.Cells[0,n])
                                       and (mas_bagag[m,2]=formtarif_edit.StringGrid4.Cells[1,n])
                                       then
                                          begin
                                           flfind:=true;
                                           //showmessage('mas: '+mas_bagag[m,3]+#13+mas_bagag[m,4]+#13+
                                           //          'grid: '+formtarif_edit.StringGrid4.Cells[1,n]+#13
                                           //          +formtarif_edit.StringGrid4.Cells[2,n]+#13
                                           //          +formtarif_edit.StringGrid4.Cells[3,n]);//$
                                            //str:=str+mas_bagag[m,1]+#13+mas_bagag[m,2]+#13+mas_bagag[m,3]+#13+mas_bagag[m,4]+#13;//$
                                            //showmessage(str);
                                            If (mas_bagag[m,3]<>formtarif_edit.StringGrid4.Cells[2,n])
                                                OR (mas_bagag[m,4]<>formtarif_edit.StringGrid4.Cells[3,n])
                                                then
                                                    begin

                                                     mas_bagag[m,3]:=formtarif_edit.StringGrid4.Cells[2,n];
                                                     mas_bagag[m,4]:=formtarif_edit.StringGrid4.Cells[3,n];
                                                     mas_bagag[m,bagag_size-2]:='1';//флаг изменений
                                                     mas_bagag[m,bagag_size-1]:=formatdatetime('dd-mm-yyyy hh:nn',now());
                                                     flchange:=true;
                                                     break;
                                                    end;
                                              end;
                                 //showmessage('id_point '+mas_bagag[m,0]+#13+str);
                                 end;
                             //Если пункт нашли, а строки соответсвия в гриде нет, значит удаляем из массива
                              If flpoint and (not flfind) then
                                   begin
                                      mas_bagag[m,bagag_size-2]:='3';//флаг удалени
                                    end;

                           end;
                      except
                        on exception: EConvertError do
                        begin
                          showmessagealt('ОШИБКА КОНВЕРТАЦИИ id пункта продажи!!!');
                          continue;
                        end;
                      end;
                     end;
                  end;
            //end;
  //ищем новое в гриде
    if formtarif_edit.StringGrid4.RowCount>1 then
     begin
       for n:=1 to formtarif_edit.StringGrid4.RowCount-1 do
         begin
            flfind:=false;
            flpoint:=false;
           for m:=0 to length(mas_bagag)-1 do
             begin
                 //если не пустое значение массива и не удален
                  if not(trim(mas_bagag[m,0])='') and (mas_bagag[m,bagag_size-2]<>'3') then
                     begin
                      try
                       //ищем пункт продажи в массиве
                       if strtoint(trim(mas_bagag[m,0]))=tekpoint then
                          begin
                           flpoint:=true;
                           //ищем km от и km до
                                   If (mas_bagag[m,1]=formtarif_edit.StringGrid4.Cells[0,n])
                                       and (mas_bagag[m,2]=formtarif_edit.StringGrid4.Cells[1,n])
                                       then
                                          begin
                                           flfind:=true;
                                            break;
                                          end;
                                 //showmessage('id_point '+mas_bagag[m,0]+#13+str);

                             end;
                         except
                        on exception: EConvertError do
                        begin
                          showmessagealt('ОШИБКА КОНВЕРТАЦИИ id пункта продажи!!!');
                          continue;
                        end;
                       end;
                      end;
                  end;
            //добавляем новую запись в массив
            If (not flfind) then
               begin
                 SetLength(mas_bagag,length(mas_bagag),bagag_size);
                 mas_bagag[length(mas_bagag)-1,0]:=inttostr(tekpoint);
                    for j:=1 to bagag_size-3 do
                       begin
                         mas_bagag[length(mas_bagag)-1,j]:=formtarif_edit.StringGrid4.Cells[j-1,n];
                       end;
                 mas_bagag[length(mas_bagag)-1,bagag_size-2]:='2';//флаг изменений
                 mas_bagag[length(mas_bagag)-1,bagag_size-1]:=formatdatetime('dd-mm-yyyy hh:nn',now());
               end;
       end;
     end;
  end;
  fledit_bag:=false;


   //end;

  //===================== Записываем/изменяем массив mas_predv==========================
    //1.Удаляем из массива записи с текущим ID
  // Проставляем пустые значения для массива по условию

  setlength(mas_temp,0,0);
  for n:=0 to length(mas_predv)-1 do
   begin
        if (trim(mas_predv[n,0]))<>inttostr(tekpoint) then
      begin
          setlength(mas_temp,length(mas_temp)+1,predv_size);
         for m:=0 to predv_size-1 do
          begin
           mas_temp[length(mas_temp)-1,m]:=mas_predv[n,m];
          end;
        end;
    end;
    SetLength(mas_predv,0,0);
    SetLength(mas_predv,length(mas_temp),predv_size);
    for n:=0 to length(mas_temp)-1 do
     begin
       for m:=0 to predv_size-1 do
        begin
         mas_predv[n,m]:=mas_temp[n,m];
        end;
     end;
    setlength(mas_temp,0,0);

    //2.Добавляем данные в массив из SpinEdit27
   setlength(mas_predv,length(mas_predv)+1,predv_size);
   mas_predv[length(mas_predv)-1,0]:=inttostr(tekpoint);
   mas_predv[length(mas_predv)-1,1]:=inttostr(formtarif_edit.SpinEdit27.Value);
   mas_predv[length(mas_predv)-1,2]:=inttostr(formtarif_edit.SpinEdit29.Value);
   mas_predv[length(mas_predv)-1,3]:=IFTHEN(formtarif_edit.CheckBox1.Checked=true,'TRUE','FALSE');
   mas_predv[length(mas_predv)-1,4]:=inttostr(formtarif_edit.SpinEdit30.Value);
   If utf8pos('|',formtarif_edit.Edit1.Text)>0 then
     mas_predv[length(mas_predv)-1,5]:=trim(utf8copy(formtarif_edit.Edit1.Text,1,utf8pos('|',formtarif_edit.Edit1.Text)-1))
   else
       mas_predv[length(mas_predv)-1,5]:='0';
   mas_predv[length(mas_predv)-1,6]:=trim(utf8copy(formtarif_edit.Edit1.Text,utf8pos('|',formtarif_edit.Edit1.Text)+1,utf8length(formtarif_edit.Edit1.Text)-utf8pos('|',formtarif_edit.Edit1.Text)));
   end;



//======================================= Заполнение STRINGGRID из массивов ===================================
 procedure TFormtarif_edit.update_grids();
  var
   n,m:integer;
 begin
    // =======================Обновляем сетки=========================
    // ========================= Расставляем условия редактирования для локальных систем ==============
   if Formtarif_edit.StringGrid3.Row>0 then
     begin
     for n:= 1 to 4 do
        begin
         Formtarif_edit.StringGrid1.Columns[n].ReadOnly:=true;
         Formtarif_edit.StringGrid1.Columns[0].Font.Color:=clGray;
         Formtarif_edit.StringGrid1.Columns[n].Font.Color:=clGray;
        end;
     end
  else
     begin
       for n:= 1 to 4 do
         begin
          Formtarif_edit.StringGrid1.Columns[n].ReadOnly:=false;
          Formtarif_edit.StringGrid1.Columns[0].Font.Color:=clBlack;
          Formtarif_edit.StringGrid1.Columns[n].Font.Color:=clBlack;
         end;
     end;
   // ------------------------ Доступные Закладки ---------------------
  if Formtarif_edit.StringGrid3.Row>0 then
     begin
       //Formtarif_edit.PageControl1.Page[2].TabVisible:=false;
       //Formtarif_edit.PageControl1.Page[3].TabVisible:=false;
       //Formtarif_edit.PageControl1.Page[4].TabVisible:=false;
       Formtarif_edit.BitBtn9.Visible:=false;
       Formtarif_edit.BitBtn10.Visible:=false;
     end
  else
     begin
      Formtarif_edit.PageControl1.Page[2].TabVisible:=true;
      Formtarif_edit.PageControl1.Page[3].TabVisible:=true;
      Formtarif_edit.PageControl1.Page[4].TabVisible:=true;
      Formtarif_edit.BitBtn9.Visible:=true;
      Formtarif_edit.BitBtn10.Visible:=true;
     end;


   //=============== Тарифы ==============================
  Formtarif_edit.StringGrid1.RowCount:=1;
  for n:=0 to length(mas_tarif)-1 do
    begin
     if trim(mas_tarif[n,0])=trim(Formtarif_edit.StringGrid3.Cells[0,Formtarif_edit.StringGrid3.row]) then
       begin
       Formtarif_edit.StringGrid1.RowCount:=Formtarif_edit.StringGrid1.RowCount+1;
       for m:=0 to 5 do
         begin
           Formtarif_edit.StringGrid1.Cells[m,Formtarif_edit.StringGrid1.RowCount-1]:=mas_tarif[n,m+1];
         end;
      end;
    end;

  //=============== Услуги ==============================
  Formtarif_edit.StringGrid2.RowCount:=1;
  for n:=0 to length(mas_uslugi)-1 do
    begin
      if trim(mas_uslugi[n,0])=trim(Formtarif_edit.StringGrid3.Cells[0,Formtarif_edit.StringGrid3.row]) then
       begin
         Formtarif_edit.StringGrid2.RowCount:=Formtarif_edit.StringGrid2.RowCount+1;
         Formtarif_edit.StringGrid2.Columns[0].ValueUnchecked:='0';
         Formtarif_edit.StringGrid2.Columns[0].ValueChecked:='1';

         for m:=0 to 5 do
           begin
             Formtarif_edit.StringGrid2.Cells[m,Formtarif_edit.StringGrid2.RowCount-1]:=trim(mas_uslugi[n,m+1]);
           end;
         formtarif_edit.Label9.Caption:=mas_uslugi[n,uslugi_size-1];//дата последних изменений
       end;
    end;
  //Formtarif_edit.uslugi();

  //=============== Багаж ==============================
  Formtarif_edit.StringGrid4.RowCount:=1;
  //теперь собственно сами данные
  for n:=0 to length(mas_bagag)-1 do
    begin
     if trim(mas_bagag[n,0])=trim(Formtarif_edit.StringGrid3.Cells[0,Formtarif_edit.StringGrid3.row]) then
       begin
       Formtarif_edit.StringGrid4.RowCount:=Formtarif_edit.StringGrid4.RowCount+1;
       for m:=0 to 3 do
         begin
           Formtarif_edit.StringGrid4.Cells[m,Formtarif_edit.StringGrid4.RowCount-1]:=mas_bagag[n,m+1];
         end;
       If mas_bagag[n,bagag_size-1]<>'' then
             label5.Caption:='с последними изменениями от: '+mas_bagag[n,bagag_size-1];
      end;
    end;

  //=============== КОЛИЧЕСТВО ДНЕЙ ПРЕДВАРИТЕЛЬНОЙ ПРОДАЖИ ==============================
  for n:=0 to length(mas_predv)-1 do
    begin
     if trim(mas_predv[n,0])=trim(Formtarif_edit.StringGrid3.Cells[0,Formtarif_edit.StringGrid3.row]) then
       begin
       //showmessage(mas_predv[n,4]);//$
        //formtarif.Edit1.Text:='0';
        Formtarif_edit.SpinEdit27.Value:=0;
        Formtarif_edit.SpinEdit29.Value:=0;
        Formtarif_edit.SpinEdit30.Value:=0;
       try
           Formtarif_edit.SpinEdit27.Value:=strtoint(mas_predv[n,1]);
            except
             on exception: EConvertError do
             begin
               showmessagealt('ОШИБКА КОНВЕРТАЦИИ дня пред.продажи !!!'+#13+mas_predv[n,1]);
               continue;
             end;
          end;
            try
           Formtarif_edit.SpinEdit29.Value:=strtoint(mas_predv[n,2]);
            except
             on exception: EConvertError do
             begin
               showmessagealt('ОШИБКА КОНВЕРТАЦИИ для время снятия брони !!!'+#13+mas_predv[n,2]);
               continue;
             end;
          end;
            IF upperall(trim(mas_predv[n,3]))='FALSE' THEN formtarif_edit.CheckBox1.Checked:=false else formtarif_edit.CheckBox1.Checked:=true;


            try
           Formtarif_edit.SpinEdit30.Value:=strtoint(mas_predv[n,4]);
            except
             on exception: EConvertError do
             begin
               showmessagealt('ОШИБКА КОНВЕРТАЦИИ для минимально дней сбора !!!'+#13+mas_predv[n,4]);
               continue;
             end;
          end;
         FormTarif_edit.Edit1.text:=mas_predv[n,5]+ ' | '+mas_predv[n,6];
         break;
       end;
    end;

 end;


//======================================= Заполнение массивов для редактирования ===================================
//mode: 0 - без дефолтных (норм) тарифов билетов/багажа
//mode: 1 - с дефолтными (нормами) тарифов билетов/багажа
 procedure TFormtarif_edit.Load_mas(mode:integer);
  var
   n,m:integer;
 begin
  with formtarif_edit do
   begin
 //Если первая запись норм тарифов, выход
   if formtarif.StringGrid1.RowCount=1 then exit;

   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
  //------------------ Определяем НАЧАЛЬНЫЕ значения ТАРИФА---------------------------
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('Select * from av_tarif where del=0 and id='+trim(tarif_id)+' order by createdate desc limit 1;');
  //showmessage(ZQuery1.SQL.text);//$
     try
    ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
    exit;
  end;

  if  ZQuery1.RecordCount<1 then
     begin
       showmessagealt('Нет данных для редактирования !');
        ZQuery1.close;
        Zconnection1.disconnect;
       exit;
     end;
  //label43.Caption:=label43.Caption+#32+formatdatetime('yyyy-mm-dd hh:nn', ZQuery1.FieldByName('createdate').AsDateTime);
  //------------------------ Дата ТАРИФА
   DateEdit1.Date:= ZQuery1.FieldByName('datetarif').AsDateTime;

  //-------------------------УСЛОВИЯ ВОЗВРАТА------------------------------------------
   SpinEdit14.value:= ZQuery1.FieldByName('wozbild').asInteger;
   SpinEdit15.value:= ZQuery1.FieldByName('wozbildproc').asInteger;
   SpinEdit16.value:= ZQuery1.FieldByName('wozbilw').asInteger;
   SpinEdit17.value:= ZQuery1.FieldByName('wozbilwproc').asInteger;
   SpinEdit18.value:= ZQuery1.FieldByName('wozbilp').asInteger;
   SpinEdit19.value:= ZQuery1.FieldByName('wozbilpproc').asInteger;
   SpinEdit20.value:= ZQuery1.FieldByName('wozbagd').asInteger;
   SpinEdit21.value:= ZQuery1.FieldByName('wozbagdproc').asInteger;
   SpinEdit22.value:= ZQuery1.FieldByName('wozbagw').asInteger;
   SpinEdit23.value:= ZQuery1.FieldByName('wozbagwproc').asInteger;
   SpinEdit24.value:= ZQuery1.FieldByName('wozbagp').asInteger;
   SpinEdit25.value:= ZQuery1.FieldByName('wozbagpproc').asInteger;

  // ------------------------ ОПЦИИ ----------------------------------------------------
   SpinEdit26.value:= ZQuery1.FieldByName('kmh').asInteger;
   SpinEdit28.value:= ZQuery1.FieldByName('deti').asInteger;
   CheckBox1.Checked:= ZQuery1.FieldByName('prigorod_rajon').asBoolean;
   If  ZQuery1.FieldByName('centless').asInteger=1 then
     CheckBox2.Checked:=true
    else
       CheckBox2.Checked:=false;

  //-------------------- Список КАТЕГОРИЙ ЛЬГОТ ---------------------------------------
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('SELECT a.id_lgot,b.name,b.zakon,a.activ,a.sum,a.proc,a.createdate');
   ZQuery1.SQL.add('FROM av_tarif_lgot a,av_spr_lgot b');
   ZQuery1.SQL.add('WHERE a.id_lgot = b.id and a.del=0 and b.del=0 and');
   ZQuery1.SQL.add('a.id_tarif='+trim(tarif_id)+' order by a.id_lgot;');
  //showmessage(ZQuery1.SQL.text);//$
  try
    ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
    exit;
  end;
  //showmessagealt( ZQuery1.SQL.text);
  setlength(mas_lgoty,0,0);
  if  ZQuery1.RecordCount>0 then
   begin
    Label7.Caption:=formatdatetime('dd-mm-yyyy hh:nn', ZQuery1.FieldByName('createdate').AsDateTime);

    for n:=0 to  ZQuery1.RecordCount-1 do
      begin
        setlength(mas_lgoty,length(mas_lgoty)+1,lgoty_size);
        mas_lgoty[n,0]:= ZQuery1.FieldByName('activ').asString;
        mas_lgoty[n,1]:= ZQuery1.FieldByName('id_lgot').asString;
        mas_lgoty[n,2]:= ZQuery1.FieldByName('name').asString;
        mas_lgoty[n,3]:= ZQuery1.FieldByName('zakon').asString;
        mas_lgoty[n,4]:= ZQuery1.FieldByName('proc').asString;
        if pos('.',trim( ZQuery1.FieldByName('sum').asString))>0 then
           begin
            mas_lgoty[n,5]:=trim( ZQuery1.FieldByName('sum').asString);
           end
        else
           begin
            mas_lgoty[n,5]:=trim( ZQuery1.FieldByName('sum').asString)+'.00';
           end;
         ZQuery1.Next;
      end;
   end;
   // lgoty();

  //если режим редактирования или загружать новое со старыми значениями
  If mode=1 then
   begin
  //-------------------- Список локальных НОРМ ТАРИФОВ----------------------------------
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('Select * from av_tarif_local where del=0 and id_tarif='+trim(tarif_id)+' order by id_point,id_n ASC;');
   //showmessage(ZQuery1.SQL.text);//$
     try
    ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
    exit;
  end;
  if  ZQuery1.RecordCount<1 then
     begin
       showmessagealt('Нет данных для редактирования !');
        ZQuery1.close;
        Zconnection1.disconnect;
       exit;
     end;
  setlength(mas_tarif,0,0);
  for n:=0 to  ZQuery1.RecordCount-1 do
     begin
      setlength(mas_tarif,length(mas_tarif)+1,lgoty_size);
      mas_tarif[n,0]:=trim( ZQuery1.FieldByName('id_point').asString);
      mas_tarif[n,1]:=trim( ZQuery1.FieldByName('id_n').asString);
      mas_tarif[n,2]:=trim( ZQuery1.FieldByName('name').asString);
      // Тип МАРШРУТА
      if  ZQuery1.FieldByName('typpath').asInteger=0 then  mas_tarif[n,3]:='-любой-';
      if  ZQuery1.FieldByName('typpath').asInteger=1 then  mas_tarif[n,3]:=cMezhgorod;
      if  ZQuery1.FieldByName('typpath').asInteger=2 then  mas_tarif[n,3]:=cPrigorod;
      if  ZQuery1.FieldByName('typpath').asInteger=3 then  mas_tarif[n,3]:='Межобластной\Межкраевой';
      if  ZQuery1.FieldByName('typpath').asInteger=4 then  mas_tarif[n,3]:=cGos;
      // Класс АТС
      if  ZQuery1.FieldByName('klassats').asInteger=0 then  mas_tarif[n,4]:='-любой-';
      if  ZQuery1.FieldByName('klassats').asInteger=1 then  mas_tarif[n,4]:='Мягкий';
      if  ZQuery1.FieldByName('klassats').asInteger=2 then  mas_tarif[n,4]:='Жесткий';
      // Тип АТС
      if  ZQuery1.FieldByName('typats').asInteger=0 then  mas_tarif[n,5]:='-любой-';
      if  ZQuery1.FieldByName('typats').asInteger=1 then  mas_tarif[n,5]:='М2';
      if  ZQuery1.FieldByName('typats').asInteger=2 then  mas_tarif[n,5]:='М3';
      // Сумма
      if pos('.',trim( ZQuery1.FieldByName('sum').asString))>0 then
         mas_tarif[n,6]:=trim( ZQuery1.FieldByName('sum').asString)
      else
         mas_tarif[n,6]:=trim( ZQuery1.FieldByName('sum').asString)+'.00';
       ZQuery1.Next;
     end;

   //-------------------- Список локальных НОРМ БАГАЖА----------------------------------
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('Select * from av_tarif_bagag where del=0 and id_tarif='+trim(tarif_id)+' ORDER BY km_ot;');
     try
    ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
    exit;
  end;
  if  ZQuery1.RecordCount<1 then
     begin
       showmessagealt('Нет данных для редактирования !');
        ZQuery1.close;
        Zconnection1.disconnect;
       exit;
     end;
  setlength(mas_bagag,0,0);
  for n:=0 to  ZQuery1.RecordCount-1 do
     begin
      setlength(mas_bagag,length(mas_bagag)+1,bagag_size);
      mas_bagag[n,0]:= ZQuery1.FieldByName('id_point').asString;
      mas_bagag[n,1]:= ZQuery1.FieldByName('km_ot').asString;
      mas_bagag[n,2]:= ZQuery1.FieldByName('km_do').asString;
     if pos('.',trim( ZQuery1.FieldByName('sum').asString))>0 then
         mas_bagag[n,3]:=trim( ZQuery1.FieldByName('sum').asString)
     else
         mas_bagag[n,3]:=trim( ZQuery1.FieldByName('sum').asString)+'.00';
      mas_bagag[n,4]:= ZQuery1.FieldByName('proc').asString;
      mas_bagag[n,5]:='';//флаг изменений
      mas_bagag[n,6]:=formatdatetime('dd-mm-yyyy hh:nn', ZQuery1.FieldByName('createdate').AsDateTime);//дата последних изменений
       ZQuery1.Next;
     end;
  end;

  //-------------------- Список локальных НОРМ Количества дней предварительной продажи билетов ----------------------------------
  ZQuery1.SQL.Clear;
    ZQuery1.SQL.add('Select a.* ');
   ZQuery1.SQL.add(',(select b.name from av_spr_uslugi b where b.id=a.id_uslugi order by b.del asc,b.createdate desc limit 1) as name_uslugi ');
   ZQuery1.SQL.add(' from av_tarif_predv a where a.del=0 and a.id_tarif='+trim(tarif_id)+';');
 // ZQuery1.SQL.add('Select * from av_tarif_predv where del=0 and id_tarif='+trim(tarif_id)+';');
    //showmessage( ZQuery1.SQL.Text);//$
    try
    ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
    exit;
  end;
 if  ZQuery1.RecordCount<1 then
    begin
      showmessagealt('Нет данных для редактирования !');
       ZQuery1.close;
       Zconnection1.disconnect;
      exit;
    end;
 setlength(mas_predv,0,0);
 for n:=0 to  ZQuery1.RecordCount-1 do
    begin
     setlength(mas_predv,length(mas_predv)+1,predv_size);
     mas_predv[n,0]:= ZQuery1.FieldByName('id_point').asString;
     mas_predv[n,1]:= ZQuery1.FieldByName('kolday').asString;
     mas_predv[n,2]:= ZQuery1.FieldByName('bron_cancel').asString;
     mas_predv[n,3]:= ZQuery1.FieldByName('prigorod_rajon').asString;
     mas_predv[n,4]:= ZQuery1.FieldByName('days_min').asString;
     mas_predv[n,5]:= ZQuery1.FieldByName('id_uslugi').asString;
     mas_predv[n,6]:= ZQuery1.FieldByName('name_uslugi').asString;
      ZQuery1.Next;
    end;
 //showmas(mas_predv);
 //-------------------- Список локальных НОРМ УСЛУГ----------------------------------
   ZQuery1.SQL.Clear;
  // ZQuery1.SQL.add('Select distinct t.id_uslugi,  t.activ, t.sum, t.proc , t.id_point, t.createdate ');
  // ZQuery1.SQL.add(',(select b.name from av_spr_uslugi b where b.del=0 and t.id_uslugi=b.id order by b.del asc, b.createdate desc limit 1) as name ');
  // ZQuery1.SQL.add(',(select b.sposob from av_spr_uslugi b where b.del=0 and t.id_uslugi=b.id order by b.del asc, b.createdate desc limit 1) as sposob ');
  // ZQuery1.SQL.add('FROM av_tarif_uslugi t WHERE t.del=0 and t.sum<>0 and t.id_tarif='+trim(tarif_id));
  // ZQuery1.SQL.add('order by t.id_point,t.id_uslugi; ');

  ZQuery1.SQL.add('(select 0 as point_id ,a.id  ');
  ZQuery1.SQL.add(' ,coalesce((select t.activ   ');
  ZQuery1.SQL.add('FROM av_tarif_uslugi t WHERE t.del=0 and t.id_tarif=18 and t.id_uslugi=a.id and 0=t.id_point order by createdate desc limit 1),0) activ  ');
  ZQuery1.SQL.add(', coalesce((select  t.sum  ');
  ZQuery1.SQL.add(' FROM av_tarif_uslugi t WHERE t.del=0 and t.id_tarif=18 and t.id_uslugi=a.id and 0=t.id_point order by createdate desc limit 1),0) sum  ');
  ZQuery1.SQL.add(', coalesce((select  t.proc  ');
  ZQuery1.SQL.add('FROM av_tarif_uslugi t WHERE t.del=0 and t.id_tarif=18 and t.id_uslugi=a.id and 0=t.id_point order by createdate desc limit 1),0) proc  ');
  ZQuery1.SQL.add(', (select t.createdate  ');
  ZQuery1.SQL.add('FROM av_tarif_uslugi t WHERE t.del=0 and t.id_tarif=18 and t.id_uslugi=a.id and 0=t.id_point order by createdate desc limit 1) createdate  ');
  ZQuery1.SQL.add(',btrim(a.name) as name, btrim(a.sposob) sposob  ');
  ZQuery1.SQL.add('FROM av_spr_uslugi a  where a.del=0  order by a.id  ');
  ZQuery1.SQL.add(')  ');
  ZQuery1.SQL.add('UNION ALL  ');
  ZQuery1.SQL.add('(  ');
  ZQuery1.SQL.add('select e.point_id,a.id  ');
  ZQuery1.SQL.add(' ,coalesce((select t.activ  ');
  ZQuery1.SQL.add('FROM av_tarif_uslugi t WHERE t.del=0 and t.id_tarif=18 and t.id_uslugi=a.id and e.point_id=t.id_point order by createdate desc limit 1),0) activ  ');
  ZQuery1.SQL.add(', coalesce((select  t.sum  ');
  ZQuery1.SQL.add(' FROM av_tarif_uslugi t WHERE t.del=0 and t.id_tarif=18 and t.id_uslugi=a.id and e.point_id=t.id_point order by createdate desc limit 1),0) sum  ');
  ZQuery1.SQL.add(', coalesce((select  t.proc  ');
  ZQuery1.SQL.add('FROM av_tarif_uslugi t WHERE t.del=0 and t.id_tarif=18 and t.id_uslugi=a.id and e.point_id=t.id_point order by createdate desc limit 1),0) proc  ');
  ZQuery1.SQL.add(', (select t.createdate  ');
  ZQuery1.SQL.add('FROM av_tarif_uslugi t WHERE t.del=0 and t.id_tarif=18 and t.id_uslugi=a.id and e.point_id=t.id_point order by createdate desc limit 1) createdate  ');
  ZQuery1.SQL.add(',btrim(a.name) as name, btrim(a.sposob) sposob  ');
  ZQuery1.SQL.add('FROM av_servers e, av_spr_uslugi a  ');
  ZQuery1.SQL.add('           where e.del=0 and e.usetarif=1 and a.del=0  ');
  //============ !!!!!!!!!!!!!!!!!!!!!! УБРАЛ НЕВОСТРЕБОВАННЫЕ УСЛУГИ ИЗ ВИДИМОСТИ !!!!!!!!!!!!!!!! ===================
  ZQuery1.SQL.add('  and a.id not in (11,18,20,21,22,23,24,25,30,31,38) ');
  //============ !!!!!!!!!!!!!!!!!!!!!! УБРАЛ НЕВОСТРЕБОВАННЫЕ УСЛУГИ ИЗ ВИДИМОСТИ !!!!!!!!!!!!!!!! ===================
  ZQuery1.SQL.add('order by real_virtual desc,point_id, a.id ');
  ZQuery1.SQL.add(')  ');

  //showmessage( ZQuery1.SQL.Text);//$
     try
    ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
    exit;
  end;
  if  ZQuery1.RecordCount<1 then
     begin
       showmessagealt('Нет данных для редактирования !');
        ZQuery1.close;
        Zconnection1.disconnect;
       exit;
     end;
  setlength(mas_uslugi,0,0);
  for n:=0 to  ZQuery1.RecordCount-1 do
     begin
      setlength(mas_uslugi,length(mas_uslugi)+1,uslugi_size);
      mas_uslugi[n,0]:= ZQuery1.FieldByName('point_id').asString;
      mas_uslugi[n,1]:= ZQuery1.FieldByName('activ').asString;
      mas_uslugi[n,2]:= ZQuery1.FieldByName('id').asString;
      mas_uslugi[n,3]:= ZQuery1.FieldByName('name').asString;
      mas_uslugi[n,4]:= ZQuery1.FieldByName('sposob').asString;
      mas_uslugi[n,5]:= ZQuery1.FieldByName('proc').asString;
     if pos('.',trim( ZQuery1.FieldByName('sum').asString))>0 then
         mas_uslugi[n,6]:=trim( ZQuery1.FieldByName('sum').asString)
     else
         mas_uslugi[n,6]:=trim( ZQuery1.FieldByName('sum').asString)+'.00';
      mas_uslugi[n,7]:='';//флаг изменений
      //showmessage(formatdatetime('dd-mm-yyyy hh:nn', ZQuery1.FieldByName('createdate').AsDateTime));
      mas_uslugi[n,8]:=formatdatetime('dd-mm-yyyy hh:nn', ZQuery1.FieldByName('createdate').AsDateTime);

       ZQuery1.Next;
     end;
     // uslugi();

      ZQuery1.Close;
      ZConnection1.Disconnect;
   end;
 end;



//======================================== Добавление новых услуг в список =====================================================
procedure TFormtarif_edit.Uslugi();
 var
   n,m,flag:integer;
begin
  // Выбираем список доступных услуг
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
  // Определяем значения
  formtarif_edit.ZQuery1.SQL.Clear;
  formtarif_edit.ZQuery1.SQL.add('Select * from av_spr_uslugi where del=0 order by id asc;');
     try
   formtarif_edit.ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+formtarif_edit.ZQuery1.SQL.Text);
    formtarif_edit.ZQuery1.Close;
    formtarif_edit.Zconnection1.disconnect;
    exit;
  end;

  if formtarif_edit.ZQuery1.RecordCount>0 then;
     begin
      formtarif_edit.StringGrid2.Columns[0].ValueChecked:='1';
      formtarif_edit.StringGrid2.Columns[0].ValueUnchecked:='0';
      for n:=0 to formtarif_edit.ZQuery1.RecordCount-1 do
         begin

            flag:=0;
            for m:=0 to formtarif_edit.StringGrid2.RowCount-1 do
               begin
                 if trim(formtarif_edit.StringGrid2.cells[1,m])=trim(formtarif_edit.ZQuery1.fieldbyname('id').asstring) then flag:=1;
               end;
           if flag=0 then
              begin
                //showmessage(formtarif_edit.ZQuery1.fieldbyname('id').asstring);//&
                formtarif_edit.StringGrid2.RowCount:=formtarif_edit.StringGrid2.RowCount+1;
                formtarif_edit.StringGrid2.cells[0,formtarif_edit.StringGrid2.RowCount-1]:='0';
                formtarif_edit.StringGrid2.cells[1,formtarif_edit.StringGrid2.RowCount-1]:=formtarif_edit.ZQuery1.fieldbyname('id').asstring;
                formtarif_edit.StringGrid2.cells[2,formtarif_edit.StringGrid2.RowCount-1]:=formtarif_edit.ZQuery1.fieldbyname('name').asstring;
                formtarif_edit.StringGrid2.cells[3,formtarif_edit.StringGrid2.RowCount-1]:=formtarif_edit.ZQuery1.fieldbyname('sposob').asstring;
                formtarif_edit.StringGrid2.cells[4,formtarif_edit.StringGrid2.RowCount-1]:='0';
                formtarif_edit.StringGrid2.cells[5,formtarif_edit.StringGrid2.RowCount-1]:='0.00';
             for m:=1 to formtarif_edit.StringGrid3.RowCount-1 do
                begin
                  setlength(mas_uslugi,length(mas_uslugi)+1,uslugi_size);
                  mas_uslugi[length(mas_uslugi)-1,0]:=formtarif_edit.StringGrid3.Cells[0,m];
                  mas_uslugi[length(mas_uslugi)-1,1]:='0';
                  mas_uslugi[length(mas_uslugi)-1,2]:=formtarif_edit.ZQuery1.FieldByName('id').asString;
                  mas_uslugi[length(mas_uslugi)-1,3]:=formtarif_edit.ZQuery1.FieldByName('name').asString;
                  mas_uslugi[length(mas_uslugi)-1,4]:=formtarif_edit.ZQuery1.FieldByName('sposob').asString;
                  mas_uslugi[length(mas_uslugi)-1,5]:='0';
                  mas_uslugi[length(mas_uslugi)-1,6]:='0.00';
                end;
              end;
                formtarif_edit.ZQuery1.Next;
         end;
        formtarif_edit.StringGrid2.Repaint;
     end;
     formtarif_edit.ZQuery1.close;
     formtarif_edit.ZConnection1.disconnect;
end;

//======================================== Список льгот =====================================================
procedure TFormtarif_edit.Lgoty();
 var
   n,m,flag:integer;
begin
  // Выбираем список доступных услуг
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;

  // Определяем строки Stringgrid5
  if length(mas_lgoty)>0 then
     begin
        formtarif_edit.StringGrid5.RowCount:=1;
        for n:=0 to length(mas_lgoty)-1 do
          begin
            formtarif_edit.StringGrid5.RowCount:=formtarif_edit.StringGrid5.RowCount+1;
            for m:=0 to 5 do
              begin
                formtarif_edit.StringGrid5.Cells[m,formtarif_edit.StringGrid5.RowCount-1]:=trim(mas_lgoty[n,m]);
              end;
          end;
     end;

  // Определяем значения полного списка массива lgot
  formtarif_edit.ZQuery1.SQL.Clear;
  formtarif_edit.ZQuery1.SQL.add('Select * from av_spr_lgot where del=0 order by id;');
     try
   formtarif_edit.ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+formtarif_edit.ZQuery1.SQL.Text);
    formtarif_edit.ZQuery1.Close;
    formtarif_edit.Zconnection1.disconnect;
    exit;
  end;

  if formtarif_edit.ZQuery1.RecordCount>0 then;
     begin
      formtarif_edit.StringGrid5.Columns[0].ValueChecked:='1';
      formtarif_edit.StringGrid5.Columns[0].ValueUnchecked:='0';
      for n:=0 to formtarif_edit.ZQuery1.RecordCount-1 do
         begin
            flag:=0;
            for m:=0 to formtarif_edit.StringGrid5.RowCount-1 do
               begin
                 if trim(formtarif_edit.StringGrid5.cells[1,m])=trim(formtarif_edit.ZQuery1.fieldbyname('id').asstring) then flag:=1;
               end;
           if flag=0 then
              begin
               formtarif_edit.StringGrid5.RowCount:=formtarif_edit.StringGrid5.RowCount+1;
               formtarif_edit.StringGrid5.cells[0,formtarif_edit.StringGrid5.RowCount-1]:='0';
               formtarif_edit.StringGrid5.cells[1,formtarif_edit.StringGrid5.RowCount-1]:=formtarif_edit.ZQuery1.fieldbyname('id').asString;
               formtarif_edit.StringGrid5.cells[2,formtarif_edit.StringGrid5.RowCount-1]:=formtarif_edit.ZQuery1.fieldbyname('name').asstring;
               formtarif_edit.StringGrid5.cells[3,formtarif_edit.StringGrid5.RowCount-1]:=formtarif_edit.ZQuery1.fieldbyname('zakon').asstring;
               formtarif_edit.StringGrid5.cells[4,n]:='0';
               formtarif_edit.StringGrid5.cells[5,n]:='0.00';
              end;
            formtarif_edit.ZQuery1.Next;
         end;
        formtarif_edit.StringGrid5.Repaint;
     end;
     formtarif_edit.ZQuery1.close;
     formtarif_edit.ZConnection1.disconnect;
end;



//===================================Добавляем список тарифов для локальных систем ================
procedure TFormtarif_edit.BitBtn1Click(Sender: TObject);
 var
   n,m,k,lenMas:integer;
   mas_temp:array of array of string;
begin
  // Если пустые нормы тарифа
  //formtarif_edit.StringGrid3.Row:=0;
  //if formtarif_edit.StringGrid1.RowCount=1 then
  //   begin
  //    showmessagealt('Введите параметры НОРМ ТАРИФА !');
  //    exit;
  //   end;


   // если нет записей локальных тарифов то заполняем массив норм тарифа текущий
   // ---------------- ПЕРВОНАЧАЛЬНАЯ ЗАПИСЬ - ТАРИФ --------------------------
   if formtarif_edit.StringGrid3.RowCount=1 then
     begin
      setlength(mas_tarif,0,0);
      for n:=1 to formtarif_edit.StringGrid1.RowCount-1 do
         begin
           setlength(mas_tarif,length(mas_tarif)+1,tarif_size);
           mas_tarif[n-1,0]:='0';
           for m:=0 to 5 do
              begin
               mas_tarif[n-1,m+1]:=formtarif_edit.StringGrid1.Cells[m,n];
              end;
         end;
   // ---------------- ПЕРВОНАЧАЛЬНАЯ ЗАПИСЬ - УСЛУГИ --------------------------
      setlength(mas_uslugi,0,0);
      for n:=1 to formtarif_edit.StringGrid2.RowCount-1 do
         begin
           setlength(mas_uslugi,length(mas_uslugi)+1,uslugi_size);
           mas_uslugi[n-1,0]:='0';
           for m:=0 to 5 do
              begin
               mas_uslugi[n-1,m+1]:=formtarif_edit.StringGrid2.Cells[m,n];
              end;
           mas_uslugi[length(mas_uslugi)-1,uslugi_size-2]:='2';//флаг изменений
           mas_uslugi[length(mas_uslugi)-1,uslugi_size-1]:=formatdatetime('dd-mm-yyyy hh:nn',now());
         end;

   // ---------------- ПЕРВОНАЧАЛЬНАЯ ЗАПИСЬ - БАГАЖ --------------------------
      setlength(mas_bagag,0,0);
      for n:=1 to formtarif_edit.StringGrid4.RowCount-1 do
         begin
           setlength(mas_bagag,length(mas_bagag)+1,bagag_size);
            mas_bagag[n-1,0]:='0';
           for m:=0 to 3 do
              begin
               mas_bagag[n-1,m+1]:=formtarif_edit.StringGrid4.Cells[m,n];
              end;
               mas_bagag[n-1,bagag_size-2]:='2';
               mas_bagag[n-1,bagag_size-1]:=formatdatetime('dd-mm-yyyy hh:nn',now());
         end;

   // ---------------- ПЕРВОНАЧАЛЬНАЯ ЗАПИСЬ - ПРЕДВАРИТЕЛЬНАЯ ПРОДАЖА --------------------------
      setlength(mas_predv,1,predv_size);
      mas_predv[0,0]:='0';
      mas_predv[0,1]:=inttostr(formtarif_edit.SpinEdit27.value);
      mas_predv[0,2]:=inttostr(formtarif_edit.SpinEdit29.value);
      mas_predv[0,3]:='TRUE';
      mas_predv[0,4]:='0';
      mas_predv[0,5]:='0';
      mas_predv[0,6]:='';
     end;

   //if formtarif_edit.StringGrid3.RowCount>2 then
   //  begin
   //   //if MessageDlg('Вы действительно хотите обновить'+#13+'список тарифных опций из норм тарифа'+#13+'для каждой локальной системы продажи ?',mtConfirmation,[mbYes,mbNO], 0)<>6 then exit;
   //   formtarif_edit.StringGrid3.row:=0;
   //   formtarif_edit.StringGrid3.rowcount:=1;
   //  end;
   //
   // -----------------------Проверяем на заполнение всех полей норм тарифа---------------------
  for n:=0 to length(mas_tarif)-1 do
     begin
       // Наименование опции
       if trim(mas_tarif[n,2])='' then
         begin
          showmessagealt('Для локальной ситемы № '+trim(mas_tarif[n,0])+' Норма тарифа № '+trim(mas_tarif[n,1])+': Пустое значение наименования!'+#13+'Исправьте ошибку и повторите сохранение !');
          exit;
         end;
       // Тип маршрута
       if not(trim(mas_tarif[n,3])='-любой-') and
          not(trim(mas_tarif[n,3])=cMezhgorod) and
          not(trim(mas_tarif[n,3])=cPrigorod) and
          not(trim(mas_tarif[n,3])='Межобластной\Межкраевой') and
          not(trim(mas_tarif[n,3])=cGos) then
         begin
          showmessagealt('Для локальной ситемы № '+trim(mas_tarif[n,0])+' Норма тарифа № '+trim(mas_tarif[n,1])+': Недопустимое значение ТИП МАРШРУТА !'+#13+'Исправьте ошибку и повторите сохранение !');
          exit;
         end;
       // Класс АТС
       if not(trim(mas_tarif[n,4])='-любой-') and
          not(trim(mas_tarif[n,4])='Мягкий') and
          not(trim(mas_tarif[n,4])='Жесткий') then
         begin
          showmessagealt('Для локальной ситемы № '+trim(mas_tarif[n,0])+' Норма тарифа № '+trim(mas_tarif[n,1])+': Недопустимое значение Класс АТС !'+#13+'Исправьте ошибку и повторите сохранение !');
          exit;
         end;
       // Тип АТС
       if not(trim(mas_tarif[n,5])='-любой-') and
          not(trim(mas_tarif[n,5])='М2') and
          not(trim(mas_tarif[n,5])='М3') then
         begin
          showmessagealt('Для локальной ситемы № '+trim(mas_tarif[n,0])+' Норма тарифа № '+trim(mas_tarif[n,1])+': Недопустимое значение Тип АТС !'+#13+'Исправьте ошибку и повторите сохранение !');
          exit;
         end;
     end;
  // -----------------------Проверяем на дубликаты значений значащих полей ---------------------
  for n:=0 to length(mas_tarif)-2 do
     begin
       for m:=n+1 to length(mas_tarif)-1 do
          begin
            if (trim(mas_tarif[n,3])=trim(mas_tarif[m,3])) and
               (trim(mas_tarif[n,4])=trim(mas_tarif[m,4])) and
               (trim(mas_tarif[n,5])=trim(mas_tarif[m,5])) and
               (trim(mas_tarif[n,0])=trim(mas_tarif[m,0])) then
                 begin
                   showmessagealt('В НОРМАХ ТАРИФА существуют записи с идентичными значениями полей: '+
                               #13+'          -Тип маршрута'+
                               #13+'          -Класс АТС'+
                               #13+'          -Тип АТС'+
                               #13+'Удалите дубликаты и повторите сохранение !');
                   exit;
                 end;
          end;
     end;


  //-------------------------------------------------------------------------------------------------
  //-----------------------ПИШЕМ ТАРИФЫ ИЗ НОРМ ДЛЯ ВЫБРАННОГО СЕРВЕРА-------------------------------
  //-------------------------------------------------------------------------------------------------
  //-------------------------------------------------------------------------------------------------
//
//   // Выбираем список доступных систем
//   // Подключаемся к серверу
//   If not(Connect2(Zconnection1, flagProfile)) then
//     begin
//      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
//      Close;
//      exit;
//     end;
//  //=========================== Определяем значения ========================================
//  formtarif_edit.ZQuery1.SQL.Clear;
//  formtarif_edit.ZQuery1.SQL.add('SELECT b.id,b.name FROM av_servers AS a, av_spr_point AS b WHERE a.del=0 AND b.del=0 AND a.point_id=b.id AND a.usetarif=1 ORDER BY b.name;');
//  try
//   formtarif_edit.ZQuery1.open;
//  except
//    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+formtarif_edit.ZQuery1.SQL.Text);
//    formtarif_edit.ZQuery1.Close;
//    formtarif_edit.Zconnection1.disconnect;
//    exit;
//  end;
//  if formtarif_edit.ZQuery1.RecordCount=0 then
//    begin
//      showmessagealt('НЕ ОБНАРУЖЕНО ЛОКАЛЬНЫХ СЕРВЕРОВ ПРОДАЖИ !');
//      formtarif_edit.ZQuery1.Close;
//      formtarif_edit.Zconnection1.Disconnect;
//      exit;
//    end;
//  for n:=1 to formtarif_edit.ZQuery1.RecordCount do
//    begin
//     formtarif_edit.StringGrid3.RowCount:=formtarif_edit.StringGrid3.RowCount+1;
//     formtarif_edit.StringGrid3.Cells[0,n]:=formtarif_edit.ZQuery1.FieldByName('id').asString;
//     formtarif_edit.StringGrid3.Cells[1,n]:=formtarif_edit.ZQuery1.FieldByName('name').asString;
//     formtarif_edit.ZQuery1.Next;
//    end;
//  formtarif_edit.ZQuery1.Close;
//  formtarif_edit.Zconnection1.Disconnect;

// Переопределяем массивы
//===============ТАРИФ=======================
//if formtarif_edit.StringGrid3.RowCount<2 then
// begin
//  showmessagealt('НЕ ОБНАРУЖЕНО ЛОКАЛЬНЫХ СЕРВЕРОВ ПРОДАЖИ !');
//  exit;
//  end;

  //setlength(mas_temp,0,0);
  ////чистим массив удаляем все кроме норм тарифа
  //for n:=0 to length(mas_tarif)-1 do
  // begin
  //  if not(trim(mas_tarif[n,0])='') then
  //    begin
  //      if not(strtoint(trim(mas_tarif[n,0]))=0) then mas_tarif[n,0]:='';
  //    end;
  //  if not(trim(mas_tarif[n,0])='') then
  //    begin
  //     setlength(mas_temp,length(mas_temp)+1,tarif_size);
  //       for m:=0 to 6 do
  //        begin
  //         mas_temp[length(mas_temp)-1,m]:=mas_tarif[n,m];
  //        end;
  //    end;
  // end;
  //  SetLength(mas_tarif,0,0);
  //  SetLength(mas_tarif,length(mas_temp),tarif_size);
  //  for n:=0 to length(mas_temp)-1 do
  //   begin
  //     for m:=0 to 6 do
  //      begin
  //       mas_tarif[n,m]:=mas_temp[n,m];
  //      end;
  //   end;
  //  setlength(mas_temp,0,0);
  //  //showmas(mas_tarif);

  // Добавляем новые значения для локальных систем
    lenMas:=length(mas_tarif)-1;
        for n:=0 to lenMas do
         begin
          if trim(mas_tarif[n,0])='0' then
           begin
             setlength(mas_tarif,length(mas_tarif)+1,tarif_size);
              for k:=0 to 6 do
                begin
                  mas_tarif[length(mas_tarif)-1,k]:=mas_tarif[n,k];
                end;
              mas_tarif[length(mas_tarif)-1,0]:=formtarif_edit.StringGrid3.Cells[0,formtarif_edit.StringGrid3.row];
           end;
         end;

   //===============УСЛУГИ=======================
  //   //чистим массив удаляем все кроме норм тарифа
  //setlength(mas_temp,0,0);
  //for n:=0 to length(mas_uslugi)-1 do
  // begin
  //  if not(trim(mas_uslugi[n,0])='') then
  //    begin
  //      if not(strtoint(trim(mas_uslugi[n,0]))=0) then mas_uslugi[n,0]:='';
  //    end;
  //    if not(trim(mas_uslugi[n,0])='') then
  //      begin
  //        setlength(mas_temp,length(mas_temp)+1,uslugi_size);
  //       for m:=0 to 6 do
  //        begin
  //         mas_temp[length(mas_temp)-1,m]:=mas_uslugi[n,m];
  //        end;
  //      end;
  //  end;
  //  SetLength(mas_uslugi,0,0);
  //  SetLength(mas_uslugi,length(mas_temp),uslugi_size);
  //  for n:=0 to length(mas_temp)-1 do
  //   begin
  //     for m:=0 to 6 do
  //      begin
  //       mas_uslugi[n,m]:=mas_temp[n,m];
  //      end;
  //   end;
  //  setlength(mas_temp,0,0);


  // Добавляем новые значения для локальных систем
    lenMas:=length(mas_uslugi)-1;
        for n:=0 to lenMas do
         begin
          if trim(mas_uslugi[n,0])='0' then
           begin

            setlength(mas_uslugi,length(mas_uslugi)+1,uslugi_size);
            for k:=1 to 5 do
             begin
              mas_uslugi[length(mas_uslugi)-1,k]:=mas_uslugi[n,k];
             end;
             mas_uslugi[length(mas_uslugi)-1,0]:=formtarif_edit.StringGrid3.Cells[0,formtarif_edit.StringGrid3.row];
          end;
         end;



    //=============== БАГАЖ =======================
   //   //чистим массив удаляем все кроме норм тарифа
   //setlength(mas_temp,0,0);
   //for n:=0 to length(mas_bagag)-1 do
   // begin
   //  if not(trim(mas_bagag[n,0])='') then
   //    begin
   //      if not(strtoint(trim(mas_bagag[n,0]))=0) then mas_bagag[n,0]:='';
   //    end;
   //    if not(trim(mas_bagag[n,0])='') then
   //      begin
   //        setlength(mas_temp,length(mas_temp)+1,bagag_size);
   //       for m:=0 to 4 do
   //        begin
   //         mas_temp[length(mas_temp)-1,m]:=mas_bagag[n,m];
   //        end;
   //      end;
   //  end;
   //  SetLength(mas_bagag,0,0);
   //  SetLength(mas_bagag,length(mas_temp),bagag_size);
   //  for n:=0 to length(mas_temp)-1 do
   //   begin
   //     for m:=0 to 4 do
   //      begin
   //       mas_bagag[n,m]:=mas_temp[n,m];
   //      end;
   //   end;
   //  setlength(mas_temp,0,0);

   //  // Добавляем новые значения для локальных систем
     lenMas:=length(mas_bagag)-1;
        for n:=0 to lenMas do
          begin
           if trim(mas_bagag[n,0])='0' then
             begin
              setlength(mas_bagag,length(mas_bagag)+1,bagag_size);
               for k:=1 to 4 do
                 begin
                   mas_bagag[length(mas_bagag)-1,k]:=mas_bagag[n,k];
                 end;
              mas_bagag[length(mas_bagag)-1,0]:=formtarif_edit.StringGrid3.Cells[0,formtarif_edit.StringGrid3.row];
              mas_bagag[length(mas_bagag)-1,5]:='2';
              mas_bagag[length(mas_bagag)-1,6]:=formatdatetime('dd-mm-yyyy hh:nn',now());
             end;
          end;

//=============== ДНЕЙ ПРЕДВАРИТЕЛЬНОЙ ПРОДАЖИ =======================
////чистим массив удаляем все кроме норм тарифа
//   setlength(mas_temp,0,0);
//   for n:=0 to length(mas_predv)-1 do
//    begin
//     if not(trim(mas_predv[n,0])='') then
//       begin
//         if not(strtoint(trim(mas_predv[n,0]))=0) then mas_predv[n,0]:='';
//       end;
//       if not(trim(mas_predv[n,0])='') then
//         begin
//           setlength(mas_temp,length(mas_temp)+1,predv_size);
//          for m:=0 to length(mas_predv[0])-1 do
//           begin
//            mas_temp[length(mas_temp)-1,m]:=mas_predv[n,m];
//           end;
//         end;
//     end;
//     SetLength(mas_predv,0,0);
//     SetLength(mas_predv,length(mas_temp),predv_size);
//     for n:=0 to length(mas_temp)-1 do
//      begin
//        for m:=0 to length(mas_predv[0])-1 do
//         begin
//          mas_predv[n,m]:=mas_temp[n,m];
//         end;
//      end;
//     setlength(mas_temp,0,0);

     // Добавляем новые значения для локальных систем
     lenMas:=length(mas_predv)-1;
     for n:=0 to lenMas do
     begin
       if trim(mas_predv[n,0])='0' then
           begin
            setlength(mas_predv,length(mas_predv)+1,predv_size);
            for k:=0 to length(mas_predv[0])-1 do
             begin
              mas_predv[length(mas_predv)-1,k]:=mas_predv[n,k];
             end;
             mas_predv[length(mas_predv)-1,0]:=formtarif_edit.StringGrid3.Cells[0,formtarif_edit.StringGrid3.row];
           end;
      end;
     //formtarif_edit.StringGrid3.RowCount:=1;
     //formtarif_edit.StringGrid3.Clear;
   formtarif_edit.update_grids;
end;


// Удаляем тарифную опцию
procedure TFormtarif_edit.BitBtn10Click(Sender: TObject);
 var
   n,m:integer;
   mas_temp:array of array of string;
begin
    if formtarif_edit.StringGrid1.Rowcount>1 then
      begin
       if MessageDlg('Выбранная для удаления ОПЦИЯ ТАРИФА будет удалена'+#13+'для каждого локального тарифа !'+#13+'Продолжить удаление ?',mtConfirmation,[mbYes,mbNO], 0)<>6 then exit;
        // Удаляем из mas_tarif выбранную опцию тарифа
        setlength(mas_temp,0,0);
          for n:=0 to length(mas_tarif)-1 do
            begin
              if not(trim(mas_tarif[n,0])='') then
                 begin
                   try
                  if strtoint(trim(mas_tarif[n,1]))=strtoint(trim(Formtarif_edit.StringGrid1.Cells[0,Formtarif_edit.StringGrid1.row])) then mas_tarif[n,0]:='';

            except
             on exception: EConvertError do
             begin
               showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!');
               continue;
             end;
             end;
                 end;
              if not(trim(mas_tarif[n,0])='') then
                 begin
                  setlength(mas_temp,length(mas_temp)+1,tarif_size);
                   for m:=0 to tarif_size-1 do
                    begin
                      mas_temp[length(mas_temp)-1,m]:=mas_tarif[n,m];
                    end;
                 end;
             end;
                 SetLength(mas_tarif,0,0);
                 SetLength(mas_tarif,length(mas_temp),tarif_size);
                 for n:=0 to length(mas_temp)-1 do
                  begin
                    for m:=0 to tarif_size-1 do
                     begin
                      mas_tarif[n,m]:=mas_temp[n,m];
                     end;
                  end;
            setlength(mas_temp,0,0);
        DelStringGrid(formtarif_edit.StringGrid1,formtarif_edit.StringGrid1.row);
      end;
end;

procedure TFormtarif_edit.BitBtn11Click(Sender: TObject);
begin
  result_id_uslugi:='';
  result_name_uslugi:='';
  //ОТКРЫВАЕМ УСЛУГИ
  formUslugi:=TformUslugi.create(self);
  formUslugi.ShowModal;
  FreeAndNil(formUslugi);
   if (result_id_uslugi = '') then exit;

    formTarif_edit.edit1.text := result_id_uslugi+' | '+ result_name_uslugi;
end;

//============== // Убираем все отметки льгот =========================
procedure TFormtarif_edit.BitBtn17Click(Sender: TObject);
var
  n:integer;
begin
   fledit_lgot:=true;
  // Убираем все отметки льгот
  if formtarif_edit.StringGrid5.RowCount>1 then
     begin
       for n:=1 to formtarif_edit.StringGrid5.RowCount-1 do
          begin
           formtarif_edit.StringGrid5.Cells[0,n]:='0';
          end;
      formtarif_edit.StringGrid5.Repaint;
     end;

end;

//================= Отмечаем все записи льгот ==============
 procedure TFormtarif_edit.BitBtn18Click(Sender: TObject);
var
  n:integer;
begin
   fledit_lgot:=true;
  // Отмечаем все записи льгот
  if formtarif_edit.StringGrid5.RowCount>1 then
     begin
       for n:=1 to formtarif_edit.StringGrid5.RowCount-1 do
          begin
           formtarif_edit.StringGrid5.Cells[0,n]:='1';
          end;
      formtarif_edit.StringGrid5.Repaint;
     end;
end;

// Добавляем записи в сетку багажа
procedure TFormtarif_edit.BitBtn7Click(Sender: TObject);
begin
   fledit_bag:=true;
  // Если первая строка сетки багажа
  if Formtarif_edit.StringGrid4.rowcount=1 then
    begin
     Formtarif_edit.StringGrid4.RowCount:=Formtarif_edit.StringGrid4.RowCount+1;
     Formtarif_edit.StringGrid4.Cells[0,Formtarif_edit.StringGrid4.RowCount-1]:='0';
     Formtarif_edit.StringGrid4.Cells[1,Formtarif_edit.StringGrid4.RowCount-1]:='0';
     Formtarif_edit.StringGrid4.Cells[2,Formtarif_edit.StringGrid4.RowCount-1]:='0.00';
     Formtarif_edit.StringGrid4.Cells[3,Formtarif_edit.StringGrid4.RowCount-1]:='0';
     exit;
    end;

  // Если добавляемая строка похожа на предыдущую
//  if inttostr(strtoint(Formtarif_edit.StringGrid4.Cells[0,Formtarif_edit.StringGrid4.RowCount-1])+1)=inttostr(strtoint(Formtarif_edit.StringGrid4.Cells[1,Formtarif_edit.StringGrid4.RowCount-1])+1) then exit;
  //if inttostr(strtoint(Formtarif_edit.StringGrid4.Cells[0,Formtarif_edit.StringGrid4.RowCount-1])+1)>=inttostr(strtoint(Formtarif_edit.StringGrid4.Cells[1,Formtarif_edit.StringGrid4.RowCount-1])+1) then exit;

  // Добавляем следующую строку
  if ((not(trim(Formtarif_edit.StringGrid4.Cells[1,Formtarif_edit.StringGrid4.RowCount-1])='')) and
     (not(trim(Formtarif_edit.StringGrid4.Cells[2,Formtarif_edit.StringGrid4.RowCount-1])=''))) or
     ((not(trim(Formtarif_edit.StringGrid4.Cells[1,Formtarif_edit.StringGrid4.RowCount-1])='')) and
     (not(trim(Formtarif_edit.StringGrid4.Cells[3,Formtarif_edit.StringGrid4.RowCount-1])=''))) then
       begin
         Formtarif_edit.StringGrid4.RowCount:=Formtarif_edit.StringGrid4.RowCount+1;
         try
         Formtarif_edit.StringGrid4.Cells[0,Formtarif_edit.StringGrid4.RowCount-1]:=inttostr(strtoint(Formtarif_edit.StringGrid4.Cells[1,Formtarif_edit.StringGrid4.RowCount-2])+1);
            except
             on exception: EConvertError do
             begin
               showmessagealt('ОШИБКА КОНВЕРТАЦИИ километража !!!');
             end;
             end;
         Formtarif_edit.StringGrid4.Cells[1,Formtarif_edit.StringGrid4.RowCount-1]:='0';
         Formtarif_edit.StringGrid4.Cells[2,Formtarif_edit.StringGrid4.RowCount-1]:='0.00';
         Formtarif_edit.StringGrid4.Cells[3,Formtarif_edit.StringGrid4.RowCount-1]:='0';
       end;
end;

procedure TFormtarif_edit.BitBtn9Click(Sender: TObject);
begin
    if (formtarif_edit.StringGrid1.RowCount>1) and
     (not(trim(formtarif_edit.StringGrid1.Cells[1,formtarif_edit.StringGrid1.Row])='')) and
     (not(trim(formtarif_edit.StringGrid1.Cells[2,formtarif_edit.StringGrid1.Row])='')) and
     (not(trim(formtarif_edit.StringGrid1.Cells[3,formtarif_edit.StringGrid1.Row])='')) and
     (not(trim(formtarif_edit.StringGrid1.Cells[4,formtarif_edit.StringGrid1.Row])='')) and
     (not(trim(formtarif_edit.StringGrid1.Cells[5,formtarif_edit.StringGrid1.Row])='')) then
     begin
      formtarif_edit.StringGrid1.RowCount:=formtarif_edit.StringGrid1.RowCount+1;
      formtarif_edit.StringGrid1.Cells[0,formtarif_edit.StringGrid1.RowCount-1]:=Inttostr(strtoint(formtarif_edit.StringGrid1.Cells[0,formtarif_edit.StringGrid1.RowCount-2])+1);
      formtarif_edit.StringGrid1.Cells[2,formtarif_edit.StringGrid1.RowCount-1]:=formtarif_edit.StringGrid1.Cells[2,formtarif_edit.StringGrid1.RowCount-2];
      formtarif_edit.StringGrid1.Cells[3,formtarif_edit.StringGrid1.RowCount-1]:=formtarif_edit.StringGrid1.Cells[3,formtarif_edit.StringGrid1.RowCount-2];
      formtarif_edit.StringGrid1.Cells[4,formtarif_edit.StringGrid1.RowCount-1]:=formtarif_edit.StringGrid1.Cells[4,formtarif_edit.StringGrid1.RowCount-2];
      formtarif_edit.StringGrid1.Cells[5,formtarif_edit.StringGrid1.RowCount-1]:=formtarif_edit.StringGrid1.Cells[5,formtarif_edit.StringGrid1.RowCount-2];
     end;
  if (formtarif_edit.StringGrid1.RowCount=1) then
     begin
       formtarif_edit.StringGrid1.RowCount:=formtarif_edit.StringGrid1.RowCount+1;
       formtarif_edit.StringGrid1.Cells[0,formtarif_edit.StringGrid1.RowCount-1]:='1';
       formtarif_edit.StringGrid1.Cells[2,formtarif_edit.StringGrid1.RowCount-1]:='-любой-';
       formtarif_edit.StringGrid1.Cells[3,formtarif_edit.StringGrid1.RowCount-1]:='-любой-';
       formtarif_edit.StringGrid1.Cells[4,formtarif_edit.StringGrid1.RowCount-1]:='-любой-';
       formtarif_edit.StringGrid1.Cells[5,formtarif_edit.StringGrid1.RowCount-1]:='0.00';
     end;
end;

procedure TFormtarif_edit.Button1Click(Sender: TObject);
 var
   n,m:integer;
   sss:string;
begin
    Formtarif_edit.uslugi();
                 exit;
  //showmessage(inttostr(length(mas_predv)));
  //showmas(mas_predv);
  sss:='';
  for n:=0 to high(mas_bagag) do
   begin
      If mas_bagag[n,0]=formtarif_edit.StringGrid3.Cells[0,formtarif_edit.StringGrid3.Row] then
         begin
      //formtarif_edit.StringGrid3.RowCount-1
   //length(mas_predv)-1 do
  //

     //sss:=sss+formtarif_edit.StringGrid4.Cells[1,n]+'<|>'+formtarif_edit.StringGrid4.Cells[2,n]+'<|>'+formtarif_edit.StringGrid4.Cells[3,n]+#13;//$
  //   //if trim(mas_predv[n,0])=trim(formtarif_edit.StringGrid3.cells[0,formtarif_edit.StringGrid3.Row]) then
  //   //   begin
         for m:=0 to bagag_size-1 do
           begin
            sss:=sss+mas_bagag[n,m]+'|';
           end;
           sss:=sss+#13;
  //      //end;
   end;
      end;
   showmessagealt(sss);
  //showmessage('rowcount:'+inttostr(formtarif.StringGrid1.RowCount)+#13+
  //'id_tarif: '+tarif_id+#13+'row: '+inttostr(formtarif.StringGrid1.row)+#13+'ind: '+inttostr(tek_tarif_ind));
  //showmessage(formtarif.Edit1.Text);
end;

procedure TFormtarif_edit.Button2Click(Sender: TObject);
begin
    showmas(mas_uslugi);
end;

procedure TFormtarif_edit.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  //очистка памяти от массива
  SetLength(mas_tarif,0,0);
  mas_tarif := nil;
  SetLength(mas_bagag,0,0);
  mas_bagag := nil;
  SetLength(mas_uslugi,0,0);
  mas_uslugi := nil;
  SetLength(mas_predv,0,0);
  mas_predv := nil;
  SetLength(mas_lgoty,0,0);
  mas_lgoty := nil;
end;


procedure TFormtarif_edit.FormShow(Sender: TObject);
var
   tmp_id_user,n,m,kol_strok:integer;
   tmp_bagag,tmp_uslugi,s:string;
begin
   DecimalSeparator:='.';
     if flag_access=1 then
     begin
      with formtarif_edit do
       begin
         BitBtn1.Enabled:=false;
         BitBtn5.Enabled:=false;
       end;
     end;

   tek_tarif_ind:=formtarif.StringGrid1.Row;
   tarif_id:=formtarif.StringGrid1.Cells[0,tek_tarif_ind];
   //showmessage(inttostr(tek_tarif_ind));
    //showmessage(inttostr(formtarif.StringGrid1.RowCount));
   //сбрасываем флаги изменений
   fledit_bag:=false;
   fledit_lgot:=false;
   fledit_uslug:=false;
   load_servers();


  //-----------------Режим новой записи-----------------------
  if flag_edit_tarif=1 then
   begin

     // Делаем доступным PageControl1
     formtarif_edit.PageControl1.Enabled:=true;
     // Если запись ТАРИФА не первая, то предлагать перенести данные с предыдущей
     if formtarif.StringGrid1.RowCount>1 then
        begin
         if MessageDlg('Вы хотите перенести значения предыдущего тарифа в новый ?',mtConfirmation,[mbYes,mbNO], 0)<>6 then //exit;
            begin
               formtarif_edit.load_mas(0);
                 // обновляем список услуг
                 formtarif_edit.Uslugi();
                 // обновляем список льгот
                 formtarif_edit.Lgoty();
               //formtarif_edit.Load_mas_new();
               exit;
          end;
         // Находим максимальный ID тарифа
            // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
       // Определяем значения
       formtarif_edit.ZQuery1.SQL.Clear;
       formtarif_edit.ZQuery1.SQL.add('Select max(id) as id from av_tarif where del=0;');
  try
         formtarif_edit.ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+formtarif_edit.ZQuery1.SQL.Text);
    formtarif_edit.ZQuery1.Close;
    formtarif_edit.Zconnection1.disconnect;
    exit;
  end;
               if formtarif_edit.ZQuery1.RecordCount=0 then
                  begin
                    showmessagealt('Данные предыдущего тарифа недоступны для загрузки !'+#13+'Будут использованы значения по умолчанию !');
                  end
               else
                  begin
                    // Ищем предыдущую запись тарифа в StringGrid
                    for n:=1 to formtarif.StringGrid1.RowCount-1 do
                     begin
                       if trim(formtarif.StringGrid1.cells[0,n])=trim(formtarif_edit.ZQuery1.FieldByName('id').asString)
                          then tek_tarif_ind:=n;
                     end;
                    // Загружаем и обновляем тарифы
                    formtarif_edit.Load_mas(1);
                    formtarif_edit.StringGrid3.Row:=0;
                    formtarif_edit.update_grids();
                  end;
               formtarif_edit.ZQuery1.close;
               formtarif_edit.ZConnection1.Disconnect;
        end
      else
        begin
          //запиливаем другие сервера
          formtarif_edit.load_mas(0);
        end;

          // обновляем список услуг
          formtarif_edit.Uslugi();
          // обновляем список льгот
          formtarif_edit.Lgoty();

      // назначаем текущую дату + 1
     formtarif_edit.DateEdit1.Date:=date+1;
   end;

  // Режим редактирования
  if flag_edit_tarif=2 then
   begin
    formtarif_edit.DateEdit1.Enabled:=false;
    formtarif_edit.PageControl1.Enabled:=true;
    formtarif_edit.Load_mas(1);
    formtarif_edit.StringGrid3.Row:=0;
    formtarif_edit.update_grids();
    // обновляем список услуг
     formtarif_edit.Uslugi();
    // обновляем список льгот
     formtarif_edit.Lgoty();

  {      s:='';
    for n:=0 to length(mas_tarif)-1 do
     begin
       for m:=0 to 6 do
        begin
          s:=s+'|'+mas_tarif[n,m];
        end;
       s:=s+#13;
     end;
     showmessagealt(s);}


{   s:='';
    for n:=0 to length(mas_lgoty)-1 do
     begin
       for m:=0 to 5 do
        begin
          s:=s+'|'+mas_lgoty[n,m];
        end;
       s:=s+#13;
     end;
     showmessagealt(s);}
   end;
  //сбрасываем флаги изменений
   fledit_bag:=false;
   fledit_lgot:=false;
   fledit_uslug:=false;

end;


// ===================== Меню полей для тарифных опций =============================================================
procedure TFormtarif_edit.MenuItem10Click(Sender: TObject);
begin
  formtarif_edit.StringGrid1.Cells[3,formtarif_edit.StringGrid1.row]:=Formtarif_edit.PopupMenu2.Items.Items[0].Caption;
end;

procedure TFormtarif_edit.MenuItem11Click(Sender: TObject);
begin
formtarif_edit.StringGrid1.Cells[4,formtarif_edit.StringGrid1.row]:=Formtarif_edit.PopupMenu3.Items.Items[0].Caption;
end;

procedure TFormtarif_edit.MenuItem1Click(Sender: TObject);
begin
  formtarif_edit.StringGrid1.Cells[2,formtarif_edit.StringGrid1.row]:=Formtarif_edit.PopupMenu1.Items.Items[1].Caption;
end;

procedure TFormtarif_edit.MenuItem2Click(Sender: TObject);
begin
    formtarif_edit.StringGrid1.Cells[2,formtarif_edit.StringGrid1.row]:=Formtarif_edit.PopupMenu1.Items.Items[2].Caption;
end;

procedure TFormtarif_edit.MenuItem3Click(Sender: TObject);
begin
    formtarif_edit.StringGrid1.Cells[2,formtarif_edit.StringGrid1.row]:=Formtarif_edit.PopupMenu1.Items.Items[3].Caption;
end;

procedure TFormtarif_edit.MenuItem4Click(Sender: TObject);
begin
    formtarif_edit.StringGrid1.Cells[2,formtarif_edit.StringGrid1.row]:=Formtarif_edit.PopupMenu1.Items.Items[4].Caption;
end;

procedure TFormtarif_edit.MenuItem5Click(Sender: TObject);
begin
   formtarif_edit.StringGrid1.Cells[3,formtarif_edit.StringGrid1.row]:=Formtarif_edit.PopupMenu2.Items.Items[1].Caption;
end;

procedure TFormtarif_edit.MenuItem6Click(Sender: TObject);
begin
     formtarif_edit.StringGrid1.Cells[3,formtarif_edit.StringGrid1.row]:=Formtarif_edit.PopupMenu2.Items.Items[2].Caption;
end;

procedure TFormtarif_edit.MenuItem7Click(Sender: TObject);
begin
     formtarif_edit.StringGrid1.Cells[4,formtarif_edit.StringGrid1.row]:=Formtarif_edit.PopupMenu3.Items.Items[1].Caption;
end;

procedure TFormtarif_edit.MenuItem8Click(Sender: TObject);
begin
   formtarif_edit.StringGrid1.Cells[4,formtarif_edit.StringGrid1.row]:=Formtarif_edit.PopupMenu3.Items.Items[2].Caption;
end;

procedure TFormtarif_edit.MenuItem9Click(Sender: TObject);
begin
    formtarif_edit.StringGrid1.Cells[2,formtarif_edit.StringGrid1.row]:=Formtarif_edit.PopupMenu1.Items.Items[0].Caption;
end;

procedure TFormtarif_edit.StringGrid1EditButtonClick(Sender: TObject);
begin

  if formtarif_edit.StringGrid1.Col=2 then formtarif_edit.PopupMenu1.PopUp;
  if formtarif_edit.StringGrid1.Col=3 then formtarif_edit.PopupMenu2.PopUp;
  if formtarif_edit.StringGrid1.Col=4 then formtarif_edit.PopupMenu3.PopUp;
end;
// ==================================== Конец блока всплывающих МЕНЮ =====================================================

// Процедура проверки формата поля тарифа
procedure TFormtarif_edit.StringGrid1EditingDone(Sender: TObject);
begin
  if Formtarif_edit.StringGrid1.col=5 then
    begin
      Formtarif_edit.StringGrid1.Cells[5,Formtarif_edit.StringGrid1.row]:=FormatNum(Formtarif_edit.StringGrid1.Cells[5,Formtarif_edit.StringGrid1.row],2);
    end;
end;

procedure TFormtarif_edit.StringGrid2CheckboxToggled(sender: TObject; aCol,
  aRow: Integer; aState: TCheckboxState);
begin
   fledit_uslug:=true;
end;

procedure TFormtarif_edit.StringGrid2EditingDone(Sender: TObject);
begin
  //fledit_uslug:=true;
     //DecimalSeparator:='.';
   // %
   if Formtarif_edit.StringGrid2.col=4 then
     begin
      Formtarif_edit.StringGrid2.Cells[4,Formtarif_edit.StringGrid2.row]:=FormatNum(Formtarif_edit.StringGrid2.Cells[4,Formtarif_edit.StringGrid2.row],0);
     end;
   // Рубли
   if Formtarif_edit.StringGrid2.col=5 then
     begin
      Formtarif_edit.StringGrid2.Cells[5,Formtarif_edit.StringGrid2.row]:=FormatNum(Formtarif_edit.StringGrid2.Cells[5,Formtarif_edit.StringGrid2.row],2);
     end;

   // Проверяем и оставляем только руб. или %
   //Если стоят проценты, убираем стоимость
   if  (Formtarif_edit.StringGrid2.Col=4) and
       not(trim(Formtarif_edit.StringGrid2.Cells[4,Formtarif_edit.StringGrid2.row])='') and
       not(trim(Formtarif_edit.StringGrid2.Cells[4,Formtarif_edit.StringGrid2.row])='0') then
    begin
         Formtarif_edit.StringGrid2.Cells[5,Formtarif_edit.StringGrid2.row]:='0.00';
    end;

   //Если стоит стоимость, убираем проценты
   if  (Formtarif_edit.StringGrid2.Col=5) and
       not(trim(Formtarif_edit.StringGrid2.Cells[5,Formtarif_edit.StringGrid2.row])='') and
       not(trim(Formtarif_edit.StringGrid2.Cells[5,Formtarif_edit.StringGrid2.row])='0.00') then
    begin
         Formtarif_edit.StringGrid2.Cells[4,Formtarif_edit.StringGrid2.row]:='0';
    end;

end;

procedure TFormtarif_edit.StringGrid2KeyPress(Sender: TObject; var Key: char);
begin
  fledit_uslug:=true;
end;

//procedure TFormtarif_edit.StringGrid2GetEditMask(Sender: TObject; ACol,
  //ARow: Integer; var Value: string);
//begin
   // маска вводимых занчений
  //if ACol=4 then Value := '!999;1;  ');
  //if ACol=5 then Value := '!9999999.99;1;  ');
//end;

// Перераспределение массивов данных сеток
procedure TFormtarif_edit.StringGrid3BeforeSelection(Sender: TObject; aCol,  aRow: Integer);
begin
   If formTarif_edit.StringGrid3.RowCount<2 then exit;
   If trim(formTarif_edit.StringGrid3.Cells[0,formTarif_edit.StringGrid3.Row])='' then exit;
   update_mas(formTarif_edit.StringGrid3.Row);
end;


//====== Перерисовываем сетки в соответствии с условиями выбора категории тарифов и определяем правила доступа к элементам ========
procedure TFormtarif_edit.StringGrid3Selection(Sender: TObject; aCol,aRow: Integer);
 var
   n,m:integer;
begin
  // =======================Обновляем сетки=========================
   If formTarif_edit.StringGrid3.RowCount<2 then exit;
   If trim(formTarif_edit.StringGrid3.Cells[0,formTarif_edit.StringGrid3.Row])='' then exit;

  update_grids();

  // Проверяем если пустые нормы тарифа для выбранного сервера то включаем доступ к кнопке расчета норм для текущего сервера
  if formtarif_edit.StringGrid1.RowCount=1 then formtarif_edit.BitBtn1.Visible:=true else formtarif_edit.BitBtn1.Visible:=false;
end;

procedure TFormtarif_edit.StringGrid4EditingDone(Sender: TObject);
begin
   fledit_bag:=true;
   //DecimalSeparator:='.';
   with Formtarif_edit.StringGrid4 do
    begin
   // До
   if  col=1 then
     begin
       Cells[1, row]:=FormatNum( Cells[1, row],0);
     end;
   // Рубли
   if  col=2 then
     begin
       Cells[2, row]:=FormatNum( Cells[2, row],2);
     end;
   // %
   if  col=3 then
     begin
       Cells[3, row]:=FormatNum( Cells[3, row],0);
     end;

   // Проверяем введенный километраж
   if not(trim( Cells[1, row])='')
      and not( row=1) and ( Col=1) then
    begin
       try

      if strtoint(trim( Cells[1, row]))<=strtoint(trim( Cells[0, row])) then
       begin
         showmessagealt('Недопустимое занчение !!!'+#13+'Параметр [ДО(км)] меньше/равен параметру [ОТ(км)]');
          Cells[1, row]:=inttostr(strtoint(trim( Cells[0, row]))+1);
        end;
        except
         on exception: EConvertError do
           begin
            showmessage('ОШИБКА КОНВЕРТАЦИИ!!!'+#13+'Неверное значение километража');
           end;
       end;
    end;


    // Проверяем и оставляем только руб. или %
   if  ( Col=2) and
       not(trim( Cells[2, row])='') and
       not(trim( Cells[2, row])='0.00') then
    begin
          Cells[3, row]:='0';
    end;
   if  ( Col=3) and
       not(trim( Cells[3, row])='') and
       not(trim( Cells[3, row])='0') then
    begin
          Cells[2,row]:='0.00';
    end;
   end;
end;

procedure TFormtarif_edit.StringGrid4KeyPress(Sender: TObject; var Key: char);
begin
  fledit_bag:=true;
end;

// =========== Отмечаем все записи услуг=============
procedure TFormtarif_edit.BitBtn15Click(Sender: TObject);
var
  n:integer;
begin
   fledit_uslug:=true;
  // Отмечаем все записи
  if formtarif_edit.StringGrid2.RowCount>1 then
     begin
       for n:=1 to formtarif_edit.StringGrid2.RowCount-1 do
          begin
           formtarif_edit.StringGrid2.Cells[0,n]:='1';
          end;
      formtarif_edit.StringGrid2.Repaint;
     end;
end;

// =========== Убираем все отметки записей услуг=============
procedure TFormtarif_edit.BitBtn16Click(Sender: TObject);
var
  n:integer;
begin
  // Убираем все отметки
  fledit_uslug:=true;
  if formtarif_edit.StringGrid2.RowCount>1 then
     begin
       for n:=1 to formtarif_edit.StringGrid2.RowCount-1 do
          begin
           formtarif_edit.StringGrid2.Cells[0,n]:='0';
          end;
      formtarif_edit.StringGrid2.Repaint;
     end;
end;

//============= Выход из формы редактирования ================
procedure TFormtarif_edit.BitBtn4Click(Sender: TObject);
begin
   formtarif_edit.close;
end;


//================== Сохранение ВСЕХ изменений ====================
procedure TFormtarif_edit.BitBtn5Click(Sender: TObject);
var
  n,m,new_id:integer;
  str_query,flag_predv:string;
begin
  // Сохраняем результаты
  // провряем что данные удовлетворяют все условиям
  //--------------------------------- есть значения или нет----------------------
  if (length(mas_tarif)<1) and (formtarif_edit.StringGrid1.RowCount<2)  then
    begin
      showmessagealt('Не определены значения НОРМ ТАРИФА !!!'+#13+'Сохранение данных невозможно !');
      exit;
    end;
  if (length(mas_bagag)<1) and (formtarif_edit.StringGrid1.Row<2)  then
    begin
      showmessagealt('Не определены значения НОРМ БАГАЖА !!!'+#13+'Сохранение данных невозможно !');
      exit;
    end;
  if formtarif_edit.StringGrid3.RowCount=1  then
    begin
      showmessagealt('Не определены значения НОРМ ТАРИФА для локальных систем !!!'+#13+'Сохранение данных невозможно !');
      exit;
    end;
  If formtarif_edit.SpinEdit29.Value=0 then showmessagealt('Не определено время снятия брони !');
  //formtarif_edit.StringGrid3.Row:=1;
  formtarif_edit.StringGrid3.Row:=0;
  // -----------------------Проверяем на заполнение всех полей норм тарифа---------------------
  for n:=0 to length(mas_tarif)-1 do
     begin
       // Наименование опции
       if trim(mas_tarif[n,2])='' then
         begin
          showmessagealt('Для локальной ситемы № '+trim(mas_tarif[n,0])+' Норма тарифа № '+trim(mas_tarif[n,1])+': Пустое значение наименования!'+#13+'Исправьте ошибку и повторите сохранение !');
          exit;
         end;
       // Тип маршрута
       if not(trim(mas_tarif[n,3])='-любой-') and
          not(trim(mas_tarif[n,3])=cMezhgorod) and
          not(trim(mas_tarif[n,3])=cPrigorod) and
          not(trim(mas_tarif[n,3])='Межобластной\Межкраевой') and
          not(trim(mas_tarif[n,3])=cGos) then
         begin
          showmessagealt('Для локальной ситемы № '+trim(mas_tarif[n,0])+' Норма тарифа № '+trim(mas_tarif[n,1])+': Недопустимое значение ТИП МАРШРУТА !'+#13+'Исправьте ошибку и повторите сохранение !');
          exit;
         end;
       // Класс АТС
       if not(trim(mas_tarif[n,4])='-любой-') and
          not(trim(mas_tarif[n,4])='Мягкий') and
          not(trim(mas_tarif[n,4])='Жесткий') then
         begin
          showmessagealt('Для локальной ситемы № '+trim(mas_tarif[n,0])+' Норма тарифа № '+trim(mas_tarif[n,1])+': Недопустимое значение Класс АТС !'+#13+'Исправьте ошибку и повторите сохранение !');
          exit;
         end;
       // Тип АТС
       if not(trim(mas_tarif[n,5])='-любой-') and
          not(trim(mas_tarif[n,5])='М2') and
          not(trim(mas_tarif[n,5])='М3') then
         begin
          showmessagealt('Для локальной ситемы № '+trim(mas_tarif[n,0])+' Норма тарифа № '+trim(mas_tarif[n,1])+': Недопустимое значение Тип АТС !'+#13+'Исправьте ошибку и повторите сохранение !');
          exit;
         end;
     end;
  // -----------------------Проверяем на дубликаты значений значащих полей ---------------------
  for n:=0 to length(mas_tarif)-2 do
     begin
       for m:=n+1 to length(mas_tarif)-1 do
          begin
            if (trim(mas_tarif[n,3])=trim(mas_tarif[m,3])) and
               (trim(mas_tarif[n,4])=trim(mas_tarif[m,4])) and
               (trim(mas_tarif[n,5])=trim(mas_tarif[m,5])) and
               (trim(mas_tarif[n,0])=trim(mas_tarif[m,0])) then
                 begin
                   showmessagealt('В НОРМАХ ТАРИФА существуют записи с идентичными значениями полей: '+
                               #13+'          -Тип маршрута'+
                               #13+'          -Класс АТС'+
                               #13+'          -Тип АТС'+
                               #13+'для сервера с id='+mas_tarif[n,0]+' наименование: '+mas_tarif[n,2]+
                               #13+'Удалите дубликаты и повторите сохранение !');
                   exit;
                 end;
          end;
     end;

     update_mas(formTarif_edit.Stringgrid3.Row);


         // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;


   //Если есть уже записи тарифа
   // ---------------------------Проверяем правильность введенной даты тарифа-----------------------
   if flag_edit_tarif=1 then
      begin
        // Дата > текущей
        if strtodate(formtarif_edit.DateEdit1.text)=Date then
           begin
                formtarif_edit.Zconnection1.disconnect;
                formtarif_edit.ZQuery1.Close;
             showmessagealt('ДАТА НАЧАЛА ДЕЙСТВИЯ тарифа должна быть больше текущей даты !');
             exit;
           end;

        // Дата > максимальной
            formtarif_edit.ZQuery1.SQL.clear;
            formtarif_edit.ZQuery1.SQL.add('select max(datetarif) as maxtarif from av_tarif where del=0;');
              try
   formtarif_edit.ZQuery1.open;
  except
    showmessage('ОШИБКА запроса к базе данных !'+#13+'Команда: '+formtarif_edit.ZQuery1.SQL.Text);
    formtarif_edit.Zconnection1.disconnect;
    formtarif_edit.ZQuery1.Close;
    exit;
  end;
  if (formtarif.StringGrid1.RowCount>1) then
    begin
            if (formtarif.StringGrid1.RowCount>1) and (strtodate(formtarif_edit.DateEdit1.text)<=strtodate(formtarif_edit.ZQuery1.FieldByName('maxtarif').asString)) then
              begin
                showmessagealt('Выбранная дата '+trim(formtarif_edit.DateEdit1.text)+' меньше, либо равна '+#13+
                            'предыдущей даты действия тарифа от '+trim(formtarif_edit.ZQuery1.FieldByName('maxtarif').asString)+#13+
                            'Для продолжения выберите другую дату начала действия тарифа большую чем '+trim(formtarif_edit.ZQuery1.FieldByName('maxtarif').asString));
                formtarif_edit.DateEdit1.text:=datetostr(strtodate(formtarif_edit.ZQuery1.FieldByName('maxtarif').asString)+1);
                formtarif_edit.ZQuery1.Close;
                formtarif_edit.Zconnection1.disconnect;
                exit;
              end;
    end;
  end;

  //Сохраняем данные
 // Подключаемся к серверу
   //If not(Connect2(Zconnection1, flagProfile)) then
     //begin
      //showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      //Close;
      //exit;
     //end;

  //Открываем транзакцию
  try
   If not Zconnection1.InTransaction then
      Zconnection1.StartTransaction
   else
     begin
      showmessagealt('Ошибка ! Незавершенная транзакция !'+#13+'Попробуйте снова !');
      ZConnection1.Rollback;
      formtarif_edit.Zconnection1.disconnect;
      formtarif_edit.ZQuery1.Close;
      exit;
     end;
  //Определяем текущий id+1
       if flag_edit_tarif=1 then
          begin
           formtarif_edit.ZQuery1.SQL.Clear;
           formtarif_edit.ZQuery1.SQL.add('SELECT MAX(id) as new_id FROM av_tarif;');
           formtarif_edit.ZQuery1.open;
           if formtarif_edit.ZQuery1.FieldByName('new_id').asString='' then new_id:=1;
           if formtarif_edit.ZQuery1.FieldByName('new_id').asString<>'' then new_id:=formtarif_edit.ZQuery1.FieldByName('new_id').asInteger+1;
          end;
       //showmessage(inttostr(new_id));
       if flag_edit_tarif=2 then
         begin
           //showmessage(#13+inttostr(formtarif.StringGrid1.row)+#13+inttostr(tek_tarif_ind));
           try
             new_id:=strtoint(tarif_id);
           except
             on exception: EConvertError do
             begin
                formtarif_edit.ZConnection1.Rollback;
                formtarif_edit.ZQuery1.Close;
                formtarif_edit.Zconnection1.disconnect;
                showmessagealt('Ошибка конвертации !!!'+#13+'Данные не записаны !');
               exit;
             end;
             end;
         end;

  //Производим запись новых данных

  //========================= Пишем основная запись тарифа+опции возвратов+максимальная скорость+%детского билета================
  //Маркируем запись на удаление если режим редактирования
  //if flag_edit_tarif=2 then
  //    begin
  //     formtarif_edit.ZQuery1.SQL.Clear;
  //     formtarif_edit.ZQuery1.SQL.add('UPDATE av_tarif SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id='+trim(tarif_id)+' and del=0;');
  //     formtarif_edit.ZQuery1.open;
  //    end;
  //// ПИШЕМ НОВЫЕ ДАННЫЕ
  //formtarif_edit.ZQuery1.SQL.Clear;
  //formtarif_edit.ZQuery1.SQL.add('INSERT INTO av_tarif(id,id_user,datetarif,wozbild,wozbildproc,wozbilw,wozbilwproc,wozbilp,wozbilpproc,wozbagd,wozbagdproc,');
  //formtarif_edit.ZQuery1.SQL.add('wozbagw,wozbagwproc,wozbagp,wozbagpproc,kmh,deti,dateraschet,prigorod_rajon,centless');
  //if flag_edit_tarif=1 then formtarif_edit.ZQuery1.SQL.add(',createdate_first,id_user_first');
  //formtarif_edit.ZQuery1.SQL.add(') VALUES (');
  //formtarif_edit.ZQuery1.SQL.add(inttostr(new_id)+','+
  //                               inttostr(id_user)+','+
  //                               quotedstr(datetostr(formtarif_edit.DateEdit1.Date))+','+
  //                               inttostr(formtarif_edit.SpinEdit14.value)+','+
  //                               inttostr(formtarif_edit.SpinEdit15.value)+','+
  //                               inttostr(formtarif_edit.SpinEdit16.value)+','+
  //                               inttostr(formtarif_edit.SpinEdit17.value)+','+
  //                               inttostr(formtarif_edit.SpinEdit18.value)+','+
  //                               inttostr(formtarif_edit.SpinEdit19.value)+','+
  //                               inttostr(formtarif_edit.SpinEdit20.value)+','+
  //                               inttostr(formtarif_edit.SpinEdit21.value)+','+
  //                               inttostr(formtarif_edit.SpinEdit22.value)+','+
  //                               inttostr(formtarif_edit.SpinEdit23.value)+','+
  //                               inttostr(formtarif_edit.SpinEdit24.value)+','+
  //                               inttostr(formtarif_edit.SpinEdit25.value)+','+
  //                               inttostr(formtarif_edit.SpinEdit26.value)+','+
  //                               inttostr(formtarif_edit.SpinEdit28.value)+','+
  //                               'NULL'+','+'DEFAULT,'+
  //                               //IFTHEN(formtarif_edit.CheckBox1.Checked=true,'TRUE','FALSE'));
  //                               IFTHEN(formtarif_edit.CheckBox2.Checked=true,'1','0'));
  //
  //
  //if flag_edit_tarif=1 then formtarif_edit.ZQuery1.SQL.add(',now(),'+inttostr(id_user));
  //formtarif_edit.ZQuery1.SQL.add(');');
  ////showmessage('Команда: '+formtarif_edit.ZQuery1.SQL.Text);
  ////showmessage(formtarif_edit.ZQuery1.SQL.text);
  //
  //formtarif_edit.ZQuery1.Open;
  //
   //=================== Пишем тарифные опции для всех локальных систем=======================
   ////Маркируем запись на удаление если режим редактирования
   //if flag_edit_tarif=2 then
   //    begin
   //     formtarif_edit.ZQuery1.SQL.Clear;
   //     formtarif_edit.ZQuery1.SQL.add('UPDATE av_tarif_local SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_tarif='+trim(tarif_id)+' and id_n<>3 and del=0;');
   //      //showmessage('Команда: '+formtarif_edit.ZQuery1.SQL.Text);//$
   //     formtarif_edit.ZQuery1.open;
   //    end;
   //
   //// ПИШЕМ НОВЫЕ ДАННЫЕ
   //
   ////------------------------- НОРМЫ ТАРИФА -------------------------------
   //for n:=0 to length(mas_tarif)-1 do
   //   begin
   //     If mas_tarif[n,0]<>'0' then continue;//$
   //
   //     formtarif_edit.ZQuery1.SQL.Clear;
   //     formtarif_edit.ZQuery1.SQL.add('INSERT INTO av_tarif_local(id_tarif, createdate, id_user, del, id_point, id_n, name, typpath, klassats, typats, sum');
   //     if flag_edit_tarif=1 then formtarif_edit.ZQuery1.SQL.add(',createdate_first,id_user_first');
   //     formtarif_edit.ZQuery1.SQL.add(') VALUES (');
   //     formtarif_edit.ZQuery1.SQL.add(inttostr(new_id)+',now(),'+inttostr(id_user)+',0,'+trim(mas_tarif[n,0])+',');
   //     formtarif_edit.ZQuery1.SQL.add(trim(mas_tarif[n,1])+','+Quotedstr(trim(mas_tarif[n,2]))+',');
   //     // Тип маршрута
   //     if trim(mas_tarif[n,3])='-любой-' then formtarif_edit.ZQuery1.SQL.add('0,');
   //     if trim(mas_tarif[n,3])=cMezhgorod then formtarif_edit.ZQuery1.SQL.add('1,');
   //     if trim(mas_tarif[n,3])=cPrigorod then formtarif_edit.ZQuery1.SQL.add('2,');
   //     if trim(mas_tarif[n,3])='Межобластной\Межкраевой' then formtarif_edit.ZQuery1.SQL.add('3,');
   //     if trim(mas_tarif[n,3])=cGos then formtarif_edit.ZQuery1.SQL.add('4,');
   //     // Класс АТС
   //     if trim(mas_tarif[n,4])='-любой-' then formtarif_edit.ZQuery1.SQL.add('0,');
   //     if trim(mas_tarif[n,4])='Мягкий' then formtarif_edit.ZQuery1.SQL.add('1,');
   //     if trim(mas_tarif[n,4])='Жесткий' then formtarif_edit.ZQuery1.SQL.add('2,');
   //     // Тип АТС
   //     if trim(mas_tarif[n,5])='-любой-' then formtarif_edit.ZQuery1.SQL.add('0,');
   //     if trim(mas_tarif[n,5])='М2' then formtarif_edit.ZQuery1.SQL.add('1,');
   //     if trim(mas_tarif[n,5])='М3' then formtarif_edit.ZQuery1.SQL.add('2,');
   //     // Сумма
   //     formtarif_edit.ZQuery1.SQL.add(trim(mas_tarif[n,6]));
   //     // Закрываем запрос
   //     if flag_edit_tarif=1 then formtarif_edit.ZQuery1.SQL.add(',now(),'+inttostr(id_user));
   //     formtarif_edit.ZQuery1.SQL.add(');');
   //     //showmessage('Команда: '+formtarif_edit.ZQuery1.SQL.Text);//$
   //     formtarif_edit.ZQuery1.Open;
   //   end;
   //
   //------------------------- НОРМЫ БАГАЖА -------------------------------

   for n:=0 to length(mas_bagag)-1 do
      begin
         //if flag_edit_tarif=2 then
       //begin
        //если отредактированный или удаленный
         If (mas_bagag[n,bagag_size-2]='1') or (mas_bagag[n,bagag_size-2]='3') then
      begin
        formtarif_edit.ZQuery1.SQL.Clear;
        formtarif_edit.ZQuery1.SQL.add('UPDATE av_tarif_bagag SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_tarif='+tarif_id);
        formtarif_edit.ZQuery1.SQL.add(' AND id_point='+mas_bagag[n,0]+' AND km_ot='+mas_bagag[n,1]+' AND km_do='+mas_bagag[n,2]+' and del=0;');
        formtarif_edit.ZQuery1.ExecSQL;
       end;
         //если отредактированный или новый
        If (mas_bagag[n,bagag_size-2]='1') or (mas_bagag[n,bagag_size-2]='2') then
       begin
        formtarif_edit.ZQuery1.SQL.Clear;
        formtarif_edit.ZQuery1.SQL.add('INSERT INTO av_tarif_bagag(id_tarif, createdate, id_user, del, id_point, km_ot, km_do, sum, proc');
        formtarif_edit.ZQuery1.SQL.add(',createdate_first,id_user_first');
        formtarif_edit.ZQuery1.SQL.add(') VALUES (');
        formtarif_edit.ZQuery1.SQL.add(inttostr(new_id)+',now(),'+inttostr(id_user)+',0,'+trim(mas_bagag[n,0])+',');
        formtarif_edit.ZQuery1.SQL.add(trim(mas_bagag[n,1])+','+trim(mas_bagag[n,2])+',');
        // Сумма
        formtarif_edit.ZQuery1.SQL.add(trim(mas_bagag[n,3])+',');
        formtarif_edit.ZQuery1.SQL.add(trim(mas_bagag[n,4]));
        // Закрываем запрос
        if (mas_bagag[n,bagag_size-2]='2') then
            formtarif_edit.ZQuery1.SQL.add(',now(),'+inttostr(id_user))
        else
            formtarif_edit.ZQuery1.SQL.add(',null,null');
        formtarif_edit.ZQuery1.SQL.add(');');
        //showmessage('Команда: '+formtarif_edit.ZQuery1.SQL.Text);
        formtarif_edit.ZQuery1.ExecSQL;
        end;
      end;

   //------------------------- НОРМЫ УСЛУГИ -------------------------------
     //if flag_edit_tarif=2 then
     //  begin
     //   formtarif_edit.ZQuery1.SQL.Clear;
     //   formtarif_edit.ZQuery1.SQL.add('UPDATE av_tarif_uslugi SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_tarif='+trim(tarif_id)+' and del=0;');
     //   formtarif_edit.ZQuery1.open;
     //  end;
   for n:=0 to length(mas_uslugi)-1 do
      begin
        If (mas_uslugi[n,uslugi_size-2]='1') or (mas_uslugi[n,uslugi_size-2]='2') or (flag_edit_tarif=1) then
        begin
         if flag_edit_tarif=2 then
          begin
           formtarif_edit.ZQuery1.SQL.Clear;
           formtarif_edit.ZQuery1.SQL.add('UPDATE av_tarif_uslugi SET del=1,createdate=now(),id_user='+inttostr(id_user));
           formtarif_edit.ZQuery1.SQL.add(' WHERE id_tarif='+trim(tarif_id)+' AND id_point='+mas_uslugi[n,0]+' AND id_uslugi='+mas_uslugi[n,2]+' and del=0;');
           //showmessage(formtarif_edit.ZQuery1.SQL.Text);//$
           formtarif_edit.ZQuery1.ExecSQL;
         end;
        formtarif_edit.ZQuery1.SQL.Clear;
        formtarif_edit.ZQuery1.SQL.add('INSERT INTO av_tarif_uslugi(id_tarif, createdate, id_user, del, id_point, id_uslugi, activ, sum, proc');
        if flag_edit_tarif=1 then formtarif_edit.ZQuery1.SQL.add(',createdate_first,id_user_first');
        formtarif_edit.ZQuery1.SQL.add(') VALUES (');
        formtarif_edit.ZQuery1.SQL.add(inttostr(new_id)+',now(),'+inttostr(id_user)+',0,'+trim(mas_uslugi[n,0])+','+trim(mas_uslugi[n,2])+',');
        formtarif_edit.ZQuery1.SQL.add(trim(mas_uslugi[n,1])+','+trim(mas_uslugi[n,6])+','+trim(mas_uslugi[n,5]));
        // Закрываем запрос
        if (flag_edit_tarif=1) or (mas_uslugi[n,uslugi_size-2]='2')  then
          formtarif_edit.ZQuery1.SQL.add(',now(),'+inttostr(id_user)+');')
        else
          formtarif_edit.ZQuery1.SQL.add(');');

        //showmessage(formtarif_edit.ZQuery1.SQL.Text);//$
        formtarif_edit.ZQuery1.ExecSQL;
        end;
      end;

      //------------------------- НОРМЫ ЛЬГОТ -------------------------------
  if (flag_edit_tarif=2) and fledit_lgot then
       begin
        formtarif_edit.ZQuery1.SQL.Clear;
        formtarif_edit.ZQuery1.SQL.add('UPDATE av_tarif_lgot SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE id_tarif='+trim(tarif_id)+' and del=0;');
        formtarif_edit.ZQuery1.ExecSQL;
       end;
  If ((flag_edit_tarif=2) and fledit_lgot) or (flag_edit_tarif=1) then
       begin
   for n:=1 to formtarif_edit.StringGrid5.rowcount-1 do
      begin
        formtarif_edit.ZQuery1.SQL.Clear;
        formtarif_edit.ZQuery1.SQL.add('INSERT INTO av_tarif_lgot(id_tarif, createdate, id_user, del, id_lgot, activ, sum, proc');
        if flag_edit_tarif=1 then formtarif_edit.ZQuery1.SQL.add(',createdate_first,id_user_first');
        formtarif_edit.ZQuery1.SQL.add(') VALUES (');
        formtarif_edit.ZQuery1.SQL.add(inttostr(new_id)+',now(),'+inttostr(id_user)+',0,'+trim(formtarif_edit.StringGrid5.Cells[1,n])+','+trim(formtarif_edit.StringGrid5.Cells[0,n])+',');
        if  trim(formtarif_edit.StringGrid5.Cells[5,n])='' then formtarif_edit.StringGrid5.Cells[5,n]:='0.00';
        if  trim(formtarif_edit.StringGrid5.Cells[4,n])='' then formtarif_edit.StringGrid5.Cells[4,n]:='0';
        formtarif_edit.ZQuery1.SQL.add(trim(formtarif_edit.StringGrid5.Cells[5,n])+','+trim(formtarif_edit.StringGrid5.Cells[4,n]));
        // Закрываем запрос
        if flag_edit_tarif=1 then formtarif_edit.ZQuery1.SQL.add(',now(),'+inttostr(id_user));
        formtarif_edit.ZQuery1.SQL.add(');');
     //   showmessagealt(formtarif_edit.ZQuery1.SQL.text);
     //showmessage('Команда: '+formtarif_edit.ZQuery1.SQL.Text);
        formtarif_edit.ZQuery1.ExecSQL;
      end;
   end;


   //--------------------- НОРМЫ Количество предварительных дней продажи ------------------------------
  if flag_edit_tarif=2 then
       begin
        formtarif_edit.ZQuery1.SQL.Clear;
        formtarif_edit.ZQuery1.SQL.add('UPDATE av_tarif_predv SET del=1,createdate=now(),id_user='+inttostr(new_id)+' WHERE id_tarif='+trim(tarif_id)+' and del=0;');
        //showmessage(formtarif_edit.ZQuery1.SQL.text);//$
        formtarif_edit.ZQuery1.ExecSQL;
       end;
   for n:=0 to length(mas_predv)-1 do
      begin
        formtarif_edit.ZQuery1.SQL.Clear;
        formtarif_edit.ZQuery1.SQL.add('INSERT INTO av_tarif_predv(id_tarif, createdate, id_user, del,id_point,kolday,bron_cancel,prigorod_rajon, days_min, id_uslugi');
        if flag_edit_tarif=1 then formtarif_edit.ZQuery1.SQL.add(',createdate_first,id_user_first');
        formtarif_edit.ZQuery1.SQL.add(') VALUES (');
        formtarif_edit.ZQuery1.SQL.add(inttostr(new_id)+',now(),'+inttostr(id_user)+',0,'+mas_predv[n,0]+','+mas_predv[n,1]+','+mas_predv[n,2]+','+Quotedstr(trim(mas_predv[n,3])));
        formtarif_edit.ZQuery1.SQL.add(','+mas_predv[n,4]+','+mas_predv[n,5]);
        // Закрываем запрос
        if flag_edit_tarif=1 then formtarif_edit.ZQuery1.SQL.add(',now(),'+inttostr(id_user));
        formtarif_edit.ZQuery1.SQL.add(');');
        //If mas_predv[n,0]='815' then
         //showmessage(formtarif_edit.ZQuery1.sql.text);//$
         //showmessage('Команда: '+formtarif_edit.ZQuery1.SQL.Text);
        formtarif_edit.ZQuery1.ExecSQL;
      end;

 //================= Завершение транзакции==============================
  formtarif_edit.Zconnection1.Commit;
  formtarif_edit.ZQuery1.Close;
  formtarif_edit.Zconnection1.disconnect;
  showmessagealt('Данные сохранены !');
  formtarif_edit.Close;
 except
    //showmessage(formtarif_edit.ZQuery1.SQL.Text);//$
     formtarif_edit.ZConnection1.Rollback;
     formtarif_edit.ZQuery1.Close;
     formtarif_edit.Zconnection1.disconnect;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!');
 end;

end;


// ============== Удаляем последнюю запись сетки тарифа =================================
procedure TFormtarif_edit.BitBtn6Click(Sender: TObject);
begin
 fledit_bag:=true;
  if formtarif_edit.StringGrid4.Rowcount>1 then DelStringGrid(formtarif_edit.StringGrid4,formtarif_edit.StringGrid4.rowcount-1);
end;


// ===============  Выбор даты для нового тарифа ===========================================
procedure TFormtarif_edit.DateEdit1Change(Sender: TObject);
 var
    n:integer;
begin
    //Создаем новый тариф
    if (flag_edit_tarif=3) then
      begin
        // проверка на доступность предыдущего тарифа введенная дата должна быть > предыдущей даты тарифа
        // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
        formtarif_edit.ZQuery1.SQL.clear;
        formtarif_edit.ZQuery1.SQL.add('select max(datetarif) as maxtarif from av_tarif where del=0;');
           try
   formtarif_edit.ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+formtarif_edit.ZQuery1.SQL.Text);
    formtarif_edit.ZQuery1.Close;
    formtarif_edit.Zconnection1.disconnect;
    exit;
  end;
        if (formtarif.StringGrid1.RowCount>1) and (strtodate(formtarif_edit.DateEdit1.text)<=strtodate(formtarif_edit.ZQuery1.FieldByName('maxtarif').asString)) then
          begin
            showmessagealt('Выбранная дата '+trim(formtarif_edit.DateEdit1.text)+' меньше, либо равна '+#13+
                        'предыдущей даты действия тарифа от '+trim(formtarif_edit.ZQuery1.FieldByName('maxtarif').asString)+#13+
                        'Для продолжения выберите другую дату начала действия тарифа большую чем '+trim(formtarif_edit.ZQuery1.FieldByName('maxtarif').asString));
            formtarif_edit.DateEdit1.text:=datetostr(strtodate(formtarif_edit.ZQuery1.FieldByName('maxtarif').asString)+1);
            formtarif_edit.ZQuery1.Close;
            formtarif_edit.Zconnection1.disconnect;
            exit;
          end;
        formtarif_edit.ZQuery1.Close;
        formtarif_edit.Zconnection1.disconnect;
        formtarif_edit.PageControl1.Enabled:=true;
        formtarif_edit.Uslugi();
      end;
end;


// ================== Горячие клавиши =============================
procedure TFormtarif_edit.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F2] - Сохранить'+ #13+'[F5] - Добавить'+#13+'[F8] - Удалить'+#13+'[ENTER] - Отметить услугу'+ #13+'[ESC] - Отмена\Выход');
    // ESC
    if Key=27 then formtarif_edit.Close;
    // F2 - Сохранить
    if (Key=113) and (formtarif_edit.BitBtn5.Enabled=true) then formtarif_edit.BitBtn5.Click;
    //F5 - Добавить
    if (Key=116) then
       begin
        if formtarif_edit.StringGrid1.Focused=true then formtarif_edit.BitBtn9.Click;
        if formtarif_edit.StringGrid4.Focused=true then formtarif_edit.BitBtn7.Click;
       end;
    //F8 - Удалить
    if (Key=119) then
       begin
        if formtarif_edit.StringGrid1.Focused=true then formtarif_edit.BitBtn10.Click;
        if formtarif_edit.StringGrid4.Focused=true then formtarif_edit.BitBtn8.Click;
       end;
    // ENTER
    if (Key=13) and (formtarif_edit.StringGrid2.Focused) then
      begin
        if trim(formtarif_edit.StringGrid2.Cells[0,formtarif_edit.StringGrid2.row])='0' then
          begin
           formtarif_edit.StringGrid2.Cells[0,formtarif_edit.StringGrid2.row]:='1';
           formtarif_edit.StringGrid2.Repaint;
           exit;
          end;
        if trim(formtarif_edit.StringGrid2.Cells[0,formtarif_edit.StringGrid2.row])='1' then
          begin
           formtarif_edit.StringGrid2.Cells[0,formtarif_edit.StringGrid2.row]:='0';
           formtarif_edit.StringGrid2.Repaint;
           exit;
          end;
      end;
end;

// ========== Определение маски ввода силовых данных в опциях ТАРИФА ==================
//procedure TFormtarif_edit.StringGrid1GetEditMask(Sender: TObject; ACol,
  //ARow: Integer; var Value: string);
//begin
    // маска вводимых занчений
   //if ACol=5 then Value := '!9999999.99;1;  ');
//end;

// ========== Определение маски ввода силовых данных в сетке БАГАЖА ==================
//procedure TFormtarif_edit.StringGrid4GetEditMask(Sender: TObject; ACol,
  //ARow: Integer; var Value: string);
//begin
  // маска вводимых занчений
  //if ACol=1 then Value := '!9999999;1;  ');
  //if ACol=2 then Value := '!9999999.99;1;  ');
  //if ACol=3 then Value := '!999;1;  ');
//end;

//========================= Форматируем поля сетки БАГАЖА ============================
procedure TFormtarif_edit.StringGrid4SelectCell(Sender: TObject; aCol,
  aRow: Integer; var CanSelect: Boolean);
begin
  formtarif_edit.StringGrid4.Cells[formtarif_edit.StringGrid4.Col,formtarif_edit.StringGrid4.Row]:=AnsiReplaceStr(formtarif_edit.StringGrid4.Cells[formtarif_edit.StringGrid4.Col,formtarif_edit.StringGrid4.Row],' ','');
end;

procedure TFormtarif_edit.StringGrid5CheckboxToggled(sender: TObject; aCol,
  aRow: Integer; aState: TCheckboxState);
begin
  fledit_lgot:=true;
end;


procedure TFormtarif_edit.StringGrid5EditingDone(Sender: TObject);
begin
  fledit_lgot:=true;
   // %
   if Formtarif_edit.StringGrid5.col=4 then
     begin
      Formtarif_edit.StringGrid5.Cells[4,Formtarif_edit.StringGrid5.row]:=FormatNum(Formtarif_edit.StringGrid5.Cells[4,Formtarif_edit.StringGrid5.row],0);
     end;
   // Рубли
   if Formtarif_edit.StringGrid5.col=5 then
     begin
      Formtarif_edit.StringGrid5.Cells[5,Formtarif_edit.StringGrid5.row]:=FormatNum(Formtarif_edit.StringGrid5.Cells[5,Formtarif_edit.StringGrid5.row],2);
     end;

   // Проверяем и оставляем только руб. или %
   if  (Formtarif_edit.StringGrid5.Col=4) and
       not(trim(Formtarif_edit.StringGrid5.Cells[4,Formtarif_edit.StringGrid5.row])='') and
       not(trim(Formtarif_edit.StringGrid5.Cells[4,Formtarif_edit.StringGrid5.row])='0') then
    begin
         Formtarif_edit.StringGrid5.Cells[5,Formtarif_edit.StringGrid5.row]:='0.00';
    end;
   if  (Formtarif_edit.StringGrid5.Col=5) and
       not(trim(Formtarif_edit.StringGrid5.Cells[5,Formtarif_edit.StringGrid5.row])='') and
       not(trim(Formtarif_edit.StringGrid5.Cells[5,Formtarif_edit.StringGrid5.row])='0.0') then
    begin
         Formtarif_edit.StringGrid5.Cells[4,Formtarif_edit.StringGrid5.row]:='0';
    end;

end;

procedure TFormtarif_edit.StringGrid5KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    fledit_lgot:=true;
end;

//procedure TFormtarif_edit.StringGrid5GetEditMask(Sender: TObject; ACol,
  //ARow: Integer; var Value: string);
//begin
    // маска вводимых занчений
  //if ACol=4 then Value := '!999;1;  ');
  //if ACol=5 then Value := '!9999999.99;1;  ');
//end;


end.

