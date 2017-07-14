function importCSVFromGoogleDrive(mode, filename) {
  
  if (DriveApp.getFilesByName("est_cards_" + mode + "-" + filename + ".csv").hasNext()){
  var file = DriveApp.getFilesByName("est_cards_" + mode + "-" + filename + ".csv").next();
  var csvData = Utilities.parseCsv(file.getBlob().getDataAsString(), ';');
  var sheet = SpreadsheetApp.getActiveSpreadsheet().insertSheet(mode + "-" + filename);
  sheet.getRange(1, 1, csvData.length, csvData[0].length).setValues(csvData);

  replaceInSheet(sheet, "0", "1")


  sheet.insertColumnAfter(2);
  var cell = sheet.getRange(2,3)

  var formulas = [
   ["=CONCATENATE(INDEX(SPLIT(B2, \"-\"),1,1),A2)"]
 ];

  cell.setFormulas(formulas);

  cell.copyTo(sheet.getRange(3, 3, sheet.getLastRow() - 2));

  cell = sheet.getRange(1,4)
  cell.setValue(mode + " in lower")
  cell = sheet.getRange(1,5)
  cell.setValue(mode + " in upper")
  cell = sheet.getRange(1,6)
  cell.setValue(mode + " in conf")
  cell = sheet.getRange(1,7)
  cell.setValue(mode + " out lower")
  cell = sheet.getRange(1,8)
  cell.setValue(mode + " out upper")
  cell = sheet.getRange(1,9)
  cell.setValue(mode + " out conf")

  }

}

