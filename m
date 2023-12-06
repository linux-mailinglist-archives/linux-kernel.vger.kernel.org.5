Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6541806D2D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378073AbjLFLBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377946AbjLFK74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:59:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C771738
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:59:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BB9C433C7;
        Wed,  6 Dec 2023 10:59:32 +0000 (UTC)
Message-ID: <cae19173-1b36-4300-b770-782a7b7c2200@xs4all.nl>
Date:   Wed, 6 Dec 2023 11:59:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/5] MAINTAINERS: Add entries for Toshiba Visconti
 Video Input Interface
Content-Language: en-US, nl
To:     yuji2.ishikawa@toshiba.co.jp, laurent.pinchart@ideasonboard.com,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nobuhiro1.iwamatsu@toshiba.co.jp
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231012071329.2542003-1-yuji2.ishikawa@toshiba.co.jp>
 <20231012071329.2542003-6-yuji2.ishikawa@toshiba.co.jp>
 <767e3297-e1f9-483d-870e-67e75048b91a@xs4all.nl>
 <TYAPR01MB62015CB80317567D6F9C4A5E92BDA@TYAPR01MB6201.jpnprd01.prod.outlook.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <TYAPR01MB62015CB80317567D6F9C4A5E92BDA@TYAPR01MB6201.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2023 01:38, yuji2.ishikawa@toshiba.co.jp wrote:
> Hello Hans,
> Thank you for the review.
> 
>> -----Original Message-----
>> From: Hans Verkuil <hverkuil@xs4all.nl>
>> Sent: Tuesday, November 14, 2023 5:41 PM
>> To: ishikawa yuji(石川 悠司 ○ＲＤＣ□ＡＩＴＣ○ＥＡ開)
>> <yuji2.ishikawa@toshiba.co.jp>; Laurent Pinchart
>> <laurent.pinchart@ideasonboard.com>; Mauro Carvalho Chehab
>> <mchehab@kernel.org>; Rob Herring <robh+dt@kernel.org>; Krzysztof
>> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
>> <conor+dt@kernel.org>; iwamatsu nobuhiro(岩松 信洋 ○ＤＩＴＣ□ＤＩＴ○
>> ＯＳＴ) <nobuhiro1.iwamatsu@toshiba.co.jp>
>> Cc: linux-media@vger.kernel.org; devicetree@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v9 5/5] MAINTAINERS: Add entries for Toshiba Visconti
>> Video Input Interface
>>
>> On 12/10/2023 09:13, Yuji Ishikawa wrote:
>>> Added entries for visconti Video Input Interface driver, including;
>>> * device tree bindings
>>> * source files
>>> * documentation files
>>>
>>> Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
>>> ---
>>> Changelog v2:
>>> - no change
>>>
>>> Changelog v3:
>>> - added entry for driver API documentation
>>>
>>> Changelog v4:
>>> - added entry for header file
>>>
>>> Changelog v5:
>>> - no change
>>>
>>> Changelog v6:
>>> - update path to VIIF driver source files
>>>
>>> Changelog v7:
>>> - no change
>>>
>>> Changelog v8:
>>> - rename bindings description file
>>>
>>> Changelog v9:
>>> - no change
>>>
>>>  MAINTAINERS | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS index
>>> eaa1a28a9d54..6035f711b3fb 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2902,17 +2902,21 @@ F:
>> 	Documentation/devicetree/bindings/arm/toshiba.yaml
>>>  F:
>> 	Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.y
>> aml
>>>  F:
>> 	Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.y
>> aml
>>>  F:	Documentation/devicetree/bindings/gpio/toshiba,gpio-visconti.yaml
>>> +F:
>> 	Documentation/devicetree/bindings/media/toshiba,visconti5-viif.yam
>> l
>>>  F:
>> 	Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.ya
>> ml
>>>  F:	Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
>>>  F:
>> 	Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.y
>> aml
>>>  F:
>> 	Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.
>> yaml
>>> +F:	Documentation/driver-api/media/drivers/visconti-viif.rst
>>>  F:	arch/arm64/boot/dts/toshiba/
>>>  F:	drivers/clk/visconti/
>>>  F:	drivers/gpio/gpio-visconti.c
>>> +F:	drivers/media/platform/toshiba/visconti/
>>>  F:	drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
>>>  F:	drivers/pci/controller/dwc/pcie-visconti.c
>>>  F:	drivers/pinctrl/visconti/
>>>  F:	drivers/watchdog/visconti_wdt.c
>>> +F:	include/uapi/linux/visconti_viif.h
>>>  N:	visconti
>>
>> This is a bit odd: it adds the driver to an existing entry, but you do not add
>> yourself as maintainer. Typically a large driver like this one will have its own
>> entry.
>>
>> At minimum I need an Acked-by from Nobuhiro Iwamatsu for this change. But I
>> think it might be better to make a separate entry for this driver. Up to you,
>> though.
> 
> I'll make a separate entry for Visconti VIIF driver.
> I talked it over with Iwamatsu-san and he agreed.
> I need Acked-by tag from him at v10 patch submission; is it a correct understanding?

Yes, that's correct.

Regards,

	Hans

> 
>>
>> Regards,
>>
>> 	Hans
>>
>>>
>>>  ARM/UNIPHIER ARCHITECTURE
> 
> Regards,
> Yuji

