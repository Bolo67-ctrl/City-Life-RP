local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local requestJob = ReplicatedStorage:WaitForChild("CityLifeJobs"):WaitForChild("RequestJob")

local gui = Instance.new("ScreenGui")
gui.Name = "CityLifeJobMenu"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local openButton = Instance.new("TextButton")
openButton.Size = UDim2.fromOffset(150, 45)
openButton.Position = UDim2.new(0, 20, 0.5, -22)
openButton.Text = "JOBS"
openButton.TextScaled = true
openButton.Parent = gui

local panel = Instance.new("Frame")
panel.Size = UDim2.fromOffset(260, 300)
panel.Position = UDim2.new(0.5, -130, 0.5, -150)
panel.Visible = false
panel.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.Text = "CITY LIFE RP JOBS"
title.TextScaled = true
title.Parent = panel

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.fromOffset(35, 35)
closeButton.Position = UDim2.new(1, -40, 0, 5)
closeButton.Text = "X"
closeButton.Parent = panel

openButton.Activated:Connect(function()
    panel.Visible = not panel.Visible
end)

closeButton.Activated:Connect(function()
    panel.Visible = false
end)

local jobList = {
    {name = "Police", pay = 100},
    {name = "Mechanic", pay = 75},
    {name = "Delivery", pay = 50},
    {name = "Cashier", pay = 40}
}

for index, job in ipairs(jobList) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 45)
    button.Position = UDim2.fromOffset(10, 55 + (index - 1) * 55)
    button.Text = job.name .. "  -  Earn $" .. job.pay
    button.TextScaled = true
    button.Parent = panel

    button.Activated:Connect(function()
        requestJob:FireServer(job.name)
        title.Text = "Requested: " .. job.name
        panel.Visible = false
    end)
end
