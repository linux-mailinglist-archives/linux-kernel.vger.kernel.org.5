Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21687B32FB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjI2M7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjI2M7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:59:41 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551E51A4;
        Fri, 29 Sep 2023 05:59:39 -0700 (PDT)
Received: from [192.168.0.66] ([85.168.41.102]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MekvT-1rKS2k0pe9-00aocR; Fri, 29 Sep 2023 14:59:27 +0200
Message-ID: <eab8e74b-61e0-4ef4-bfb3-751047d879bc@green-communications.fr>
Date:   Fri, 29 Sep 2023 14:59:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
References: <20230726091704.25795-1-nbd@nbd.name>
 <12289744.O9o76ZdvQC@natalenko.name>
Content-Language: en-US
From:   Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Subject: Re: [PATCH 1/3] wifi: mt76: mt7915: remove VHT160 capability on
 MT7915
In-Reply-To: <12289744.O9o76ZdvQC@natalenko.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2HYlcBW+86/1S82W+ZndkYNpC8Tl20HTFU5mCcNv0DKMhs7q22t
 4+tR+DFMJpLemjPKdl6/JFb2QaG9h1ZZjWSpcSlRPbJTFQ4a6ZEfctaIyCwAlfKCZGmrK53
 o25ndXAg+mORuMKS+aNhtzJUboxhNwcyXGlpGgW56WNsLUUGdx92HB1Al6/Q45kPWYrh9FC
 tzFkpeWa9j6CW0+lhgDDg==
UI-OutboundReport: notjunk:1;M01:P0:KryucuwLa2g=;c17xto/1dxvPCftMFcBs8uTQcpl
 YpacGxpRyXWbEhnqZ9XfvUBs3t204lSp5GVGvhoEJCPvCnLLd2mQyymXIsYPsV0oty5G+JClO
 VRA10Ynxq9pBO/RYvoYQsDJbMkXQX7jJUODkqVVL/5n761HanlhM/TlzfPIgrxHDG0VBPazk3
 Z5Hx7orgKCKcsP/2LQxj8U0RUh7gmOtLtck6+pDvkTUpXaADtjXaQyzEu16tX3x9O3pVDzanC
 tbLmS8oOBm/Glz7UO5/a6Z3kJJwZkCnDBwLJkqIJYJnTbjN6svJq3ZVWuPKD9eEPrCe5SMDfq
 FcEgARa3XimtdZnsS2ySQeO9y3GTwJAP2VzjnHy191FZnoJOfYyQPlbB4VITiAnkRKfnFE8gp
 MPRcZu7LtcBzbnlm9LadPKWz++Xh9/imtQDCOdohsZB3kNADf9JxWOZioyAUYOKzQiqZf0xDc
 I9hPPd/kElecVQliTS/EAMm1hLZvHgaDy5XvTOTTVuLL1p8lVf20W0vmZeBbwuHbubzrP3jNf
 OSoAr/Y7raevvTDWGv5Utji3cWM7Erb/mLsQ3/eZyE0H4mf0oDvX5SJdyvhTyl34cWjjKPRXI
 UP9teDbaQozp1IrNTL+zPyvl4drsrRaJjDUr+B10BtakMMnJH3DWoOpgpvTmYBksiRW+id62Y
 J7Tvl97zn2nZeR12FyLIEMjrFIYTsvoRLm4OdytfWSoNK9Lp9V+aysWn7Kk99/UDZqbhDqC+2
 WmBDS8Wr1b8FRmBkS8uzX2oFnZIMkKSlt3pRIbMo/GqLMCuqq2o/pv8gmpHAUfNtwqJYGjUas
 zLYD6JcudylK3us37weRHeIMGyaNpDPM9FZ5GHpnBnqkQLoQ6pBvWhmCfAri28JM3Hm7BqR7X
 CYkIESnFeA1hpmA==
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2023 07:02, Oleksandr Natalenko wrote:
> Hello Felix.
> 
> On středa 26. července 2023 11:17:02 CEST Felix Fietkau wrote:
>> The IEEE80211_VHT_CAP_EXT_NSS_BW value already indicates support for half-NSS
>> 160 MHz support, so it is wrong to also advertise full 160 MHz support.
>>
>> Fixes: c2f73eacee3b ("wifi: mt76: mt7915: add back 160MHz channel width support for MT7915")
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>   drivers/net/wireless/mediatek/mt76/mt7915/init.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
>> index ee976657bfc3..78552f10b377 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
>> @@ -414,7 +414,6 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
>>   			if (!dev->dbdc_support)
>>   				vht_cap->cap |=
>>   					IEEE80211_VHT_CAP_SHORT_GI_160 |
>> -					IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ |
>>   					FIELD_PREP(IEEE80211_VHT_CAP_EXT_NSS_BW_MASK, 1);
>>   		} else {
>>   			vht_cap->cap |=
>>
> 
> For some reason this got backported into the stable kernel:
> 
> ```
> $ git log --oneline v6.5.2..v6.5.4 -- drivers/net/wireless/mediatek/mt76/mt7915/
> c43017fbebcc3 wifi: mt76: mt7915: fix power-limits while chan_switch
> edb1afe042c74 wifi: mt76: mt7915: fix tlv length of mt7915_mcu_get_chan_mib_info
> 9ec0dec0baea3 wifi: mt76: mt7915: remove VHT160 capability on MT7915
> 0e61f73e6ebc0 wifi: mt76: mt7915: fix capabilities in non-AP mode
> 6bce28ce28390 wifi: mt76: mt7915: fix command timeout in AP stop period
> 7af917d4864c6 wifi: mt76: mt7915: rework tx bytes counting when WED is active
> feae00c6468ce wifi: mt76: mt7915: rework tx packets counting when WED is active
> 70bbcc4ad6544 wifi: mt76: mt7915: fix background radar event being blocked
> ```
> 
> and this broke my mt7915-based AP.
> 
> However, if I remove `[VT160]` capability from the hostapd config, things go back to normal. It does seem that 160 MHz still works even.
> 
> Is this expected?

I would say it is expected.

hostapd seems to solely rely on the VHT Supported Channel Width and does not 
seem to support the VHT Extended NSS BW stuff.  So it only knows about full VHT 
160 MHz support and not about half NSS VHT 160 MHz.

The hardware does not actually support full 160 MHz (despite the driver 
erroneously claiming support for it before this patch) so it make sense that 
hostapd fails to start the AP if the config file requests (full) VHT 160 MHz.

However, hostapd knows about half NSS HE 160 MHz and I suspect your 
configuration also requests HE 160 MHz, so 160 MHz works fine in HE but not in VHT.

In any case, it would help to know the hostapd version and your configuration file.
