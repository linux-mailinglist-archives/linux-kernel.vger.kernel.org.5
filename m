Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62EE75BC9E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 05:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjGUDBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 23:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGUDBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:01:52 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CAA1FED;
        Thu, 20 Jul 2023 20:01:50 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id AF37424DD82;
        Fri, 21 Jul 2023 11:01:48 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Jul
 2023 11:01:48 +0800
Received: from [192.168.125.107] (113.72.147.86) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Jul
 2023 11:01:47 +0800
Message-ID: <e2f086cd-a1e3-e8c6-9c41-f2afee83436e@starfivetech.com>
Date:   Fri, 21 Jul 2023 11:01:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 0/4] Add JH7110 AON PMU support
To:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230519060202.15296-1-changhuang.liang@starfivetech.com>
 <20230720-magnifier-goldfish-7d5a84e99c4d@spud>
Content-Language: en-US
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <20230720-magnifier-goldfish-7d5a84e99c4d@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.86]
X-ClientProxiedBy: EXCAS063.cuchost.com (172.16.6.23) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/21 1:12, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> On Thu, 18 May 2023 23:01:58 -0700, Changhuang Liang wrote:
>> This patchset adds aon power domain driver for the StarFive JH7110 SoC.
>> It is used to turn on/off dphy rx/tx power switch. It also can use syscon
>> operation. The series has been tested on the VisionFive 2 board.
>>
>> This patchset should be applied after the patchset [1]:
>> [1] https://lore.kernel.org/all/20230512022036.97987-1-xingyu.wu@starfivetech.com/
>>
>> [...]
> 
> Applied to riscv-soc-for-next, thanks!
> 
> [1/4] dt-bindings: power: Add power-domain header for JH7110
>       https://git.kernel.org/conor/c/2b8f8c6e797c
> [2/4] soc: starfive: Replace SOC_STARFIVE with ARCH_STARFIVE
>       https://git.kernel.org/conor/c/36393facfabf
> [3/4] soc: starfive: Extract JH7110 pmu private operations
>       https://git.kernel.org/conor/c/bd0c0d3dae34
> [4/4] soc: starfive: Add JH7110 AON PMU support
>       https://git.kernel.org/conor/c/30fb4784483b
> 
> I expect I'll get an email tomorrow from SFR pointing out some conflicts
> with the new genpd stuff. I think the plan is for Arnd to sort those
> things out prior to the next merge window.
> 

Thank you all!
