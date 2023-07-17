Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48100755960
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 04:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjGQCGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 22:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjGQCGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 22:06:32 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239AFE58;
        Sun, 16 Jul 2023 19:06:30 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id EE26624E2E0;
        Mon, 17 Jul 2023 10:06:21 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Jul
 2023 09:34:53 +0800
Received: from [192.168.125.107] (113.72.147.86) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Jul
 2023 09:34:52 +0800
Message-ID: <ff879340-2371-6966-84fb-d59de1c15a0f@starfivetech.com>
Date:   Mon, 17 Jul 2023 09:34:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 2/2] phy: starfive: Add mipi dphy rx support
To:     Vinod Koul <vkoul@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230630093056.46904-1-changhuang.liang@starfivetech.com>
 <20230630093056.46904-3-changhuang.liang@starfivetech.com>
 <ZLFfkhnxZbRS7s9y@matsya>
Content-Language: en-US
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <ZLFfkhnxZbRS7s9y@matsya>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.86]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/14 22:45, Vinod Koul wrote:
> On 30-06-23, 02:30, Changhuang Liang wrote:
>> Add mipi dphy rx support for the StarFive JH7110 SoC. It is used to
>> transfer CSI camera data.
>>
>> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
>> ---
>>  MAINTAINERS                                 |   7 +
>>  drivers/phy/Kconfig                         |   1 +
>>  drivers/phy/Makefile                        |   1 +
>>  drivers/phy/starfive/Kconfig                |  13 ++
>>  drivers/phy/starfive/Makefile               |   2 +
>>  drivers/phy/starfive/phy-starfive-dphy-rx.c | 230 ++++++++++++++++++++
>>  6 files changed, 254 insertions(+)
>>  create mode 100644 drivers/phy/starfive/Kconfig
>>  create mode 100644 drivers/phy/starfive/Makefile
> 
> This need rebase as files exist now
> 

OK, I will rebase it.

Thanks,
Changhuang
