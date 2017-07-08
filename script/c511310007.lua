--Torrential Tribute (Anime)
--AlphaKretin
function c511310007.initial_effect(c)
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c511310007.target)
	e1:SetOperation(c511310007.activate)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	e2:SetTarget(c511310007.target)
	e2:SetOperation(c511310007.activate)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_ACTIVATE)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetTarget(c511310007.target)
	e3:SetOperation(c511310007.activate)
	c:RegisterEffect(e3)
end
function c511310007(c,tp,ep)
	return ep~=tp
end
function c511310007.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511310007.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c511310007.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511310007.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511310007.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
