--Over Limit (Anime)
--scripted by GameMaster(GM)
function c511005644.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetHintTiming(0,TIMING_BATTLE_START)
	e0:SetCondition(c511005644.con)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_SZONE)
	e1:SetHintTiming(0,TIMING_BATTLE_END)
	e1:SetCountLimit(1)
	e1:SetCost(c511005644.cost)
	e1:SetCondition(c511005644.con)
	e1:SetTarget(c511005644.tg)
	e1:SetOperation(c511005644.op)
	c:RegisterEffect(e1)
end

function c511005644.con(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE) and Duel.GetTurnPlayer()~=tp
end

function c511005644.filter(c,e,tp,tid)
	return c:GetTurnID()==tid and c:IsReason(REASON_BATTLE) and c:IsType(TYPE_NORMAL)
		and c:IsAttackBelow(1000)  and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511005644.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c511005644.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511005644.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp,Duel.GetTurnCount()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,PLAYER_ALL,LOCATION_GRAVE)
end
function c511005644.op(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if loc<=0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511005644.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp,Duel.GetTurnCount())
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
