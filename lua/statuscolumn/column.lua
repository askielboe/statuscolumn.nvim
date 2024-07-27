local column = {}

column.linenumber = function()
  if vim.v.relnum == 2 then
    return "%#ColumnTertiary#" .. vim.v.lnum
  end
  if vim.v.relnum == 1 then
    return "%#ColumnSecondary#" .. vim.v.lnum
  end
  if vim.v.relnum == 0 then
    return "%#ColumnCurrent#" .. vim.v.lnum
  end
  return "%#ColumnDim#" .. vim.v.lnum
end

column.border = function()
  if vim.v.relnum == 2 then
    return "%#ColumnTertiary#│ "
  end
  if vim.v.relnum == 1 then
    return "%#ColumnSecondary#│ "
  end
  if vim.v.relnum == 0 then
    return "%#ColumnCurrent#│ "
  end
  return "%#ColumnDim#│ "
end

column.mark = function()
  local marks = vim.fn.getmarklist(".") -- Get marks for the current buffer
  local mark_str = ""

  for _, mark in ipairs(marks) do
    if mark.mark:match("^[a-zA-Z]$") then -- Filter out only letter marks
      mark_str = mark_str .. mark.mark .. " "
    end
  end

  return mark_str
end

column.bootstrap = function()
  local result = ""

  result = column.mark() .. " " .. column.linenumber() .. " " .. column.border()

  -- Include marks in the statusline
  local marks = vim.fn.getmarklist(".")

  return "%s%=" .. result
end

return column
