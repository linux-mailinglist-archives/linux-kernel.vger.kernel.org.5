Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6C6798565
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240297AbjIHKDR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Sep 2023 06:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbjIHKDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:03:16 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA1E2110;
        Fri,  8 Sep 2023 03:02:35 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id ABC8824E161;
        Fri,  8 Sep 2023 18:01:22 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 8 Sep
 2023 18:01:22 +0800
Received: from [192.168.120.76] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 8 Sep
 2023 18:01:21 +0800
Message-ID: <dd63bb4f-a59b-0323-08fb-03f8cc048b6e@starfivetech.com>
Date:   Fri, 8 Sep 2023 18:01:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: Drop unused properties
To:     Conor Dooley <conor@kernel.org>, Jessica Clarke <jrtc27@jrtc27.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20230830031846.127957-1-william.qiu@starfivetech.com>
 <20230830031846.127957-2-william.qiu@starfivetech.com>
 <20230830-commence-trickery-40eaa193cb15@wendy>
 <b375b88c-0d9c-30a9-21f6-283083cf3880@linaro.org>
 <20230830-procedure-frostbite-56c751f7c276@wendy>
 <efab6f52-4d7f-ea3c-0fc3-4e3ad03c14c7@starfivetech.com>
 <20230901-remold-sublease-a1ddb1fc6348@spud>
 <9EF26965-10E5-4BCA-AC5E-93C5AA55A0DF@jrtc27.com>
 <20230901-affected-wanting-ab517791a870@spud>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <20230901-affected-wanting-ab517791a870@spud>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/2 1:43, Conor Dooley wrote:
> On Fri, Sep 01, 2023 at 06:20:38PM +0100, Jessica Clarke wrote:
>> On 1 Sep 2023, at 16:42, Conor Dooley <conor@kernel.org> wrote:
>> > 
>> > On Fri, Sep 01, 2023 at 10:33:13AM +0800, William Qiu wrote:
>> >> 
>> >> 
>> >> On 2023/8/30 16:34, Conor Dooley wrote:
>> >>> On Wed, Aug 30, 2023 at 09:29:20AM +0200, Krzysztof Kozlowski wrote:
>> >>>> On 30/08/2023 08:50, Conor Dooley wrote:
>> >>>>> On Wed, Aug 30, 2023 at 11:18:44AM +0800, William Qiu wrote:
>> >>>>>> Due to the change of tuning implementation, it's no longer necessary to
>> >>>>>> use the "starfive,sysreg" property in dts, so drop the relevant
>> >>>>>> description in dt-bindings here.
>> >>>>> 
>> >>>>> How does changing your software implantation invalidate a description of
>> >>>>> the hardware?
>> >>>>> 
>> >>>> 
>> >>>> Which is kind of proof that this syscon was just to substitute
>> >>>> incomplete hardware description (e.g. missing clocks and phys). We
>> >>>> should have rejected it. Just like we should reject them in the future.
>> >>> 
>> >>> :s I dunno what to do with this... I'm inclined to say not to remove it
>> >>> from the binding or dts at all & only change the software.
>> >>> 
>> >>>> There are just few cases where syscon is reasonable. All others is just
>> >>>> laziness. It's not only starfivetech, of course. Several other
>> >>>> contributors do the same.
>> >>> 
>> >>> I'm not sure if laziness is fair, lack of understanding is usually more
>> >>> likely.
>> >> 
>> >> For this, I tend to keep it in binding, but remove it from required. Because
>> >> we only modify the tuning implementation, it doesn't mean that this property
>> >> need to be removed, it's just no longer be the required one.
>> > 
>> > Please only remove it from required if the current driver doesn't break
>> > if the regmap is removed.
>> 
>> Either way please make sure the documentation clearly states “never use
>> this, if you’re using it you’re doing it wrong, this only exists
>> because it was wrongly used in the past”. Otherwise people writing
>> drivers for other OSes will probably use it too thinking they need to.
> 
> Maybe we should just delete it if the impact is going to be negligible,
> sounds like you're not using it in FreeBSD, which was part of what I was
> worried about. Guess it depends on what Emil & the distro heads think.
Hi Conor,

After discussing it with our colleagues, we decided that deleting it was the best
course of action. Since there will no longer be a related implementation of
"starfive,sysreg" in future drivers, even if the dt-binding is described, it will
be "never use", so I think it should be deleted.

What do you think?

Best regards,
William
