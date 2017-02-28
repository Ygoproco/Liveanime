--Abyss Actor's Vacancy
-- [Trap Card]
function c511008503.initial_effect(c)
	-- [Effect e1]: Activate this card
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511008503.activate)
	c:RegisterEffect(e1)


	
end


--- ################### <Effect e1> ################### --- 

function c511008503.activate(e,tp,eg,ep,ev,re,r,rp)
	-- Activate: Select Level and save the value in this card.
	local arrayOfLevels={}
	local min_level = 1
	local max_level = 12
	local i = 1
	for level=min_level,max_level do 
		arrayOfLevels[i]= level
		i=i+1
	end
	arrayOfLevels[i]=nil
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(511008503,0))
	local selectedLevel = Duel.AnnounceNumber(tp,table.unpack(arrayOfLevels))
   

	-- [Effect e2]: Monster of Select Level, cannot be used like XYZ material
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE) -- Monsters in (my field, opponent field)
	e2:SetTarget(c511008503.target)
	e2:SetLabel(selectedLevel)
	e2:SetValue(1)
	e:GetHandler():RegisterEffect(e2)

	-- [Effect e3]: Like e2, but the monsters cannot be used like Syncro material
	local e3 = e2:Clone()
	e3:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e:GetHandler():RegisterEffect(e3)

	-- [Effect e4]: Like e2, but the monsters cannot be used like Fusion material
	local e4 = e2:Clone()
	e4:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e:GetHandler():RegisterEffect(e4)
	
	-- [Effect e5]: Like e2, but the monsters cannot be used for tribute summon
	local e5 = e2:Clone()
	e5:SetCode(EFFECT_UNRELEASABLE_SUM)
	e:GetHandler():RegisterEffect(e5)
 
end

--- ################### </Effect e1> ################### --- 

--- ################### <Effect e2> ################### --- 

function c511008503.target(e,c)
	return c:IsFaceup() and c:GetLevel()==e:GetLabel()
end

--- ################### </Effect e2> ################### --- 