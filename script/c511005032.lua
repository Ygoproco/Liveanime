--Line World
--Scripted by Sahim
function c511005032.initial_effect(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  c:RegisterEffect(e1)
  --Line Monster 500 atk
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_FIELD)
  e2:SetCode(EFFECT_UPDATE_ATTACK)
  e2:SetRange(LOCATION_FZONE)
  e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
  e2:SetTarget(c511005032.tg)
  e2:SetValue(500)
  c:RegisterEffect(e2)
	--destroyed to opp grave
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetTarget(c511005032.reptg)
	e3:SetValue(1)
	c:RegisterEffect(e3)
  
	if not c511005032.global_check then
		c511005032.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511005032.archchk)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511005032.archchk(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(0,420)==0 then 
		Duel.CreateToken(tp,420)
		Duel.CreateToken(1-tp,420)
		Duel.RegisterFlagEffect(0,420,0,0,0)
	end
end

function c511005032.tg(e,c)
  return c420.IsLineMonster(c)
end
function c511005032.filter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsControler(1-tp)
end
function c511005032.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end

	if eg:IsExists(c511005032.filter,1,nil,rp) then
		local c=eg:GetFirst():GetReasonCard()
		if not c then c=re:GetHandler() end
		Duel.RaiseEvent(c, 511005032, e, r, rp, ep, ev)
	end
	
	Duel.SendtoGrave(eg,REASON_EFFECT,rp)
	return true
end