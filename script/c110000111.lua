--Burning Knuckle
function c110000111.initial_effect(c)
	--gains 200 ATK for each armor monster
    local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c110000111.atkup)
	c:RegisterEffect(e1)
    local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetCondition(c110000111.latkcon)
	e2:SetTarget(c110000111.latktg)
	e2:SetOperation(c110000111.latkop)
	c:RegisterEffect(e2)
	if not c110000111.global_check then
		c110000111.global_check=true
		if Duel.GetFlagEffect(0,110000104)==0 and Duel.GetFlagEffect(1,110000104)==0 then
			Duel.RegisterFlagEffect(0,110000104,0,0,1)
			Duel.RegisterFlagEffect(1,110000104,0,0,1)
			--cannot attack
			local ge1=Effect.CreateEffect(c)
			ge1:SetType(EFFECT_TYPE_FIELD)
			ge1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			ge1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
			ge1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
			ge1:SetCondition(c110000111.atkcon)
			ge1:SetTarget(c110000111.atktg)
			Duel.RegisterEffect(ge1,0)
			--check
			local ge2=Effect.CreateEffect(c)
			ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			ge2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			ge2:SetCode(EVENT_ATTACK_ANNOUNCE)
			ge2:SetOperation(c110000111.checkop)
			ge2:SetLabelObject(ge1)
			Duel.RegisterEffect(ge2,0)
			--change attack target
			local ge3=Effect.CreateEffect(c)
			ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			ge3:SetCode(EVENT_BE_BATTLE_TARGET)
			ge3:SetCondition(c110000111.atcon)
			ge3:SetOperation(c110000111.atop)
			Duel.RegisterEffect(ge3,0)
			local ge4=ge3:Clone()
			Duel.RegisterEffect(ge4,1)
		end
	end
end
function c110000111.atkcon(e)
	return Duel.GetFlagEffect(e:GetHandlerPlayer(),110000103)~=0 and Duel.GetFlagEffect(1-e:GetHandlerPlayer(),110000103)~=0
end
function c110000111.atktg(e,c)
	return c:GetFieldID()~=e:GetLabel() and c:IsType(0x10000000)
end
function c110000111.checkop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if not a:IsType(0x10000000) then return end
	if Duel.GetFlagEffect(tp,110000103)~=0 and Duel.GetFlagEffect(1-tp,110000103)~=0 then return end
	local fid=eg:GetFirst():GetFieldID()
	Duel.RegisterFlagEffect(tp,110000103,RESET_PHASE+PHASE_END,0,1)
	Duel.RegisterFlagEffect(1-tp,110000103,RESET_PHASE+PHASE_END,0,1)
	e:GetLabelObject():SetLabel(fid)
end
function c110000111.atcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return at:IsFaceup() and at:IsControler(tp) and at:IsType(0x10000000)
end
function c110000111.filter(c)
	return c:IsFaceup() and c:IsType(0x10000000)
end
function c110000111.atop(e,tp,eg,ep,ev,re,r,rp)
	local atg=Duel.GetAttacker():GetAttackableTarget()
	local d=Duel.GetAttackTarget()
	if atg:IsExists(c110000111.filter,1,d) and Duel.SelectYesNo(tp,aux.Stringid(21558682,0)) then
		local g=atg:FilterSelect(tp,c110000111.filter,1,1,d)
		Duel.HintSelection(g)
		Duel.ChangeAttackTarget(g:GetFirst())
	end
end
function c110000111.atkup(e,c)
	return Duel.GetMatchingGroupCount(c110000111.filter,c:GetControler(),LOCATION_MZONE,0,nil)*200
end
function c110000111.latkcon(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return e:GetHandler()==Duel.GetAttacker() and e:GetHandler():IsLocation(LOCATION_GRAVE) and d and d:IsControler(1-tp)
end
function c110000111.latktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c110000111.latkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(-e:GetHandler():GetAttack())
		tc:RegisterEffect(e1)
	end
end
