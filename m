Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE73760C50
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjGYHsU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jul 2023 03:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjGYHsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:48:14 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034E9BF;
        Tue, 25 Jul 2023 00:48:07 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 23DF824DBCE;
        Tue, 25 Jul 2023 15:48:00 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 25 Jul
 2023 15:48:00 +0800
Received: from [192.168.120.43] (171.223.208.138) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 25 Jul
 2023 15:47:58 +0800
Message-ID: <fd30b319-f537-54f7-2651-1a20ca5f484c@starfivetech.com>
Date:   Tue, 25 Jul 2023 15:47:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [-next v1 1/1] riscv: dts: starfive: visionfive 2: Add v1.3B gmac
 phy configuration
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Conor Dooley" <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>
References: <20230725073039.14382-1-samin.guo@starfivetech.com>
 <20230725073039.14382-2-samin.guo@starfivetech.com>
 <20230725-rental-struck-d49a18d1c382@wendy>
From:   Guo Samin <samin.guo@starfivetech.com>
In-Reply-To: <20230725-rental-struck-d49a18d1c382@wendy>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/25 15:44:06, Conor Dooley wrote:
> On Tue, Jul 25, 2023 at 03:30:39PM +0800, Samin Guo wrote:
>> Add visionfive 2 v1.3B gmac phy configuration, including drive strength
>> and inverting configuration.
>>
>> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
>> Signed-off-by: Samin Guo <samin.guo@starfivetech.com>
> 
> I opted to squash this (and my temporary revert that becomes a NOP) into
> the original patch. It should appear in linux-next tomorrow as 0104340a67b1
> ("riscv: dts: starfive: visionfive 2: Add configuration of gmac and phy").
> 
> Thanks,
> Conor.

Thank you so much!

Best regards,
Samin
