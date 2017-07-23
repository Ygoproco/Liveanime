--Goddess of Whim (DOR)
--scripted by GameMaster(GM)
function c511005658.initial_effect(c)
   --atk/def change
    local e1=Effect.CreateEffect(c)
    e1:SetType( EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e1:SetRange(LOCATION_MZONE)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_SINGLE_RANGE)
    e1:SetCode(EVENT_ATTACK_ANNOUNCE)
    e1:SetLabel(1)
	e1:SetTarget(c511005658.target)
    e1:SetOperation(c511005658.op)
    c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	c:RegisterEffect(e2)
end

function c511005658.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end

function c511005658.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local opt=Duel.SelectOption(tp,60,61)
		local coin=Duel.TossCoin(tp,1)
	local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
		if opt==coin then
			e1:SetValue(-1500)
		elseif opt~=coin then
			e1:SetValue(1500)
		end
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		c:RegisterEffect(e2)
	end
end

