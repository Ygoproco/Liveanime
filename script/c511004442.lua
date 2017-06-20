--Cubic Karma (movie)
--fixed by MLD
function c511004442.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511004442.target)
	e1:SetOperation(c511004442.activate)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511004442.spcon)
	e2:SetCost(c511004442.spcost)
	e2:SetOperation(c511004442.spop)
	c:RegisterEffect(e2)
end
function c511004442.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xe3)
end
function c511004442.target(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511004442.filter,tp,LOCATION_MZONE,0,1,nil) 
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,1,nil,15610297) end
end
function c511004442.activate(e,tp,eg,ev,ep,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local mg=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_HAND,0,nil,15610297)
	if mg:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,c511004442.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		Duel.Overlay(tc,mg)
	end
end
function c511004442.cfilter(c,tp)
	return c:IsSetCard(0x10e3) or c:IsCode(15610297)
end
function c511004442.spcon(e,tp,eg,ev,ep,re,r,rp)
	if not re then return false end
	local rc=re:GetHandler()
	return Duel.GetTurnPlayer()~=tp and eg:IsExists(c511004442.cfilter,1,nil) and rc:IsType(TYPE_MONSTER) and rc:IsSetCard(0xe3)
end
function c511004442.spcost(e,tp,eg,ev,ep,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() end
	Duel.SendtoGrave(c,REASON_COST)
end
function c511004442.spop(e,tp,eg,ev,ep,re,r,rp)
	Duel.SetLP(1-tp,math.floor(Duel.GetLP(1-tp)/2))
end
