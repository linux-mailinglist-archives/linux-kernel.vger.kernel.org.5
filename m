Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263FD7D2EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjJWJyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjJWJxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:53:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1466AD6;
        Mon, 23 Oct 2023 02:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698054830; x=1729590830;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FNoNvvtB5z3IcYR2ZH7MUAtY5BnL5fBLxuEiKxvDcbc=;
  b=TYfRc7HyOmu9gEuS5hRHTrlJhfEMM9iGGabSXYtzjU3k/mvVW9/Lmp8Q
   WbblR9HW+NOkwbRIzhw9R3mrQYlQ6O2WHgQlcalohZNy9O5hLuQ0wGBR+
   tz9oT8eiS341oS83gLQ4YJua+OzbBGyY4A7NCcBtwg1RGyhcgmw6oP869
   1g8DNcl+vr0kcKQX9XE99rTXrTCG5V4bgYxHDl7qY01IYhUnq/tZaJ6K2
   qymXbjusUWbXNuM4QK1O30hN1pEyHlZ9Xv6nUvDO/rdr0j2lTMZVWY/0b
   GKbI43Kw1b7xr21FiXaWJ/sFatkU/NzieJpeLG5vo+PTRkWnTR6m6rsTV
   Q==;
X-CSE-ConnectionGUID: TBx8bJLWSmuGIqpOLwUp8w==
X-CSE-MsgGUID: r6Pda/ZvQYCTNQ/C5Ofa5g==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="241192355"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2023 02:53:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 23 Oct 2023 02:53:49 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 23 Oct 2023 02:53:47 -0700
Message-ID: <db866599-3143-43a6-801d-012cdfd23019@microchip.com>
Date:   Mon, 23 Oct 2023 11:53:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: mmc: take over as maintainer of MCI & SDHCI
 MICROCHIP DRIVERS
To:     Eugen Hristev <eugen.hristev@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <aubin.constans@microchip.com>, <Ludovic.Desroches@microchip.com>
CC:     <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Hari.PrasathGE@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>
References: <20230911153246.137148-1-aubin.constans@microchip.com>
 <fd02d42e-7b24-4f50-849e-b0c752d1f011@microchip.com>
 <CAPDyKFpYzgwPvrWntgDQCZo97OZr2qd2FaVXpi7OnNc7i_gYtw@mail.gmail.com>
 <c4f43487-da93-4e67-0389-e31dde550d40@microchip.com>
 <55e85f31-fab6-07f9-0ffe-8ebcd2a56489@collabora.com>
Content-Language: en-US, fr-FR
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <55e85f31-fab6-07f9-0ffe-8ebcd2a56489@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ulf,

On 18/09/2023 at 13:03, Eugen Hristev wrote:
> On 9/14/23 20:01, Nicolas Ferre wrote:
>> On 14/09/2023 at 16:21, Ulf Hansson wrote:
>>> On Tue, 12 Sept 2023 at 07:21, <Ludovic.Desroches@microchip.com> wrote:
>>>>
>>>> On 9/11/23 17:32, Aubin Constans wrote:
>>>>> On the one hand Eugen has taken responsibilities outside Microchip,
>>>>> on the other hand I have some experience with the Microchip SDMMC
>>>>> SDHCI controller.
>>>>> Change Eugen as reviewer and take over maintainership of the SDHCI
>>>>> MICROCHIP DRIVER.
>>>>> Also, take over maintainership of its predecessor, that is the MCI
>>>>> MICROCHIP DRIVER.
>>>>>
>>>>> Cc: Eugen Hristev <eugen.hristev@collabora.com>
>>>>> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
>>>>> Signed-off-by: Aubin Constans <aubin.constans@microchip.com>
>>>>
>>>> For atmel-mci:
>>>> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
>>>
>>> Sounds like the patch could be split up, as there is an agreement on
>>> the atmel-mci part.
>>>
>>> Aubin, can you make a separate patch for the atmel-mci part and add
>>> Ludovic's ack to it?
>>>
>>> In regards to the sdhci driver, I suggest you just add yourself as a
>>> maintainer too, along with Eugen.
>>
>> For adding more background to this patch, in fact it was created in
>> coordination with Eugen. We can wait a bit for him to catch-up with
>> emails, no hurry there as Aubin won't have access to emails for a few
>> days anyway.
>>
>> If it has an interest you can add my:
>> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>> But definitively, no problem to delay this change.
> 
> Hi,
> 
> I am fine with this change, as Nicolas has already discussed this with me.
> 
> Acked-by: Eugen Hristev <eugen.hristev@collabora.com>

I think we have all the required tags since Eugen email: aka ping...

Tell me if you prefer that we use another route to Mainline (as you may 
not have remaining changes to queue). Best regards,
   Nicolas

> P.S. I have a mailmap entry for the new e-mail so the change is not
> compulsory, you can change as you see fit.
> 
> Eugen
> 
>>
>> Thanks for your understanding. Best regards,
>>     Nicolas
>>
>>>>> ---
>>>>>     MAINTAINERS | 5 +++--
>>>>>     1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index 2833e2da63e0..52beaf4f7fbb 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -14022,7 +14022,7 @@ F:
>>>>> Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
>>>>>     F:  drivers/iio/adc/mcp3911.c
>>>>>
>>>>>     MICROCHIP MMC/SD/SDIO MCI DRIVER
>>>>> -M:   Ludovic Desroches <ludovic.desroches@microchip.com>
>>>>> +M:   Aubin Constans <aubin.constans@microchip.com>
>>>>>     S:  Maintained
>>>>>     F:  drivers/mmc/host/atmel-mci.c
>>>>>
>>>>> @@ -19235,7 +19235,8 @@ F:
>>>>> Documentation/devicetree/bindings/mmc/sdhci-common.yaml
>>>>>     F:  drivers/mmc/host/sdhci*
>>>>>
>>>>>     SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) MICROCHIP DRIVER
>>>>> -M:   Eugen Hristev <eugen.hristev@microchip.com>
>>>>> +M:   Aubin Constans <aubin.constans@microchip.com>
>>>>> +R:   Eugen Hristev <eugen.hristev@collabora.com>
>>>>>     L:  linux-mmc@vger.kernel.org
>>>>>     S:  Supported
>>>>>     F:  drivers/mmc/host/sdhci-of-at91.c
>>>>
>>
> 

