--Abyss Actor's Vacancy
function c511008503.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511008503.activate)
	c:RegisterEffect(e1)	
end
function c511008503.activate(e,tp,eg,ep,ev,re,r,rp)
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
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c511008503.target)
	e2:SetLabel(selectedLevel)
	e2:SetValue(1)
	e:GetHandler():RegisterEffect(e2)
	local e3 = e2:Clone()
	e3:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e:GetHandler():RegisterEffect(e3)
	local e4 = e2:Clone()
	e4:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e:GetHandler():RegisterEffect(e4)
	local e5 = e2:Clone()
	e5:SetCode(EFFECT_UNRELEASABLE_SUM)
	e:GetHandler():RegisterEffect(e5)
end
function c511008503.target(e,c)
	return c:IsFaceup() and c:GetLevel()==e:GetLabel() and not (c:IsType(TYPE_XYZ) and not (c:IsHasEffect(EFFECT_RANK_LEVEL) or c:IsHasEffect(EFFECT_RANK_LEVEL_S)))
end
