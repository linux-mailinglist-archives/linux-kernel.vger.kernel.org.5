Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6D5758073
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbjGRPJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjGRPJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:09:08 -0400
Received: from mail.croughan.sh (mail.croughan.sh [IPv6:2a01:4f9:c011:cb0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1375F1737;
        Tue, 18 Jul 2023 08:09:05 -0700 (PDT)
Message-ID: <0645409b-3f79-9109-26c1-6e84065e46bf@nix.how>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nix.how; s=mail;
        t=1689692942; bh=/mhfgxqxtca1gPyaeAwDuQ1jXHYYV0q9p+QPHOPgwkY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=U+Myn8Iz5ccNcfgclf5tfsw9wX0CAD+yR6jVmLL9Cwj0KvWZmhgRXkWW0znaxEFFY
         iBfO/wOWha9+S59WB0S8WVEGlWAexEHXl3aZ6mqp/RCwePabAh93nEfGt2o1fU438M
         255Wd8uU2PfF9D6Q1+KcOvGuwQ5gi3RJoVKKdN8w=
Date:   Tue, 18 Jul 2023 16:09:00 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] arm64: dts: allwinner: h616: Add Mango Pi MQ-Quad DTS
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230718124752.1279094-1-matthew.croughan@nix.how>
 <a85a6d11-a3de-958c-bd87-d2fffe446bca@linaro.org>
From:   Matthew Croughan <matthew.croughan@nix.how>
In-Reply-To: <a85a6d11-a3de-958c-bd87-d2fffe446bca@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 15:08, Krzysztof Kozlowski wrote:

> On 18/07/2023 14:47, Matthew Croughan wrote:
>> Mango Pi MQ Quad is a H616 based SBC, add basic support for the board
>> and its peripherals
>> ---
> Third email within few hours - no, wait a day. There are so many issues
> here that sending immediately won't help you.
>
> 1. Missing changelog, so did you ignore entire feedback?
> 2. Missing Signed-off-by
>
>
>>   arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>>   .../allwinner/sun50i-h616-mangopi-mq-quad.dts | 183 ++++++++++++++++++
> Yeah, no bindings patch, so you did ignore the feedback.
>
> Sorry, that's a no.
>
> This is a friendly reminder during the review process.
>
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all
> requested changes or keep discussing them.
>
> Thank you.
>
> Best regards,
> Krzysztof

No problem, this is my first attempt at contribution to the kernel, and 
my first time trying to follow the process on 
https://docs.kernel.org/process/submitting-patches.html. The first reply 
attempting to address your feedback, I screwed up and didn't add -v2 to 
git format-patch. I wasn't sure if I'd get yelled at for that, so I 
panicked and sent with the -v2 to correct it afterwards, hoping you'd 
ignore it. It appears I've made it worse, spam was not the intent. 
Please let me know if I've replied to this email with good etiquette 
also, as I'm told I shouldn't be "top-posting". But I was born after 
Email was obsolete, so am not sure if I'm doing it correctly.

Changelog: I'm sorry, I missed the part of submitting-patches.html that 
said it would be good for other reviewers. I'll try making a changelog 
on my next submission.

Bindings: I just figured out that you meant I should add to the 
`Documentation` folder, and that you were not suggesting the dt-bindings 
in the #includes were inaccurate or missing.





