--Starving Venemy Dragon
function c511009415.initial_effect(c)
	c:EnableReviveLimit()
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--fusion material
	--aux.AddFusionProcFunRep(c,c511009415.ffilter,2,false)
	c:EnableReviveLimit()
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_FUSION_MATERIAL)
	e0:SetCondition(c511009415.funcon)
	e0:SetOperation(c511009415.funop)
	c:RegisterEffect(e0)
		--no damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001684,0))
	e1:SetType(EFFECT_TYPE_QUICK_O+EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511001684.con)
	e1:SetOperation(c511001684.op)
	c:RegisterEffect(e1)
	--copy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(41209827,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c511009415.copytg)
	e2:SetOperation(c511009415.copyop)
	c:RegisterEffect(e2)
	--pendulum
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(90036274,0))
	e7:SetCategory(CATEGORY_DESTROY)
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e7:SetCode(EVENT_DESTROYED)
	e7:SetProperty(EFFECT_FLAG_DELAY)
	e7:SetCondition(c511009415.pencon)
	e7:SetTarget(c511009415.pentg)
	e7:SetOperation(c511009415.penop)
	c:RegisterEffect(e7)
end

function c511009415.ffilter(c,fc)
	if Card.IsFusionAttribute then
		return c:IsFusionAttribute(ATTRIBUTE_DARK,fc) and c:IsLocation(LOCATION_MZONE) and not c:IsType(TYPE_TOKEN)
	else
		return c:IsAttribute(ATTRIBUTE_DARK) and c:IsLocation(LOCATION_MZONE) and not c:IsType(TYPE_TOKEN)
	end
end
function c511009415.funcon(e,g,gc,chkfnf)
	if g==nil then return false end
	local c=e:GetHandler()
	local chkf=bit.band(chkfnf,0xff)
	local mg=g:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
	if gc then
		if not gc:IsCanBeFusionMaterial(e:GetHandler()) then return false end
		return c511009415.ffilter(gc,c) and mg:IsExists(c511009415.ffilter,1,gc,c) end
	local g1=mg:Filter(c511009415.ffilter,nil,c)
	if chkf~=PLAYER_NONE then
		return g1:FilterCount(Card.IsOnField,nil)~=0 and g1:GetCount()>=2
	else return g1:GetCount()>=2 end
end
function c511009415.funop(e,tp,eg,ep,ev,re,r,rp,gc,chkfnf)
	local chkf=bit.band(chkfnf,0xff)
	local c=e:GetHandler()
	local g=eg:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
	if gc then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local g1=g:FilterSelect(tp,c511009415.ffilter,1,1,gc,c)
		Duel.SetFusionMaterial(g1)
		return
	end
	local sg=g:Filter(c511009415.ffilter,nil,c)
	if chkf==PLAYER_NONE or sg:GetCount()==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local g1=sg:Select(tp,2,2,nil)
		Duel.SetFusionMaterial(g1)
		return
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g1=sg:FilterSelect(tp,Auxiliary.FConditionCheckF,1,1,nil,chkf)
	if 2>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local g2=sg:Select(tp,2-1,2-1,g1:GetFirst())
		g1:Merge(g2)
	end
	Duel.SetFusionMaterial(g1)
end
------------------------------------------------
function c511009415.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetBattleDamage(tp)>0
end
function c511009415.op(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c511009415.damop)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function c511009415.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,0)
end


-------------------------------------------------
function c511009415.copyfilter(c)
	return c:IsFaceup() 
end
function c511009415.copytg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c511009415.copyfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009415.copyfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511009415.copyfilter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c511009415.copyop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsType(TYPE_TOKEN) then
		local code=tc:GetOriginalCodeRule()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1,true)
		
		if not tc:IsType(TYPE_TRAPMONSTER) then
			local cid=c:CopyEffect(code,RESET_EVENT+0x1fe0000,1)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(-500)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
		end
		Duel.Damage(1-tp,500,REASON_EFFECT)
	end
end


function c511009415.pencon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT+REASON_BATTLE)~=0 and e:GetHandler():IsPreviousLocation(LOCATION_MZONE)
end
function c511009415.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) end
end
function c511009415.penop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.CheckLocation(tp,LOCATION_SZONE,6) and not Duel.CheckLocation(tp,LOCATION_SZONE,7) then return false end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end
