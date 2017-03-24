--アルカナフォースＸＩＩ－ＴＨＥ ＨＡＮＧＥＤ ＭＡＮ
function c100000106.initial_effect(c)
	--coin
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000106,0))
	e1:SetCategory(CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c100000106.cointg)
	e1:SetOperation(c100000106.coinop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c100000106.cointg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c100000106.coinop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local res=0
	if c:IsHasEffect(73206827) then
		res=1-Duel.SelectOption(tp,60,61)
	else res=Duel.TossCoin(tp,1) end
	c100000106.arcanareg(c,res)
end
function c100000106.arcanareg(c,coin)
	--coin effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000106,1))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c100000106.descon)
	e1:SetTarget(c100000106.destg)
	e1:SetOperation(c100000106.desop)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	c:RegisterFlagEffect(36690018,RESET_EVENT+0x1fe0000,EFFECT_FLAG_CLIENT_HINT,1,coin,63-coin)
end
function c100000106.descon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c100000106.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local heads=e:GetHandler():GetFlagEffectLabel(36690018)==1
	if chkc then 
		if not chkc:IsLocation(LOCATION_MZONE) or chkc:IsFacedown() then return false end
		if heads then return chkc:IsControler(tp)
		else return chkc:IsControler(1-tp) end
	end
	if chk==0 then return true end
	local gp
	local g
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	if heads then
		g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
		gp=tp
	else
		g=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
		gp=1-tp
	end
	if g:GetCount()>0 then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,gp,g:GetFirst():GetAttack())
	end
	Duel.SetTargetParam(e:GetHandler():GetFlagEffectLabel(36690018))
end
function c100000106.desop(e,tp,eg,ep,ev,re,r,rp)
	local heads=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)==1
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)>0 then
		if heads then
			Duel.Damage(tp,tc:GetAttack(),REASON_EFFECT)
		else
			Duel.Damage(1-tp,tc:GetAttack(),REASON_EFFECT)
		end
	end
end
