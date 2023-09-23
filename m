Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8996B7AC14A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 13:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjIWLlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 07:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjIWLlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 07:41:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B379F11D;
        Sat, 23 Sep 2023 04:41:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF22C433C8;
        Sat, 23 Sep 2023 11:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695469277;
        bh=ZON8kr4GUbYCZ4b1kB2ZVW9g0A5X9VAu+hWS6y27YS4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Cs4W1QnHJGdeNRwXe4HEks+w+f6j3Fn1juZdszAiLF48MCO4w7UXnWk2U5k6XUz53
         SnzxBG54ya35i38EY4ZcExrcTIaT3ofzaj+vnMEhHZV8PylCdeT4seVmpm81sBYLin
         H+DFX/5K9hCaAi7mqwUIn+2dsxI6BaqWfuAmvm6bzyWqd90+OIumvK7j7Ij2R5nBmr
         xGsqV2H0NpVPvfVIcNe+ZXkXBesw/zmjvBBc0oCMHXkayN0FwOk9S+gmNIfGI99G2U
         SWVJxKEKfJ7UaBByAc8vOzXazFiIl6NA8zE+/hJagc9hwcc0e+/dCqUd73UtKfOYN3
         Q8nsw+pOd+DKg==
Message-ID: <8eae1b18-b7dc-6e33-eb53-3b9df0d20dc6@kernel.org>
Date:   Sat, 23 Sep 2023 13:41:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [EXT] Re: [PATCH v2 2/2] dt-bindings: media: imx-jpeg: Assign
 slot for imx jpeg encoder/decoder
To:     Ming Qian <ming.qian@nxp.com>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Cc:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, Eagle Zhou <eagle.zhou@nxp.com>,
        Tao Jiang <tao.jiang_2@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230921063620.22962-1-ming.qian@nxp.com>
 <20230921063620.22962-2-ming.qian@nxp.com>
 <19d2bc5c-2662-6ed8-cc3d-7efb82fd1825@kernel.org>
 <AM6PR04MB634103F226B69ADD41255FCBE7FFA@AM6PR04MB6341.eurprd04.prod.outlook.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <AM6PR04MB634103F226B69ADD41255FCBE7FFA@AM6PR04MB6341.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2023 03:33, Ming Qian wrote:
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: 2023年9月21日 17:55
>> To: Ming Qian <ming.qian@nxp.com>; Mirela Rabulea (OSS)
>> <mirela.rabulea@oss.nxp.com>; robh+dt@kernel.org; shawnguo@kernel.org
>> Cc: mchehab@kernel.org; hverkuil-cisco@xs4all.nl; s.hauer@pengutronix.de;
>> kernel@pengutronix.de; festevam@gmail.com; X.H. Bao
>> <xiahong.bao@nxp.com>; Eagle Zhou <eagle.zhou@nxp.com>; Tao Jiang
>> <tao.jiang_2@nxp.com>; dl-linux-imx <linux-imx@nxp.com>; linux-
>> media@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org
>> Subject: [EXT] Re: [PATCH v2 2/2] dt-bindings: media: imx-jpeg: Assign slot for
>> imx jpeg encoder/decoder
>>
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report
>> this email' button
>>
>>
>> On 21/09/2023 08:36, Ming Qian wrote:
>>> There are total 4 slots available in the IP, and we only need to use
>>> one slot in one os, assign a single slot, configure interrupt and
>>> power domain only for 1 slot, not for the all 4 slots.
>>
>> Please use scripts/get_maintainers.pl to get a list of necessary people and lists
>> to CC. It might happen, that command when run on an older kernel, gives you
>> outdated entries. Therefore please be sure you base your patches on recent
>> Linux kernel.
>>
>> You missed at least devicetree list (maybe more), so this won't be tested by
>> automated tooling. Performing review on untested code might be a waste of
>> time, thus I will skip this patch entirely till you follow the process allowing the
>> patch to be tested.
>>
>> Please kindly resend and include all necessary To/Cc entries.
>>
>>>
>>> Signed-off-by: Ming Qian <ming.qian@nxp.com>
>>> ---
>>>  .../bindings/media/nxp,imx8-jpeg.yaml         | 40 ++++++++-----------
>>>  1 file changed, 16 insertions(+), 24 deletions(-)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
>>> b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
>>> index 3d9d1db37040..5f0e2fc1ea9c 100644
>>> --- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
>>> +++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
>>> @@ -32,25 +32,27 @@ properties:
>>>      maxItems: 1
>>>
>>>    interrupts:
>>> -    description: |
>>> -      There are 4 slots available in the IP, which the driver may use
>>> -      If a certain slot is used, it should have an associated interrupt
>>> -      The interrupt with index i is assumed to be for slot i
>>> -    minItems: 1               # At least one slot is needed by the driver
>>> -    maxItems: 4               # The IP has 4 slots available for use
>>> +    description:
>>> +      Interrupt number for slot
>>> +    maxItems: 1
>>>
>>>    power-domains:
>>>      description:
>>>        List of phandle and PM domain specifier as documented in
>>>        Documentation/devicetree/bindings/power/power_domain.txt
>>> -    minItems: 2               # Wrapper and 1 slot
>>> -    maxItems: 5               # Wrapper and 4 slots
>>> +    minItems: 1               # VPUMIX
>>> +    maxItems: 2               # Wrapper and 1 slot
>>> +
>>> +  slot:
>>> +    description:
>>> +      Integer number of slot index used. the value range is from 0 to
>>> + 3
>>
>> Don't you have here obvious errors reported by testing? Did you test this?
>>
>> Best regards,
>> Krzysztof
> 
> Hi Krzysztof,
>     Can you point out which test error? I run the dt_binding_check and didn't get any error.

Hm, I guess we need to add some checks for this... You miss type and
vendor prefix. This does not look like generic property. Constraints are
also missing, but that's minor. The main point is that this does not
look suitable for DT at all. Your description says nothing - copies
property name. Commit msg also does not explain it.

Best regards,
Krzysztof

