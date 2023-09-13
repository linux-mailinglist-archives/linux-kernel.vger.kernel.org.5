Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872D479E035
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 08:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbjIMGpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 02:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238468AbjIMGpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 02:45:30 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8E81980;
        Tue, 12 Sep 2023 23:45:25 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 7EAB824E3D6;
        Wed, 13 Sep 2023 14:45:23 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 13 Sep
 2023 14:45:21 +0800
Received: from [192.168.125.55] (113.72.145.181) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 13 Sep
 2023 14:45:20 +0800
Message-ID: <f31b97b1-ce81-c259-cd19-6978d9fcec55@starfivetech.com>
Date:   Wed, 13 Sep 2023 14:45:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [-next v2 1/2] riscv: dts: starfive: visionfive 2: Enable usb0
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230829020511.26844-1-hal.feng@starfivetech.com>
 <c417d55d-d886-f66d-15a9-73b297d28d59@starfivetech.com>
 <20230913-mockup-liable-9dcf94ed4568@wendy>
Content-Language: en-US
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <20230913-mockup-liable-9dcf94ed4568@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.181]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023 07:20:54 +0100, Conor Dooley wrote:
> On Wed, Sep 13, 2023 at 11:47:22AM +0800, Hal Feng wrote:
>> On Tue, 29 Aug 2023 10:05:10 +0800, Hal Feng wrote:
>> > usb0 was disabled by mistake when merging, so enable it.
>> > 
>> > Fixes: e7c304c0346d ("riscv: dts: starfive: jh7110: add the node and pins configuration for tdm")
>> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> > ---
>> >  arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 1 +
>> >  1 file changed, 1 insertion(+)
>> > 
>> > diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> > index d79f94432b27..85f40df93f25 100644
>> > --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> > +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> > @@ -513,6 +513,7 @@ &uart0 {
>> >  
>> >  &usb0 {
>> >  	dr_mode = "peripheral";
>> > +	status = "okay";
>> >  };
>> 
>> Hi, Conor,
>> 
>> As v6.6-rc1 is already released, would you apply this series
>> in rc2 or the later rc versions?
> 
> Yes, I was planning on doing a sweep for potential fixes today. There's
> 3 or 4 I think.

I see. Thanks a lot.

Best regards,
Hal
