unit ats_edit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, Spin, ButtonPanel, EditBtn,
  Grids, ExtDlgs,
  {$IFDEF UNIX}
  unix,
  {$ENDIF}
  platproc,DB;

type

  { TForm14 }

  TForm14 = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit44: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    OpenPictureDialog1: TOpenPictureDialog;
    RadioGroup1: TRadioGroup;
    Shape10: TShape;
    Shape11: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    SpinEdit1: TSpinEdit;
    StaticText1: TStaticText;
    StringGrid2: TStringGrid;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit10Change(Sender: TObject);
    procedure Edit11Change(Sender: TObject);
    procedure Edit12Change(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit8Change(Sender: TObject);
    procedure Edit9Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure RadioGroup1ChangeBounds(Sender: TObject);
    procedure RadioGroup1SelectionChanged(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit1EditingDone(Sender: TObject);
    procedure StringGrid2DrawCell(Sender: TObject; aCol, aRow: Integer;  aRect: TRect; aState: TGridDrawState);
    procedure Mode_Grid();
    procedure set_mesto(); //Операции над местом
    procedure set_mesto_typ(); //Тип места
    procedure del_mesto(); //Удаляем место
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form14: TForm14;


implementation
 uses
   mainopp,read_nas,ats_main;
{$R *.lfm}

var
  etag1: array[1..5,1..25,1..2] of byte;
  etag2: array[1..5,1..25,1..2] of byte;
  //описание массива   etag
  // etag1[n,n,1] - тип места (1-сидячее,2-стоячее,3-лежачее)
  // etag1[n,n,2] - номер места
  kol_mest1,kol_mest2,mest_vsego:integer;
  new_foto:string;


{ TForm14 }


//********************************************         УДАЛИТЬ МЕСТО   *********************************************
procedure TForm14.del_mesto();
 var
   n,m,num_mesta:Integer;
begin
     if form14.StringGrid2.Cells[form14.StringGrid2.col,form14.StringGrid2.row]=''  then
       begin
         showmessagealt('Выберите место с номером для удаления !');
         exit;
       end;

     if MessageDlg('Вместе с удаляемым местом буду УДАЛЕНЫ' +#13+'все места с номером, большим чем выбранное !'+#13+'Продолжить удаление выбранного места ?',
                    mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;
      // 1 Этаж
      if (form14.RadioGroup1.ItemIndex=0) and (etag1[form14.StringGrid2.Col+1,form14.StringGrid2.row+1,1]>0) then
         begin
           num_mesta:=strtoint(form14.StringGrid2.cells[form14.StringGrid2.Col,form14.StringGrid2.row])-1;
           for n:=1 to 5 do
             begin
             for m:=1 to 25 do
               begin
                if etag1[n,m,1]>num_mesta then
                    begin
                      kol_mest1:=kol_mest1-1;
                      if etag1[n,m,2]=1 then
                         begin
                           form14.Edit7.text:=inttostr(strtoint(form14.Edit7.text)-1);
                         end;
                      if etag1[n,m,2]=2 then
                         begin
                           form14.Edit8.text:=inttostr(strtoint(form14.Edit8.text)-1);
                         end;
                      if etag1[n,m,2]=3 then
                         begin
                           form14.Edit9.text:=inttostr(strtoint(form14.Edit9.text)-1);
                         end;
                      form14.Edit6.text:=inttostr(strtoint(form14.Edit6.text)-1);
                      etag1[n,m,1]:=0;
                      etag1[n,m,2]:=0;
                      form14.StringGrid2.cells[n-1,m-1]:='';
                      //if etag1[form14.StringGrid2.Col+1,form14.StringGrid2.row+1,1]=0 then
                      //   begin
                      //      form14.StringGrid2.cells[n-1,m-1]:='';
                      //   end
                      //else
                      //   begin
                      //      form14.StringGrid2.cells[n-1,m-1]:=inttostr(etag1[form14.StringGrid2.Col+1,form14.StringGrid2.row+1,1]);
                      //   end;
                    end;
               end;
             end;
           //если есть 2-й этаж
            if form14.SpinEdit1.Value=2 then
               begin
                    for n:=1 to 5 do
             begin
             for m:=1 to 25 do
               begin
                if etag2[n,m,1]>num_mesta then
                    begin
                      kol_mest2:= kol_mest2-1;
                      if etag2[n,m,2]=1 then
                         begin
                           form14.edit10.text:=inttostr(strtoint(form14.Edit10.text)-1);
                         end;
                      if etag2[n,m,2]=2 then
                         begin
                           form14.edit11.text:=inttostr(strtoint(form14.Edit11.text)-1);
                         end;
                      if etag2[n,m,2]=3 then
                         begin
                           form14.edit12.text:=inttostr(strtoint(form14.Edit12.text)-1);
                         end;
                      form14.Edit44.text:=inttostr(strtoint(form14.Edit44.text)-1);
                      etag2[n,m,1]:=0;
                      etag2[n,m,2]:=0;
                      //form14.StringGrid2.cells[n-1,m-1]:='';
                      //if etag2[form14.StringGrid2.Col+1,form14.StringGrid2.row+1,1]=0 then
                      //   begin
                      //      form14.StringGrid2.cells[n-1,m-1]:='';
                      //   end
                      //else
                      //   begin
                      //      form14.StringGrid2.cells[n-1,m-1]:=inttostr(etag2[form14.StringGrid2.Col+1,form14.StringGrid2.row+1,1]);
                      //   end;
                    end;
               end;
             end;
               end;
         end;

      // 2 Этаж
      if (form14.RadioGroup1.ItemIndex=1) and (etag2[form14.StringGrid2.Col+1,form14.StringGrid2.row+1,1]>0) then
         begin
           //showmessagealt(inttostr(kol_mest2));
           num_mesta:= strtoint(form14.StringGrid2.cells[form14.StringGrid2.Col,form14.StringGrid2.row])-1;
           for n:=1 to 5 do
             begin
             for m:=1 to 25 do
               begin
                if etag2[n,m,1]>num_mesta then
                    begin
                      kol_mest2:= kol_mest2-1;
                      if etag2[n,m,2]=1 then
                         begin
                           form14.edit10.text:=inttostr(strtoint(form14.Edit10.text)-1);
                         end;
                      if etag2[n,m,2]=2 then
                         begin
                           form14.edit11.text:=inttostr(strtoint(form14.Edit11.text)-1);
                         end;
                      if etag2[n,m,2]=3 then
                         begin
                           form14.edit12.text:=inttostr(strtoint(form14.Edit12.text)-1);
                         end;
                      form14.Edit44.text:=inttostr(strtoint(form14.Edit44.text)-1);
                      etag2[n,m,1]:=0;
                      etag2[n,m,2]:=0;
                      form14.StringGrid2.cells[n-1,m-1]:='';
                      //if etag2[form14.StringGrid2.Col+1,form14.StringGrid2.row+1,1]=0 then
                      //   begin
                      //      form14.StringGrid2.cells[n-1,m-1]:='';
                      //   end
                      //else
                      //   begin
                      //      form14.StringGrid2.cells[n-1,m-1]:=inttostr(etag2[form14.StringGrid2.Col+1,form14.StringGrid2.row+1,1]);
                      //   end;
                    end;
               end;
             end;
             for n:=1 to 5 do
             begin
             for m:=1 to 25 do
               begin
                if etag1[n,m,1]>num_mesta then
                    begin
                      kol_mest1:=kol_mest1-1;
                      if etag1[n,m,2]=1 then
                         begin
                           form14.Edit7.text:=inttostr(strtoint(form14.Edit7.text)-1);
                         end;
                      if etag1[n,m,2]=2 then
                         begin
                           form14.Edit8.text:=inttostr(strtoint(form14.Edit8.text)-1);
                         end;
                      if etag1[n,m,2]=3 then
                         begin
                           form14.Edit9.text:=inttostr(strtoint(form14.Edit9.text)-1);
                         end;
                      form14.Edit6.text:=inttostr(strtoint(form14.Edit6.text)-1);
                      etag1[n,m,1]:=0;
                      etag1[n,m,2]:=0;
                      //form14.StringGrid2.cells[n-1,m-1]:='';
                      //if etag1[form14.StringGrid2.Col+1,form14.StringGrid2.row+1,1]=0 then
                      //   begin
                      //      form14.StringGrid2.cells[n-1,m-1]:='';
                      //   end
                      //else
                      //   begin
                      //      form14.StringGrid2.cells[n-1,m-1]:=inttostr(etag1[form14.StringGrid2.Col+1,form14.StringGrid2.row+1,1]);
                      //   end;
                    end;
               end;
             end;
         end;
      //если 2-го этажа больше нет
      If (kol_mest2=0) and (form14.SpinEdit1.value=2) then form14.SpinEdit1.value:=1;

      mest_vsego:=kol_mest1+kol_mest2;
      form14.stringgrid2.Repaint;
end;


//Цвет местом
procedure TForm14.set_mesto_typ;
var
  n,m:integer;
begin
 with Form14 do
 begin
      m:=StringGrid2.Col+1;
      n:=StringGrid2.row+1;
  // 1 Этаж
  if (RadioGroup1.ItemIndex=0) and (etag1[m,n,1]>0) then
     begin
       // Убираем текущий тип из информации
       if etag1[m,n,2]=1 then
          begin
           Edit7.text:=inttostr(strtoint(Edit7.Text)-1);
          end;
       if etag1[m,n,2]=2 then
          begin
           Edit8.text:=inttostr(strtoint(Edit8.Text)-1);
          end;
       if etag1[m,n,2]=3 then
          begin
           Edit9.text:=inttostr(strtoint(Edit9.Text)-1);
          end;

       // Ставим новый тип
       if etag1[m,n,2]=3 then
          begin
            etag1[m,n,2]:=1;
            //Корректировка смены с лежачего на простое
            etag1[m,n+1,2]:=1;
            Edit7.text:=inttostr(strtoint(Edit7.Text)+2);
            StringGrid2.Repaint;
            exit;
          end;
       if etag1[m,n,2]<3 then
          begin
            //Корректировка смены с лежачего на простое
            if (etag1[m,n+1,2]=3) and (etag1[m,n,2]+1=3) then
               begin
                 //Edit8.Text:=inttostr(strtoint(Edit8.Text)-1);
                 Edit7.Text:=inttostr(strtoint(Edit7.Text)+1);
                 etag1[m,n,2]:=1;
                 showmessagealt('Тип места [ЛЕЖА] нельзя поставить,'+#13+'так как место №'+inttostr(etag1[m,n+1,1])+' занято другим местом [ЛЕЖА]');
                 StringGrid2.Repaint;
                 exit;
               end;
            etag1[m,n,2]:=etag1[m,n,2]+1
          end;

          // Ставим текущий тип из информации
       if etag1[m,n,2]=1 then
          begin
           Edit7.text:=inttostr(strtoint(Edit7.Text)+1);
          end;
       if etag1[m,n,2]=2 then
          begin
           Edit8.text:=inttostr(strtoint(Edit8.Text)+1);
          end;
       if etag1[m,n,2]=3 then
          begin
           Edit9.text:=inttostr(strtoint(Edit9.Text)+1);
          end;
       // Корректировка места на лежачее
       if etag1[m,n,2]=3 then
          begin
            if (StringGrid2.row=24) or (etag1[m,n+1,1]=0) then
               begin
                  showmessagealt('Недостаточно доступных мест ниже для установки типа места [ЛЕЖА] !');
                  Edit9.Text:=inttostr(strtoint(Edit9.Text)-1);
                  Edit7.Text:=inttostr(strtoint(Edit7.Text)+1);
                  etag1[m,n,2]:=1;
                  StringGrid2.Repaint;
                  exit;
               end;
           //Корректировка на лежачие
           if etag1[m,n+1,2]=2 then
              begin
                Edit8.Text:=inttostr(strtoint(Edit8.Text)-1);
              end;
           if etag1[m,n+1,2]=1 then
              begin
                Edit7.Text:=inttostr(strtoint(Edit7.Text)-1);
              end;
           etag1[m,n+1,2]:=4;
         end;
     end;

  // 2 Этаж
    if (RadioGroup1.ItemIndex=1) and (etag2[m,n,1]>0) then
     begin
       // Убираем текущий тип из информации
       if etag2[m,n,2]=1 then
          begin
           edit10.text:=inttostr(strtoint(edit10.Text)-1);
          end;
       if etag2[m,n,2]=2 then
          begin
           edit11.text:=inttostr(strtoint(edit11.Text)-1);
          end;
       if etag2[m,n,2]=3 then
          begin
           edit12.text:=inttostr(strtoint(edit12.Text)-1);
          end;

       // Ставим новый тип
       if etag2[m,n,2]=3 then
          begin
            etag2[m,n,2]:=1;
            //Корректировка смены с лежачего на простое
            etag2[m,n+1,2]:=1;
            edit10.text:=inttostr(strtoint(edit10.Text)+2);
            StringGrid2.Repaint;
            exit;
          end;
       if etag2[m,n,2]<3 then
          begin
            //Корректировка смены с лежачего на простое
            if (etag2[m,n+1,2]=3) and (etag2[m,n,2]+1=3) then
               begin
                 //edit11.Text:=inttostr(strtoint(edit11.Text)-1);
                 edit10.Text:=inttostr(strtoint(edit10.Text)+1);
                 etag2[m,n,2]:=1;
                 showmessagealt('Тип места [ЛЕЖА] нельзя поставить,'+#13+'так как место №'+inttostr(etag2[m,n+1,1])+' занято другим местом [ЛЕЖА]');
                 StringGrid2.Repaint;
                 exit;
               end;
            etag2[m,n,2]:=etag2[m,n,2]+1
          end;

          // Ставим текущий тип из информации
       if etag2[m,n,2]=1 then
          begin
           edit10.text:=inttostr(strtoint(edit10.Text)+1);
          end;
       if etag2[m,n,2]=2 then
          begin
           edit11.text:=inttostr(strtoint(edit11.Text)+1);
          end;
       if etag2[m,n,2]=3 then
          begin
           edit12.text:=inttostr(strtoint(edit12.Text)+1);
          end;
       // Корректировка места на лежачее
       if etag2[m,n,2]=3 then
          begin
            if (StringGrid2.row=24) or (etag2[m,n+1,1]=0) then
               begin
                  showmessagealt('Недостаточно доступных мест ниже для установки типа места [ЛЕЖА] !');
                  edit12.Text:=inttostr(strtoint(edit12.Text)-1);
                  edit10.Text:=inttostr(strtoint(edit10.Text)+1);
                  etag2[m,n,2]:=1;
                  StringGrid2.Repaint;
                  exit;
               end;
           //Корректировка на лежачие
           if etag2[m,n+1,2]=2 then
              begin
                edit11.Text:=inttostr(strtoint(edit11.Text)-1);
              end;
           if etag2[m,n+1,2]=1 then
              begin
                edit10.Text:=inttostr(strtoint(edit10.Text)-1);
              end;
           etag2[m,n+1,2]:=4;
         end;
     end;
  StringGrid2.Repaint;
  end;
end;


//**********************     Операции над местом           ************************************************
procedure TForm14.set_mesto();
begin
  //Ставим новое место
  if trim(form14.StringGrid2.Cells[form14.StringGrid2.Col,form14.StringGrid2.row])='' then
     begin
       if form14.RadioGroup1.ItemIndex=0 then
          begin
            kol_mest1:=kol_mest1+1;
            mest_vsego:=kol_mest1+kol_mest2;
            form14.StringGrid2.Cells[form14.StringGrid2.Col,form14.StringGrid2.row]:=inttostr(mest_vsego);
            etag1[(form14.StringGrid2.Col+1),(form14.StringGrid2.row+1),1]:=mest_vsego;
            etag1[(form14.StringGrid2.Col+1),(form14.StringGrid2.row+1),2]:=1; //ставим сидячее по умолчанию
            form14.Edit6.Text:=inttostr(strtoint(form14.Edit6.Text)+1);
            form14.Edit7.Text:=inttostr(strtoint(form14.Edit7.Text)+1);
          end
       else
         begin
           If form14.SpinEdit1.value=1 then form14.SpinEdit1.value:=2;
            kol_mest2:=kol_mest2+1;
            mest_vsego:=kol_mest1+kol_mest2;
           // form14.StringGrid2.Cells[form14.StringGrid2.Col,form14.StringGrid2.row]:=inttostr(kol_mest2+kol_mest1);
           // etag2[(form14.StringGrid2.Col+1),(form14.StringGrid2.row+1),1]:=kol_mest2+kol_mest1;
            form14.StringGrid2.Cells[form14.StringGrid2.Col,form14.StringGrid2.row]:=inttostr(mest_vsego);
            etag2[(form14.StringGrid2.Col+1),(form14.StringGrid2.row+1),1]:=mest_vsego;
            etag2[(form14.StringGrid2.Col+1),(form14.StringGrid2.row+1),2]:=1; //ставим сидячее по умолчанию
            form14.Edit44.Text:=inttostr(strtoint(form14.Edit44.Text)+1);
            form14.Edit10.Text:=inttostr(strtoint(form14.Edit10.Text)+1);
         end;

       // Перемещаем фокус автоматически

       if (form14.StringGrid2.Col=4) and (form14.StringGrid2.row<24) then
        begin
          form14.StringGrid2.Col:=3;
          form14.StringGrid2.row:=form14.StringGrid2.row+1;
          exit;
        end;
       if (form14.StringGrid2.Col=3) and (form14.StringGrid2.row<24) then
        begin
          form14.StringGrid2.Col:=4;
          exit;
        end;

       if (form14.StringGrid2.Col=4) and (form14.StringGrid2.row=24) then
        begin
          form14.StringGrid2.Col:=0;
          form14.StringGrid2.row:=0;
          exit;
        end;

       if (form14.StringGrid2.Col=3) and (form14.StringGrid2.row=24) then
        begin
          form14.StringGrid2.Col:=4;
          form14.StringGrid2.row:=24;
          exit;
        end;
       if (form14.StringGrid2.Col=0) and (form14.StringGrid2.row<24) then
        begin
          form14.StringGrid2.Col:=1;
          exit;
        end;
       if (form14.StringGrid2.Col=1) and (form14.StringGrid2.row<24) then
        begin
          form14.StringGrid2.Col:=0;
          form14.StringGrid2.row:=form14.StringGrid2.row+1;
          exit;
        end;
       if (form14.StringGrid2.Col=0) and (form14.StringGrid2.row=24) then
        begin
          form14.StringGrid2.Col:=1;
          form14.StringGrid2.row:=24;
          exit;
        end;
       if (form14.StringGrid2.Col=1) and (form14.StringGrid2.row=24) then
        begin
          form14.StringGrid2.Col:=3;
          form14.StringGrid2.row:=0;
          exit;
        end;
     end;
end;

//
procedure TForm14.Mode_Grid();
 var
   n,m:integer;
begin
  with Form14.RadioGroup1 do
  begin
  if ItemIndex=0 then
    begin
      form14.StringGrid2.Color:=clCream;
      //Items[0].font.Color:=clRed;
      //Items[0].font.Color:=clDefault;
    end
  else
    begin
      form14.StringGrid2.Color:=clSkyBlue;
      //Items[1].font.Color:=clRed;
      //Items[1].font.Color:=clDefault;
    end;

    // Перерисовываем stringgrid
    for n:=1 to 5 do
       begin
             for m:=1 to 25 do
               begin
                     if ItemIndex=0 then
                        begin
                          if etag1[n,m,1]>0 then form14.StringGrid2.cells[n-1,m-1]:=inttostr(etag1[n,m,1]);
                          if etag1[n,m,1]=0 then form14.StringGrid2.cells[n-1,m-1]:='';
                       end;
                     if ItemIndex=1 then
                        begin
                         if etag2[n,m,1]>0 then form14.StringGrid2.cells[n-1,m-1]:=inttostr(etag2[n,m,1]);
                         if etag2[n,m,1]=0 then form14.StringGrid2.cells[n-1,m-1]:='';
                        end;
                end;
       end;
    //form14.StringGrid2.Repaint;
  end;
end;


//*****************************  НАЖАТИЕ КЛАВИШИ      *****************************************************************
procedure TForm14.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState  );
begin
    // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F2] - Сохранить'+#13+'[ENTER] - Установить место'+#13+'[ПРОБЕЛ] - Поменять тип места'+#13+'[DEL] - Удалить место'+#13+'[ESC] - Отмена\Выход');
    // ESC
    if Key=27 then form14.Close;
    // F2 - Сохранить
    if (Key=113) and (form14.BitBtn3.Enabled=true) then form14.BitBtn3.Click;
    // ENTER - Ставим место
    if (Key=13) and (form14.StringGrid2.Focused) then form14.set_mesto;
    // ПРОБЕЛ - Меняем тип места
    if (Key=32) and (form14.StringGrid2.Focused) then form14.set_mesto_typ;
    //DEL - Удаляем место
    if (Key=46) and (form14.StringGrid2.Focused) then form14.del_mesto;

end;


//***************************************         ВОЗНИКНОВЕНИЕ ФОРМЫ    ************************************
procedure TForm14.FormShow(Sender: TObject);
 var
   n,m:integer;
   BlobStream: TStream;
   FileStream: TStream;
begin
   with form14 do
       begin
    if flag_access=1 then
     begin
        BitBtn1.Enabled:=false;
        BitBtn3.Enabled:=false;
       end;

  //Рисуем Stringgrid
  for n:=1 to 5 do
   begin
      for m:=1 to 25 do
        begin
             etag1[n,m,1]:=0;
             etag1[n,m,2]:=0;
             etag2[n,m,1]:=0;
             etag2[n,m,2]:=0;
        end;
   end;
  kol_mest1:=0;
  kol_mest2:=0;
  mest_vsego:=0;
  form14.StringGrid2.row:=0;
  form14.StringGrid2.col:=0;
  form14.StringGrid2.SetFocus;
//режим редактирования или режим создания на основе существующей марки
  if (flag_edit_ats=2) OR (flag_edit_ats=3) then
    begin
          // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
        //Определяем текущий id+1
       try
        form14.ZQuery1.SQL.Clear;
        form14.ZQuery1.SQL.add('SELECT * FROM av_spr_ats where id='+trim(form13.StringGrid1.Cells[0,form13.StringGrid1.row])+' and del=0;');
        //showmessage(form14.ZQuery1.SQL.text);//$
        form14.ZQuery1.open;
       except
           form14.Zconnection1.disconnect;
           showmessagealt('Соединение с сервером базы данных отсутствует !'+#13+'Возможно неправильно установлены опции файла настроек системы или'+#13+'сетевое подключение к серверу недоступно ?'+#13+'Обратитесь к администратору системы...');
           exit;
       end;
     //showmessage(form14.ZQuery1.FieldByName('m_down').asString);//$
       // Определяем начальные переменные
       //Фото
       if form14.ZQuery1.FieldByName('foto').IsBlob then
        begin
          BlobStream := form14.ZQuery1.CreateBlobStream(form14.ZQuery1.FieldByName('foto'), bmRead);
          If BlobStream.Size>10 then
            begin
           try
             FileStream:= TFileStream.Create('foto_ats.jpg', fmCreate);
               try
                FileStream.CopyFrom(BlobStream, BlobStream.Size);
               finally
                FileStream.Free;
               end;
           finally
            BlobStream.Free;
           end;
           form14.image2.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'foto_ats.jpg');
        end;
        end;

       // Кол этажей
       form14.SpinEdit1.Value:=form14.ZQuery1.FieldByName('level').asInteger;
       form14.Edit1.text:=form14.ZQuery1.FieldByName('id').asString;
       form14.Edit2.text:=form14.ZQuery1.FieldByName('name').asString;
       form14.Edit3.text:=form14.ZQuery1.FieldByName('gos').asString;
       form14.Edit4.text:=form14.ZQuery1.FieldByName('god').asString;
       form14.combobox1.ItemIndex:=form14.ZQuery1.FieldByName('type_ats').asInteger;
       form14.combobox2.ItemIndex:=form14.ZQuery1.FieldByName('comfort').asInteger;
       //1-ПЕРВЫЙ ЭТАЖ
      //showmessage(form14.ZQuery1.FieldByName('m_down').asString);//$
       form14.Edit7.Text:=form14.ZQuery1.FieldByName('m_down').asString;
       form14.Edit8.Text:=form14.ZQuery1.FieldByName('m_up').asString;
       form14.Edit9.Text:=form14.ZQuery1.FieldByName('m_lay').asString;
       //2-ВТОРОЙ ЭТАЖ
       //form14.Edit10.Text:=form14.ZQuery1.FieldByName('m_down_two').asString;
       form14.Edit11.Text:=form14.ZQuery1.FieldByName('m_up_two').asString;
       form14.Edit12.Text:=form14.ZQuery1.FieldByName('m_lay_two').asString;
       // Заполняем массивы данными
       //1-2-ЭТАЖ
       for n:=1 to 5 do
         begin
          for m:=1 to 25 do
            begin
              // 1 ряд
              if n=1 then etag1[n,m,1]:=strtoint(copy(form14.ZQuery1.FieldByName('one_one').asString,((m-1)*4+2),3));
              if n=1 then etag1[n,m,2]:=strtoint(copy(form14.ZQuery1.FieldByName('one_one').asString,((m-1)*4+1),1));
              if n=1 then etag2[n,m,1]:=strtoint(copy(form14.ZQuery1.FieldByName('two_one').asString,((m-1)*4+2),3));
              if n=1 then etag2[n,m,2]:=strtoint(copy(form14.ZQuery1.FieldByName('two_one').asString,((m-1)*4+1),1));
              // 2 ряд
              if n=2 then etag1[n,m,1]:=strtoint(copy(form14.ZQuery1.FieldByName('one_two').asString,((m-1)*4+2),3));
              if n=2 then etag1[n,m,2]:=strtoint(copy(form14.ZQuery1.FieldByName('one_two').asString,((m-1)*4+1),1));
              if n=2 then etag2[n,m,1]:=strtoint(copy(form14.ZQuery1.FieldByName('two_two').asString,((m-1)*4+2),3));
              if n=2 then etag2[n,m,2]:=strtoint(copy(form14.ZQuery1.FieldByName('two_two').asString,((m-1)*4+1),1));
              // 3 ряд
              if n=3 then etag1[n,m,1]:=strtoint(copy(form14.ZQuery1.FieldByName('one_three').asString,((m-1)*4+2),3));
              if n=3 then etag1[n,m,2]:=strtoint(copy(form14.ZQuery1.FieldByName('one_three').asString,((m-1)*4+1),1));
              if n=3 then etag2[n,m,1]:=strtoint(copy(form14.ZQuery1.FieldByName('two_three').asString,((m-1)*4+2),3));
              if n=3 then etag2[n,m,2]:=strtoint(copy(form14.ZQuery1.FieldByName('two_three').asString,((m-1)*4+1),1));
              // 4 ряд
              if n=4 then etag1[n,m,1]:=strtoint(copy(form14.ZQuery1.FieldByName('one_four').asString,((m-1)*4+2),3));
              if n=4 then etag1[n,m,2]:=strtoint(copy(form14.ZQuery1.FieldByName('one_four').asString,((m-1)*4+1),1));
              if n=4 then etag2[n,m,1]:=strtoint(copy(form14.ZQuery1.FieldByName('two_four').asString,((m-1)*4+2),3));
              if n=4 then etag2[n,m,2]:=strtoint(copy(form14.ZQuery1.FieldByName('two_four').asString,((m-1)*4+1),1));
              // 5 ряд
              if n=5 then etag1[n,m,1]:=strtoint(copy(form14.ZQuery1.FieldByName('one_five').asString,((m-1)*4+2),3));
              if n=5 then etag1[n,m,2]:=strtoint(copy(form14.ZQuery1.FieldByName('one_five').asString,((m-1)*4+1),1));
              if n=5 then etag2[n,m,1]:=strtoint(copy(form14.ZQuery1.FieldByName('two_five').asString,((m-1)*4+2),3));
              if n=5 then etag2[n,m,2]:=strtoint(copy(form14.ZQuery1.FieldByName('two_five').asString,((m-1)*4+1),1));
              if etag1[n,m,1]>0 then kol_mest1:=kol_mest1+1;
              if etag2[n,m,1]>0 then kol_mest2:=kol_mest2+1;
              //корректное кол-во мест на втором этаже
              If etag2[n,m,2]=1 then edit10.Text:=inttostr(strtoint(edit10.Text)+1);
              if etag1[n,m,1]>0 then form14.StringGrid2.cells[n-1,m-1]:=inttostr(etag1[n,m,1])
                                else form14.StringGrid2.cells[n-1,m-1]:='';
            end;
         end;
        form14.edit6.Text:=inttostr(kol_mest1);
        form14.edit44.Text:=inttostr(kol_mest2);
        mest_vsego:=kol_mest1+kol_mest2;
        form14.SpinEdit1.Refresh;
        form14.StringGrid2.Repaint;
        form14.ZQuery1.close;
        form14.ZConnection1.Disconnect;
    end;
  If (flag_edit_ats=3) then
    begin
      Edit1.Text:='';
      Edit3.Text:='';
      Edit4.Text:='';
      flag_edit_ats:=1;
      end;

    form14.RadioGroup1.ItemIndex:=0;
    end;
end;

procedure TForm14.RadioGroup1ChangeBounds(Sender: TObject);
begin

end;

//***********************  ПЕРЕКЛЮЧЕНИЕ ЭТАЖЕЙ  **********************************
procedure TForm14.RadioGroup1SelectionChanged(Sender: TObject);
begin
  Mode_Grid();
end;

procedure TForm14.SpinEdit1Change(Sender: TObject);
begin

end;

procedure TForm14.SpinEdit1EditingDone(Sender: TObject);
  var
  n,m:integer;
begin
  //если было 2 этажа, удаляем второй этаж
  if form14.SpinEdit1.value=1 then
    begin
      if MessageDlg('Вы действительно хотите удалить информацию о 2-м этаже ?',mtConfirmation,[mbYes, mbNo],0)=7 then
        begin
          form14.SpinEdit1.Text:='2';
          exit;
        end;

      for n:=1 to 5 do
         begin
           for m:=1 to 25 do
            begin
                etag2[n,m,1]:=0;
                etag2[n,m,2]:=0;
            end;
         end;
      kol_mest2:=0;
   form14.RadioGroup1.ItemIndex:=0;
   end;
  if form14.SpinEdit1.value=2 then form14.RadioGroup1.ItemIndex:=1;
end;


//*********************** ОТРИСОВКА ГРИДА (КАРТА АВТОБУСА )
procedure TForm14.StringGrid2DrawCell(Sender: TObject; aCol, aRow: Integer;  aRect: TRect; aState: TGridDrawState);
begin
 with Sender as TStringGrid, Canvas do
 begin
  if (gdFocused in aState) then
     begin
       //Brush.Color := clRed;
       pen.Width:=3;
       pen.Color:=clRed;
       if (form14.RadioGroup1.ItemIndex=0) and (etag1[(aCol+1),(aRow+1),2]=1) and (etag1[(aCol+1),(aRow+1),1]>0) then brush.Color:=clBlue;
       if (form14.RadioGroup1.ItemIndex=0) and (etag1[(aCol+1),(aRow+1),2]=2) and (etag1[(aCol+1),(aRow+1),1]>0) then brush.Color:=clPurple;
       if (form14.RadioGroup1.ItemIndex=0) and (etag1[(aCol+1),(aRow+1),2]=3) and (etag1[(aCol+1),(aRow+1),1]>0) then brush.Color:=clTeal;
       if (form14.RadioGroup1.ItemIndex=1) and (etag2[(aCol+1),(aRow+1),2]=1) and (etag2[(aCol+1),(aRow+1),1]>0) then brush.Color:=clBlue;
       if (form14.RadioGroup1.ItemIndex=1) and (etag2[(aCol+1),(aRow+1),2]=2) and (etag2[(aCol+1),(aRow+1),1]>0) then brush.Color:=clPurple;
       if (form14.RadioGroup1.ItemIndex=1) and (etag2[(aCol+1),(aRow+1),2]=3) and (etag2[(aCol+1),(aRow+1),1]>0) then brush.Color:=clTeal;
       if ((form14.RadioGroup1.ItemIndex=0) and (etag1[(aCol+1),(aRow+1),2]>0)) or ((form14.RadioGroup1.ItemIndex=1) and (etag2[(aCol+1),(aRow+1),2]>0)) then
          begin
           Font.Color := clWhite;
          end
       else
          begin
           Font.Color := clBlue;
          end;
       fillrect(aRect);
       Rectangle(aRect.left+1,aRect.Top+1,aRect.Right-2,aRect.Bottom-2);
       font.Size:=10;
       TextOut(aRect.Left + 5, aRect.Top + 2, Cells[aCol, aRow]);
     end
  else
     begin
      ////////////////////////////////////////////
      //                 1 ЭТАЖ                 //
      ////////////////////////////////////////////
      // Рисуем место Сидя
     if (form14.RadioGroup1.ItemIndex=0) and (etag1[(aCol+1),(aRow+1),2]=1) and (etag1[(aCol+1),(aRow+1),1]>0) then
        begin
            Brush.Color:=clBlue;
            FillRect(aRect);
            Font.Color := clWhite;
            font.Size:=10;
            TextOut(aRect.Left + 2, aRect.Top + 2, Cells[aCol, aRow]);
        end;
      // Рисуем место Стоя
     if (form14.RadioGroup1.ItemIndex=0) and (etag1[(aCol+1),(aRow+1),2]=2) and (etag1[(aCol+1),(aRow+1),1]>0) then
        begin
            Brush.Color:=clPurple;
            FillRect(aRect);
            Font.Color := clWhite;
            font.Size:=10;
            TextOut(aRect.Left + 2, aRect.Top + 2, Cells[aCol, aRow]);
        end;
           // Рисуем место лежа
     if (form14.RadioGroup1.ItemIndex=0) and (etag1[(aCol+1),(aRow+1),2]=3) and (etag1[(aCol+1),(aRow+1),1]>0) then
        begin
            Brush.Color:=clTeal;
            FillRect(aRect);
            Font.Color := clWhite;
            font.Size:=10;
            TextOut(aRect.Left + 2, aRect.Top + 2, Cells[aCol, aRow]);
        end;
          // Рисуем второе место лежа
     if (form14.RadioGroup1.ItemIndex=0) and (etag1[(aCol+1),(aRow+1),2]=4) and (etag1[(aCol+1),(aRow+1),1]>0) then
        begin
            Brush.Color:=clTeal;
            FillRect(aRect);
            Font.Color := clWhite;
            font.Size:=10;
            TextOut(aRect.Left + 2, aRect.Top + 2, '');
        end;

      ////////////////////////////////////////////
      //                 2 ЭТАЖ                 //
      ////////////////////////////////////////////
     // Рисуем место Сидя
     if (form14.RadioGroup1.ItemIndex=1) and (etag2[(aCol+1),(aRow+1),2]=1) and (etag2[(aCol+1),(aRow+1),1]>0) then
        begin
            Brush.Color:=clBlue;
            FillRect(aRect);
            Font.Color := clWhite;
            font.Size:=10;
            TextOut(aRect.Left + 2, aRect.Top + 2, Cells[aCol, aRow]);
        end;
     // Рисуем место Стоя
     if (form14.RadioGroup1.ItemIndex=1) and (etag2[(aCol+1),(aRow+1),2]=2) and (etag2[(aCol+1),(aRow+1),1]>0) then
        begin
            Brush.Color:=clPurple;
            FillRect(aRect);
            Font.Color := clWhite;
            font.Size:=10;
            TextOut(aRect.Left + 2, aRect.Top + 2, Cells[aCol, aRow]);
        end;
     // Рисуем место лежа
     if (form14.RadioGroup1.ItemIndex=1) and (etag2[(aCol+1),(aRow+1),2]=3) and (etag2[(aCol+1),(aRow+1),1]>0) then
        begin
            Brush.Color:=clTeal;
            FillRect(aRect);
            Font.Color := clWhite;
            font.Size:=10;
            TextOut(aRect.Left + 2, aRect.Top + 2, Cells[aCol, aRow]);
        end;
     // Рисуем второе место лежа
     if (form14.RadioGroup1.ItemIndex=1) and (etag2[(aCol+1),(aRow+1),2]=4) and (etag2[(aCol+1),(aRow+1),1]>0) then
        begin
            Brush.Color:=clTeal;
            FillRect(aRect);
            Font.Color := clWhite;
            font.Size:=10;
            TextOut(aRect.Left + 2, aRect.Top + 2, '');
        end;
     end;
   end;
end;

procedure TForm14.BitBtn4Click(Sender: TObject);
begin
  form14.close;
end;

procedure TForm14.BitBtn3Click(Sender: TObject);
 var
   new_id,n,m,kol:integer;
   tmp_array:array[1..10] of String;
begin
 with FOrm14 do
 begin
  // Проверка заполненных полей
  if (trim(form14.Edit2.text)='') or (trim(form14.Edit3.text)='') then
     begin
       showmessagealt('Запись новых данных невозможна !'+#13+'Заполнены НЕ все обязательные поля с данными !');
       exit;
     end;

     //Сохраняем данные
  //Проверяем на наличие всех данных в полях ввода
  if trim(form14.Edit6.text)='' then
      begin
       showmessagealt('Запись новых данных невозможна !'+#13+'Нет ни одного места в схеме АТС !');
       exit;
      end;

   // Обнуляем массив
    {for n:=1 to 10 do
      begin
        tmp_array[n]:=StringOfChar('0',100);
      end;}

  //Проверяем наличие данных в массивах мест
      kol:=0;
        for n:=1 to 5 do
          begin
           for m:=1 to 25 do
             begin
               tmp_array[n]:=tmp_array[n]+inttostr(etag1[n,m,2])+PADL(inttostr(etag1[n,m,1]),'0',3);
               if form14.SpinEdit1.Value=1 then tmp_array[n+5]:=tmp_array[n+5]+'0000';
               if etag1[n,m,1]>0 then kol:=1;
             end;
          end;
        if kol=0 then
            begin
              showmessagealt('Не заполнены схема расположения посадочных мест на 1 ЭТАЖЕ !'+#13+'Сохранение данных невозможно !');
              exit;
            end;

    if form14.SpinEdit1.Value=2 then
      begin
        kol:=0;
        for n:=1 to 5 do
          begin
           for m:=1 to 25 do
             begin
               tmp_array[n+5]:=tmp_array[n+5]+inttostr(etag2[n,m,2])+PADL(inttostr(etag2[n,m,1]),'0',3);
               if etag2[n,m,1]>0 then kol:=1;
             end;
          end;
        if kol=0 then
            begin
              showmessagealt('Не заполнена схема расположения посадочных мест на 2 ЭТАЖЕ !'+#13+'Сохранение данных невозможно !'+#13+'Для сохранения данных стоит уменьшить количество этажей,'+#13+'или заполнить схему расположения мест для второго этажа !');
              exit;
            end;
      end;

    // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;

     //Определяем текущий id+1
  if flag_edit_ats=1 then
      begin
        form14.ZQuery1.SQL.Clear;
        form14.ZQuery1.SQL.add('SELECT MAX(id) as new_id FROM av_spr_ats;');
        form14.ZQuery1.open;
        new_id:=form14.ZQuery1.FieldByName('new_id').asInteger+1;
      end
  else
      begin
        new_id:=strtoint(trim(form14.Edit1.Text));
      end;


   //Открываем транзакцию
  try
   If not Zconnection1.InTransaction then
      Zconnection1.StartTransaction
   else
     begin
      showmessagealt('Ошибка ! Незавершенная транзакция !'+#13+'Попробуйте снова !');
      ZConnection1.Rollback;
      exit;
     end;



    //Производим запись новых данных
  //Маркируем запись на удачение если режим редактирования
  if flag_edit_ats=2 then
      begin
       form14.ZQuery1.SQL.Clear;
       form14.ZQuery1.SQL.add('UPDATE av_spr_ats SET del=1,createdate=default,id_user='+inttostr(id_user)+' WHERE id='+inttostr(new_id)+' and del=0;');
       form14.ZQuery1.ExecSQL;
      end;
  //Записываем данные
  //1 этаж

  form14.ZQuery1.SQL.Clear;
  form14.ZQuery1.SQL.add('INSERT INTO av_spr_ats(id,createdate,id_user,name,gos,god,type_ats,comfort,m_down,m_up,m_lay,m_down_two,m_up_two,m_lay_two,one_one,one_two,one_three,');
  form14.ZQuery1.SQL.add('one_four,one_five,two_one,two_two,two_three,two_four, two_five,level');
  if flag_edit_ats<2 then form14.ZQuery1.SQL.add(',createdate_first,id_user_first');
  form14.ZQuery1.SQL.add(') VALUES (');
  // Общие значения
  form14.ZQuery1.SQL.add(inttostr(new_id)+',now(),'+inttostr(id_user)+',');
  form14.ZQuery1.SQL.add(QuotedSTR(trim(form14.Edit2.text))+','+QuotedSTR(copy(upperall(trim(form14.Edit3.text)),1,15))+',');
  form14.ZQuery1.SQL.add(QuotedSTR(trim(form14.Edit4.text))+','+inttostr(form14.ComboBox1.ItemIndex)+','+inttostr(form14.ComboBox2.ItemIndex)+',');
  // Карта автобуса
  form14.ZQuery1.SQL.add(form14.Edit7.Text+','+form14.Edit8.Text+','+form14.Edit9.Text+',');
  form14.ZQuery1.SQL.add(form14.Edit10.Text+','+form14.Edit11.Text+','+form14.Edit12.Text+',');
  for n:=1 to 10 do
    begin
      form14.ZQuery1.SQL.add(Quotedstr(trim(tmp_array[n]))+',');
    end;
  form14.ZQuery1.SQL.add(inttostr(form14.SpinEdit1.Value));
  if flag_edit_ats<2 then form14.ZQuery1.SQL.add(',now(),'+inttostr(id_user));
  form14.ZQuery1.SQL.add(');');
  //showmessage(form14.ZQuery1.SQL.text);//$
  form14.ZQuery1.ExecSQL;
  // Фото
  if not(trim(new_foto)='') then
      begin
        form14.ZQuery1.SQL.Clear;
        form14.ZQuery1.SQL.Add('update av_spr_ats set foto=:blob where id='+inttostr(new_id)+' and del=0;');
        form14.ZQuery1.ParamByName('blob').LoadFromFile(new_foto,ftBlob);
        form14.ZQuery1.ExecSQL;
      end;

   // Завершение транзакции
  Zconnection1.Commit;
  ZQuery1.Close;
  Zconnection1.disconnect;
  Close;
 except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
 end;
end;
end;

procedure TForm14.BitBtn1Click(Sender: TObject);
begin
 type_read:=6;
 form7:=Tform7.create(self);
 form7.ShowModal;
 FreeAndNil(form7);
 if not(result_name_full='') then form14.edit2.Text:=result_name_full;
end;

procedure TForm14.BitBtn2Click(Sender: TObject);
begin
   if form14.OpenPictureDialog1.Execute then
     begin
       new_foto:=form14.OpenPictureDialog1.FileName;
       form14.Image2.Picture.LoadFromFile(new_foto);
     end;
end;

procedure TForm14.Button1Click(Sender: TObject);
begin
  form14.StringGrid2.Repaint;
  form14.SetFocus;
end;


procedure TForm14.Edit10Change(Sender: TObject);
begin
  form14.edit14.text:=inttostr(strtoint(form14.edit10.text)+strtoint(form14.edit11.text)+strtoint(form14.edit12.text));
end;

procedure TForm14.Edit11Change(Sender: TObject);
begin
    form14.edit14.text:=inttostr(strtoint(form14.edit10.text)+strtoint(form14.edit11.text)+strtoint(form14.edit12.text));
end;

procedure TForm14.Edit12Change(Sender: TObject);
begin
    form14.edit14.text:=inttostr(strtoint(form14.edit10.text)+strtoint(form14.edit11.text)+strtoint(form14.edit12.text));
end;

procedure TForm14.Edit7Change(Sender: TObject);
begin
  form14.edit13.text:=inttostr(strtoint(form14.edit7.text)+strtoint(form14.edit8.text)+strtoint(form14.edit9.text));
end;

procedure TForm14.Edit8Change(Sender: TObject);
begin
    form14.edit13.text:=inttostr(strtoint(form14.edit7.text)+strtoint(form14.edit8.text)+strtoint(form14.edit9.text));
end;

procedure TForm14.Edit9Change(Sender: TObject);
begin
    form14.edit13.text:=inttostr(strtoint(form14.edit7.text)+strtoint(form14.edit8.text)+strtoint(form14.edit9.text));
end;


end.

