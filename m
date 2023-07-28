Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E74766818
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbjG1JDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbjG1JCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:02:47 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F252D5E;
        Fri, 28 Jul 2023 02:02:43 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 27C6624E31A;
        Fri, 28 Jul 2023 17:02:40 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 28 Jul
 2023 17:02:40 +0800
Received: from [192.168.120.59] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 28 Jul
 2023 17:02:39 +0800
Message-ID: <23769fc1-69cb-f237-6488-f2322368e309@starfivetech.com>
Date:   Fri, 28 Jul 2023 17:02:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 2/3] spi: cadence-quadspi: Add clock configuration for
 StarFive JH7110 QSPI
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
References: <20230719092545.1961401-1-william.qiu@starfivetech.com>
 <20230719092545.1961401-3-william.qiu@starfivetech.com>
 <20230728-retread-starch-3399b921718a@wendy>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <20230728-retread-starch-3399b921718a@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/28 16:58, Conor Dooley wrote:
> Hey William,
> 
> Since you pinged things, I had a quick look.
> 
> On Wed, Jul 19, 2023 at 05:25:44PM +0800, William Qiu wrote:
>> Add JH7110's clock initialization code to the driver.
>> 
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> 
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202306022017.UbwjjWRN-lkp@intel.com/
>> Reported-by: Julia Lawall <julia.lawall@inria.fr>
>> Closes: https://lore.kernel.org/r/202306040644.6ZHs55x4-lkp@intel.com/
> 
> These, as pointed out on the last version, should not be here.
> kernel test robot complaints about un-applied patches do not get a
> reported-by etc in subsequent versions of the same patchset, just as
> comments from human reviewers do not require reported-by tags.
> 
> These tags should only be used when the code has been merged & you need
> to create a new patch to fix the issue.
> 
> Hopefully, if the code is otherwise fine, Mark can fix this when he
> applies the patches.
> 
> Thanks,
> Conor.

Hi Conor,

Fine, I will drop it in next version.

Best regards,
William
