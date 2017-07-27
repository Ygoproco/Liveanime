--The Drdek (DOR)
--scripted by GameMaster (GM)
function c511005675.initial_effect(c)
	--change all monster to attack pos
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c511005675.operation)
	c:RegisterEffect(e1)
end

function c511005675.filter(c)
	return c:IsDefensePos() and c:IsFaceup()
end

function c511005675.filter2(c)
	return c:IsDefensePos() and c:IsFacedown()
end

function c511005675.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingMatchingCard(c511005675.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) or Duel.IsExistingMatchingCard(c511005675.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c511005675.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c511005675.target(e,c)
	return c:IsType(TYPE_MONSTER) and c:IsDefensePos() 
end

function c511005675.operation(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(c511005675.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
if g:GetCount()>0 then 
Duel.ChangePosition(g,POS_FACEUP_ATTACK)
end
local g=Duel.GetMatchingGroup(c511005675.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
if g:GetCount()>0 then 
Duel.ChangePosition(g,POS_FACEDOWN_ATTACK)
end
end
