local iup = require("iuplua")

local buffer = ""
local filePath = "example.txt"

-- Declare textArea and fileNameField here so they can be used in loadTextFromFile
local textArea
local fileNameField

-- Function to load text from a file
local function loadTextFromFile(fileName)
  if fileName and fileName ~= "" then
    local file = io.open(fileName, "r")
    if file then
      buffer = file:read("*all")
      file:close()
      print("File loaded from " .. fileName)
      textArea.value = buffer
      fileNameField.value = fileName
    else
      print("Error opening file")
    end
  else
    print("Invalid file name")
  end
end

-- Function to save text to a file
local function saveTextToFile(fileName)
  if fileName and fileName ~= "" then
    local file = io.open(fileName, "w")
    if file then
      file:write(buffer)
      file:close()
      print("File saved to " .. fileName)
    else
      print("Error saving file")
    end
  else
    print("Invalid file name")
  end
end

-- Create a multiline text box
textArea = iup.text{
  multiline = "YES",
  expand = "YES",
  value = buffer,
  font = "Courier, 14",
  action = function(self, c, after)
    buffer = self.value
    return iup.DEFAULT
  end
}

-- Create a text field for the file name
fileNameField = iup.text{
  value = filePath,
  expand = "HORIZONTAL"
}

-- Create a button to save the text
local saveButton = iup.button{
  title = "Save",
  action = function()
    saveTextToFile(fileNameField.value)
  end
}

-- Create a button to open a text file
local openButton = iup.button{
  title = "Open",
  action = function()
    loadTextFromFile(fileNameField.value)
  end
}

-- Create a horizontal box for the buttons and file name field
local controlBox = iup.hbox{
  openButton,
  saveButton,
  fileNameField
}

-- Create the main dialog
local mainDialog = iup.dialog{
  iup.vbox{
    controlBox,
    textArea
  },
  title = "Lua Notepad",
  size = "HALFxHALF"
}

-- Show the dialog
mainDialog:show()
iup.MainLoop()