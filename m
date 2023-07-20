Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5452175A4DC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 05:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjGTDqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 23:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTDqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 23:46:36 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55D51FCD;
        Wed, 19 Jul 2023 20:46:34 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 038DF24E275;
        Thu, 20 Jul 2023 11:46:30 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 20 Jul
 2023 11:46:29 +0800
Received: from [192.168.125.107] (113.72.147.86) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 20 Jul
 2023 11:46:29 +0800
Message-ID: <7fe9bc9a-2bb1-6c5c-2ed5-1eee85b8f299@starfivetech.com>
Date:   Thu, 20 Jul 2023 11:46:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 0/4] Add JH7110 AON PMU support
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>
CC:     Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230519060202.15296-1-changhuang.liang@starfivetech.com>
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <20230519060202.15296-1-changhuang.liang@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.86]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX062.cuchost.com
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



On 2023/5/19 14:01, Changhuang Liang wrote:
> This patchset adds aon power domain driver for the StarFive JH7110 SoC.
> It is used to turn on/off dphy rx/tx power switch. It also can use syscon
> operation. The series has been tested on the VisionFive 2 board.
> 
> This patchset should be applied after the patchset [1]:
> [1] https://lore.kernel.org/all/20230512022036.97987-1-xingyu.wu@starfivetech.com/
> 

Hi, Conor

Pll series is accepted, should I need to send a new version about this series?

Best regards,
Changhuang
