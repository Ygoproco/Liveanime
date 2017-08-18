--Fortress whale (DOR)
--scripted by GameMaster (GM)
function c511005697.initial_effect(c)
	c:EnableReviveLimit()
	--destroy warrior type at start of battle
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetTarget(c511005697.destg)
	e1:SetOperation(c511005697.desop)
	c:RegisterEffect(e1)
end

function c511005697.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if chk==0 then return bc and bc:IsFaceup() and bc:IsRace(RACE_WARRIOR) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
end

function c511005697.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc:IsRelateToBattle() then
		Duel.Destroy(bc,REASON_EFFECT)
	end
end
