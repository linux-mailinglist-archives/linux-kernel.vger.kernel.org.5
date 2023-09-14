Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584087A0B27
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237340AbjINRB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjINRBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:01:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C0A1BD4;
        Thu, 14 Sep 2023 10:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694710881; x=1726246881;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yov59rydmM1ThqfKefv5Dcrw5UeV0DPLP7DnyRwF+AA=;
  b=bIJ9/uWSF5CzdbU2YdRi/LZcGPL7akeKRyw+P/Rqfazu7BVYv3PwKlUG
   ek15nV4OXUSUxlb49dTDB4Is0VN3bOv2Wzqb0Wu/Lg5MM15l+2yf0j2Zi
   PqwVgGvmWHdcp7FmEksMbkqatvfNR+Oz+8+/CTck4QHkIvEUughiD1IAa
   3YnmjMnBQKDBQvYPte2MEEFYONfh2+p2uHW/phIH+03BkD9wANzmZ/Kuv
   8X99VnfVeQbyILKaioYF9YTWYr7EOXKMwhWpq2Fdj1rh1lo9sRAgwSm3w
   /OpzoIMG6aEyIZYaVaABpk9l2mE+OZQLW+8viGe+pzBsc6UzcUC5ha86S
   Q==;
X-CSE-ConnectionGUID: JQlUMCvpQce13Qxt80qbKA==
X-CSE-MsgGUID: KsoXbAzCR/OtOpU1VYmw5w==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="171694120"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 10:01:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 14 Sep 2023 10:01:19 -0700
Received: from [10.171.246.25] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 14 Sep 2023 10:01:16 -0700
Message-ID: <c4f43487-da93-4e67-0389-e31dde550d40@microchip.com>
Date:   Thu, 14 Sep 2023 19:01:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: mmc: take over as maintainer of MCI & SDHCI
 MICROCHIP DRIVERS
Content-Language: en-US, fr-FR
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        <eugen.hristev@collabora.com>, <aubin.constans@microchip.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Hari.PrasathGE@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>
References: <20230911153246.137148-1-aubin.constans@microchip.com>
 <fd02d42e-7b24-4f50-849e-b0c752d1f011@microchip.com>
 <CAPDyKFpYzgwPvrWntgDQCZo97OZr2qd2FaVXpi7OnNc7i_gYtw@mail.gmail.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <CAPDyKFpYzgwPvrWntgDQCZo97OZr2qd2FaVXpi7OnNc7i_gYtw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2023 at 16:21, Ulf Hansson wrote:
> On Tue, 12 Sept 2023 at 07:21, <Ludovic.Desroches@microchip.com> wrote:
>>
>> On 9/11/23 17:32, Aubin Constans wrote:
>>> On the one hand Eugen has taken responsibilities outside Microchip,
>>> on the other hand I have some experience with the Microchip SDMMC
>>> SDHCI controller.
>>> Change Eugen as reviewer and take over maintainership of the SDHCI
>>> MICROCHIP DRIVER.
>>> Also, take over maintainership of its predecessor, that is the MCI
>>> MICROCHIP DRIVER.
>>>
>>> Cc: Eugen Hristev <eugen.hristev@collabora.com>
>>> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
>>> Signed-off-by: Aubin Constans <aubin.constans@microchip.com>
>>
>> For atmel-mci:
>> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> 
> Sounds like the patch could be split up, as there is an agreement on
> the atmel-mci part.
> 
> Aubin, can you make a separate patch for the atmel-mci part and add
> Ludovic's ack to it?
> 
> In regards to the sdhci driver, I suggest you just add yourself as a
> maintainer too, along with Eugen.

For adding more background to this patch, in fact it was created in 
coordination with Eugen. We can wait a bit for him to catch-up with 
emails, no hurry there as Aubin won't have access to emails for a few 
days anyway.

If it has an interest you can add my:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
But definitively, no problem to delay this change.

Thanks for your understanding. Best regards,
   Nicolas

>>> ---
>>>    MAINTAINERS | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 2833e2da63e0..52beaf4f7fbb 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -14022,7 +14022,7 @@ F:    Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
>>>    F:  drivers/iio/adc/mcp3911.c
>>>
>>>    MICROCHIP MMC/SD/SDIO MCI DRIVER
>>> -M:   Ludovic Desroches <ludovic.desroches@microchip.com>
>>> +M:   Aubin Constans <aubin.constans@microchip.com>
>>>    S:  Maintained
>>>    F:  drivers/mmc/host/atmel-mci.c
>>>
>>> @@ -19235,7 +19235,8 @@ F:    Documentation/devicetree/bindings/mmc/sdhci-common.yaml
>>>    F:  drivers/mmc/host/sdhci*
>>>
>>>    SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) MICROCHIP DRIVER
>>> -M:   Eugen Hristev <eugen.hristev@microchip.com>
>>> +M:   Aubin Constans <aubin.constans@microchip.com>
>>> +R:   Eugen Hristev <eugen.hristev@collabora.com>
>>>    L:  linux-mmc@vger.kernel.org
>>>    S:  Supported
>>>    F:  drivers/mmc/host/sdhci-of-at91.c
>>

