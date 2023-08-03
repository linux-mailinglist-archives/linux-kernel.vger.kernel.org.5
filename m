Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CBA76ED4B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbjHCO4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbjHCO4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:56:10 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B790173F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biqu3d.com;
        s=tfld2305; t=1691074548;
        bh=weiD6oVC0iEXiHOI8NFlS6mGyklf2XyHE41bwoNh3OI=;
        h=Message-ID:Date:MIME-Version:Subject:To:From;
        b=TkT/Of0fSxovWBIsD9tQF3Rg1MLSiZu3o6OXZCFkeezwX0bhQsM8Ng2O2gFfFRd+f
         EOubM3LIOMxCl2+HyL/YrZ+/TvDNxOIXjaZ3cElLufKbjHFc+tYVav8hZ0xhylRtRP
         GVzdS3Br21046qe9GvgYFjTvmT8fWbPSCRUoVt68=
X-QQ-mid: bizesmtp67t1691074494tgyh43r1
Received: from [192.168.2.144] ( [178.41.211.221])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 03 Aug 2023 22:54:42 +0800 (CST)
X-QQ-SSF: 01400000000000303000000A0000000
X-QQ-FEAT: IByDngDI/kEy5uTimwvjv38YisB2OlS+T+fSB0uFKFXdBpo0AQJHOMwCIv6ub
        jD+KxnNjTL4GJ5kAZxJrVgFbAC0tFTNkMdwxNxp/iitxV8wiFGPWt5y4z/XiRNnBM+4dRkk
        z18l/bEIOD4NPgNqPvtotdVVQfzO0rB5EXecv2FeZK2ySmOREuJOnI38gT7+LatjRkArC7h
        Gl8yV652Z/NWlfEwN035a4LQEawLxkyvKIJs4+x4/UMA7ROytyp2lvubH/HKGc7P3BDz6Uf
        086wG5xDQHcWw76fPi6xTn/hAFNwj3O+UlrBKsBtvGK7H9t/QloXMOr06FrpjnWqulQR54i
        Uu9pX2PaZ1Ocd1jN+Iv35KMIR46L4R82/pTWXjhsNlv5dWbg8SiX5YfLi2oCgBdAfyUt8bs
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3958402243013388895
Message-ID: <51B75CF14DC0F06B+430ea53b-0189-45bf-26e2-94c9925ea4b6@biqu3d.com>
Date:   Thu, 3 Aug 2023 16:54:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 6/6] arm64: dts: allwinner: h616: Add BigTreeTech Pi
 support
Content-Language: en-US
To:     Andre Przywara <andre.przywara@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andrew Lunn <andrew@lunn.ch>, Icenowy Zheng <uwu@icenowy.me>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230802220309.163804-1-martin@biqu3d.com>
 <DFE9B2F1349F69AE+20230802220309.163804-7-martin@biqu3d.com>
 <17dec3fb-1bce-77ff-9917-7f565049954d@linaro.org>
 <20230803154921.0d42fc66@donnerap.manchester.arm.com>
From:   Martin Botka <martin@biqu3d.com>
In-Reply-To: <20230803154921.0d42fc66@donnerap.manchester.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:biqu3d.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/23 4:49 PM, Andre Przywara wrote:
> On Thu, 3 Aug 2023 16:30:06 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 03/08/2023 00:02, Martin Botka wrote:
>>> The BigTreeTech Pi is an H616 based board based on CB1.
>>> Just in Rpi format board.
>>>
>>> It features the same internals as BTT CB1 but adds:
>>>      - Fan port
>>>      - IR receiver
>>>      - 24V DC power supply via terminal plugs
>>>      - USB to CAN module connector (The actual USB to CAN happens on the external module)
>>>
>>> List of currently working things is the same as BTT CB1.
>>>
>>> Signed-off-by: Martin Botka <martin@biqu3d.com>
>>> ---
>>>   .../allwinner/sun50i-h616-bigtreetech-pi.dts  | 44 +++++++++++++++++++
>>>   1 file changed, 44 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
>>>
>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
>>> new file mode 100644
>>> index 000000000000..05f39b3606ba
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
>>> @@ -0,0 +1,44 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
>>> +/*
>>> + * Copyright (C) 2023 Martin Botka <martin@biqu3d.com>.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "sun50i-h616-bigtreetech-cb1.dtsi"
>>
>> If this is using CB1 DTSI, does it mean it uses CB1 SoM? If so, I think
>> this should be reflected in the compatibles.
>>
>> It's a bit confusing because in previous patch you call it "CB1 board"
>> but then with name "Manta"... So what is CB1?
> 
> That's indeed a bit confusing, but from what I got from the BTT webpage:
> "CB1" is the SoM. M8P (and its M4P/M5P siblings) are carrier boards with
> extra hardware for 3D printer support, taking the CB1 SoM.
> The "Bigtreetech BTT Pi" is embedding the same hardware as the SoM, but
> without actually using the SoM, directly on a PCB, so similar to what we
> have with the Pine64 SoPine and the Pine64 LTS board. It doesn't come with
> the extra goodies of the more 3D printer related boards.
> 
> I *think* the "BIGTREETECH PI4B Adapter" is a normal dev board using the
> actual SoM, but with an otherwise identical(?) functionality software wise
> - so it can run with the same DTB. I wonder if we should have a separate
> .dts for this, though, since I believe it's not really identical in every
> aspect - starting with the USB ports, for instance.
> 
> But for this board and patch here I think it's fine to include the
> cb1.dtsi, but not using the CB1 name in the compatibles list.
> 

You got it perfectly Andre :) Yes CB1 is an SoM and Manta boards and BTT 
Pi4B adapter board are just carriers of this SoM. PI4B board uses the 
same DTB as manta boards. It also has the same USB hub and etc.

BTT Pi on the other hand is CB1 hardware but actually comes in Pi format 
with the CB1 hardware embedded on the boards directly. BTT Pi wires up 
the USB ports to their respective ports on SoC and thus the separate DTS 
(Also ofc the extra stuff like IR and fan port which will be enabled in 
the future)

Cheers,
Martin
> Cheers,
> Andre
> 
