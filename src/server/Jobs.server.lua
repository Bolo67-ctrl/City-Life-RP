local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local jobsFolder = Instance.new("Folder")
jobsFolder.Name = "CityLifeJobs"
jobsFolder.Parent = ReplicatedStorage

local requestJob = Instance.new("RemoteEvent")
requestJob.Name = "RequestJob"
requestJob.Parent = jobsFolder

local jobs = {
    Police = { pay = 100 },
    Mechanic = { pay = 75 },
    Delivery = { pay = 50 },
    Cashier = { pay = 40 }
}

local cooldowns = {}

requestJob.OnServerEvent:Connect(function(player, jobName)
    if typeof(jobName) ~= "string" or not jobs[jobName] then
        return
    end

    local now = os.clock()
    if cooldowns[player] and now - cooldowns[player] < 60 then
        return
    end

    local leaderstats = player:FindFirstChild("leaderstats")
    local cash = leaderstats and leaderstats:FindFirstChild("Cash")

    if not cash then
        return
    end

    cooldowns[player] = now
    cash.Value += jobs[jobName].pay

    print(player.Name .. " worked as " .. jobName .. " and earned $" .. jobs[jobName].pay)
end)

Players.PlayerRemoving:Connect(function(player)
    cooldowns[player] = nil
end)