function importCSVFromGoogleDriveThreeTimes(filename, delete_files, load_images, image_names) {

  importCSVFromGoogleDrive("baseline", filename);
  importCSVFromGoogleDrive("training", filename);
  importCSVFromGoogleDrive("validation", filename);


  var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName("baseline" + "-" + filename);
  sheet.insertColumnAfter(5);
  sheet.insertColumnAfter(5);
  sheet.insertColumnAfter(10);
  sheet.insertColumnAfter(10);

  var sheet2 = SpreadsheetApp.getActiveSpreadsheet().getSheetByName("validation" + "-" + filename);

  var cell = sheet2.getRange(1, 4, sheet.getLastRow())
  cell.copyTo(sheet.getRange(1, 6, sheet.getLastRow()));
  cell = sheet2.getRange(1, 5, sheet.getLastRow())
  cell.copyTo(sheet.getRange(1, 7, sheet.getLastRow()));
  cell = sheet2.getRange(1, 7, sheet.getLastRow())
  cell.copyTo(sheet.getRange(1, 11, sheet.getLastRow()));
  cell = sheet2.getRange(1, 8, sheet.getLastRow())
  cell.copyTo(sheet.getRange(1, 12, sheet.getLastRow()));

  sheet.insertColumnAfter(5);
  cell = sheet.getRange(1,6)
  cell.setValue("act in")
  cell = sheet.getRange(2,6)
  var formulas = [
   ["=FILTER(UNIQUE(FILTER('act_cards_July13-23uhr10'!D$2:D$1120, 'act_cards_July13-23uhr10'!C$2:C$1120 = C2)), ABS(UNIQUE(FILTER('act_cards_July13-23uhr10'!D$2:D$1120, 'act_cards_July13-23uhr10'!C$2:C$1120 = C2)) - E2) =MIN(ABS(UNIQUE(FILTER('act_cards_July13-23uhr10'!D$2:D$1120, 'act_cards_July13-23uhr10'!C$2:C$1120 = C2)) - E2)))"]
 ];
  cell.setFormulas(formulas);
  cell.copyTo(sheet.getRange(2, 6, sheet.getLastRow() - 1));

  sheet.insertColumnAfter(11);
  cell = sheet.getRange(1,12)
  cell.setValue("act out")
  cell = sheet.getRange(2,12)
  var formulas = [
   ["=FILTER(UNIQUE(FILTER('act_cards_July13-23uhr10'!F$2:F$1120, 'act_cards_July13-23uhr10'!C$2:C$1120 = C2)), ABS(UNIQUE(FILTER('act_cards_July13-23uhr10'!F$2:F$1120, 'act_cards_July13-23uhr10'!C$2:C$1120 = C2)) - K2) =MIN(ABS(UNIQUE(FILTER('act_cards_July13-23uhr10'!F$2:F$1120, 'act_cards_July13-23uhr10'!C$2:C$1120 = C2)) - K2)))"]
 ];
  cell.setFormulas(formulas);
  cell.copyTo(sheet.getRange(2, 12, sheet.getLastRow() - 1));

  cell = sheet.getRange(1,16)
  cell.setValue("baseline select lower")
  cell = sheet.getRange(2,16)
  var formulas = [
   ["=J2/D2"]
 ];
  cell.setFormulas(formulas);
  cell.copyTo(sheet.getRange(2, 16, sheet.getLastRow() - 1));

  cell = sheet.getRange(1,17)
  cell.setValue("baseline select upper")
  cell = sheet.getRange(2,17)
  var formulas = [
   ["=K2/E2"]
 ];
  cell.setFormulas(formulas);
  cell.copyTo(sheet.getRange(2, 17, sheet.getLastRow() - 1));

 cell = sheet.getRange(1,18)
  cell.setValue("est select lower")
  cell = sheet.getRange(2,18)
  var formulas = [
   ["=M2/G2"]
 ];
  cell.setFormulas(formulas);
  cell.copyTo(sheet.getRange(2, 18, sheet.getLastRow() - 1));

 cell = sheet.getRange(1,19)
  cell.setValue("est select upper")
  cell = sheet.getRange(2,19)
  var formulas = [
   ["=N2/H2"]
 ];
  cell.setFormulas(formulas);
  cell.copyTo(sheet.getRange(2, 19, sheet.getLastRow() - 1));

 cell = sheet.getRange(1,20)
  cell.setValue("act select")
  cell = sheet.getRange(2,20)
  var formulas = [
   ["=L2/F2"]
 ];
  cell.setFormulas(formulas);
  cell.copyTo(sheet.getRange(2, 20, sheet.getLastRow() - 1));

  cell = sheet.getRange(1,21)
  cell.setValue("error diff")
  cell = sheet.getRange(2,21)
  var formulas = [
   ["=(ABS(T2-P2)+ABS(T2-Q2))-(ABS(T2-R2)+ABS(T2-S2))"]
 ];
  cell.setFormulas(formulas);
  cell.copyTo(sheet.getRange(2, 21, sheet.getLastRow() - 1));


  cell = sheet.getRange(1,22)
  cell.setValue("if error")
  cell = sheet.getRange(2,22)
  var formulas = [
   ["=IFERROR(U2, \"\")"]
 ];
  cell.setFormulas(formulas);
  cell.copyTo(sheet.getRange(2, 22, sheet.getLastRow() - 1));


  var sheet3 = SpreadsheetApp.getActiveSpreadsheet().getSheetByName("act_cards_July13-23uhr10");
  var range = sheet3.getRange(4, 10)
  range.copyFormatToRange(sheet, 22, 22, 2, sheet.getLastRow() - 1)

  var sheet_dashboard = SpreadsheetApp.getActiveSpreadsheet().getSheetByName("Dashboard");


 if (load_images){

 cell = sheet.getRange(1,23)
  cell.setValue("split")
  cell = sheet.getRange(2,23)
  var formulas = [
   ["=INDEX(SPLIT(B2, \"-\"),1,1)"]
 ];
  cell.setFormulas(formulas);
  cell.copyTo(sheet.getRange(2, 23, sheet.getLastRow() - 1));

  cell = sheet.getRange(2, 1, sheet.getLastRow() - 1, sheet.getLastColumn());
  cell.sort(23)

  cell = sheet.getRange(2, 23, sheet.getLastRow() - 1);
  var valuesp = cell.getValues();

  var values = []

  for(var i=0 ; i < valuesp.length ; i++) {
      values.push(valuesp[i][0]);
  }

  function onlyUnique(value, index, self) {
    return self.indexOf(value) === index;
  }

  var unique = values.filter( onlyUnique );

  for(var i=0 ; i < unique.length ; i++) {
    console.log(i)
    console.log(unique.length)

      var rng = sheet.getRange(2, 23, sheet.getLastRow() - 1, 2);
      var data = rng.getValues();
      var search = unique[i];

      var found_yet = false;

      for (var j=0; j < data.length; j++) {
        if (found_yet == false){
          if (data[j][0] == search) {
            found_yet = true
            data[j][1] = "Set found cell to this";
            getImage(search, filename, j+1, 25, image_names);
            //rng.setValues(data);
          }
        }
      }

  }

 }



  cell = sheet_dashboard.getRange(sheet_dashboard.getLastRow() + 1,1)
  cell.setValue(filename);

  var last_row = sheet.getLastRow();

  cell = sheet.getRange(last_row + 2,22)
  var formulas = [
   ["=COUNTIF(V2:V" + last_row + ",\">0\")"]
  ];
  cell.setFormulas(formulas);
  cell.copyValuesToRange(sheet_dashboard, 2, 2, sheet_dashboard.getLastRow(), sheet_dashboard.getLastRow())

  cell = sheet.getRange(last_row + 3,22)
  var formulas = [
   ["=COUNTIF(V2:V" + last_row + ",\"<0\")"]
  ];
  cell.setFormulas(formulas);
  cell.copyValuesToRange(sheet_dashboard, 3, 3, sheet_dashboard.getLastRow(), sheet_dashboard.getLastRow())

  cell = sheet.getRange(last_row + 4,22)
  var formulas = [
   ["=MEDIAN(V2:V" + last_row + ")"]
  ];
  cell.setFormulas(formulas);
  cell.copyValuesToRange(sheet_dashboard, 7, 7, sheet_dashboard.getLastRow(), sheet_dashboard.getLastRow())

  cell = sheet.getRange(last_row + 5,22)
  var formulas = [
   ["=AVERAGE(V2:V" + last_row + ")"]
  ];
  cell.setFormulas(formulas);
  cell.copyValuesToRange(sheet_dashboard, 8, 8, sheet_dashboard.getLastRow(), sheet_dashboard.getLastRow())

  cell = sheet.getRange(last_row + 6,22)
  var formulas = [
   ["=COUNTIF(V2:V" + last_row + ",\"=0\")"]
  ];
  cell.setFormulas(formulas);
  cell.copyValuesToRange(sheet_dashboard, 4, 4, sheet_dashboard.getLastRow(), sheet_dashboard.getLastRow())

 if (delete_files){
 var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName("baseline" + "-" + filename);
 SpreadsheetApp.getActiveSpreadsheet().deleteSheet(sheet);
 }

 var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName("training" + "-" + filename);
 SpreadsheetApp.getActiveSpreadsheet().deleteSheet(sheet);

 var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName("validation" + "-" + filename);
 SpreadsheetApp.getActiveSpreadsheet().deleteSheet(sheet);
}

function getImage(op_name, data_id, row, column, image_names) {
  if (DriveApp.getFilesByName(image_names + "-" + op_name + ".png").hasNext()){
  var file = DriveApp.getFilesByName(image_names + "-" + op_name + ".png").next();
  var id = file.getId();
  var gfile = DriveApp.getFileById(id);
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName("baseline-" + data_id);
  sheet.insertImage(gfile.getThumbnail(), column, row);
  }
}

function replaceInSheet(sheet, to_replace, replace_with) {
  //get the current data range values as an array
  var values = sheet.getDataRange().getValues();

  //loop over the rows in the array
  for(var row in values){

    //use Array.map to execute a replace call on each of the cells in the row.
    var replaced_values = values[row].map(function(original_value){
      if (original_value.toString() == to_replace){
        return original_value.toString().replace(to_replace,replace_with);
      } else {
        return original_value.toString();
      }
    });

    //replace the original row values with the replaced values
    values[row] = replaced_values;
  }

  //write the updated values to the sheet
  sheet.getDataRange().setValues(values);
}


function runthis(){
  importCSVFromGoogleDriveThreeTimes("July14-12uhr00", delete_files=false, load_images=true, image_names="linear_training_validation-July13-23uhr10");
}
