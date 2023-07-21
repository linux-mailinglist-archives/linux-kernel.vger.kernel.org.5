Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC95675BCC6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 05:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjGUDYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 23:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGUDYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:24:20 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB552729;
        Thu, 20 Jul 2023 20:24:18 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 226E28071;
        Fri, 21 Jul 2023 11:24:16 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Jul
 2023 11:24:16 +0800
Received: from [192.168.125.94] (113.72.147.86) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Jul
 2023 11:24:15 +0800
Message-ID: <e63baeee-134c-db4f-f350-b3526a0ae571@starfivetech.com>
Date:   Fri, 21 Jul 2023 11:24:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 3/3] MAINTAINERS: Add Hal as a maintainer of SFCTEMP
 HWMON DRIVER
To:     Conor Dooley <conor@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230718034937.92999-1-hal.feng@starfivetech.com>
 <20230718034937.92999-4-hal.feng@starfivetech.com>
 <20230718-progeny-edge-70b1a395f2aa@spud>
Content-Language: en-US
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <20230718-progeny-edge-70b1a395f2aa@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.86]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 15:20:15 +0100, Conor Dooley wrote:
> On Tue, Jul 18, 2023 at 11:49:37AM +0800, Hal Feng wrote:
>> As he is the submitter of this driver, add his mail so he can
>> maintain the driver and easily reply in the mailing list.
>> 
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index aee340630eca..5056079ade77 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19256,6 +19256,7 @@ F:	drivers/net/ethernet/sfc/
>>  
>>  SFCTEMP HWMON DRIVER
>>  M:	Emil Renner Berthing <kernel@esmil.dk>
>> +M:	Hal Feng <hal.feng@starfivetech.com>
>>  L:	linux-hwmon@vger.kernel.org
>>  S:	Maintained
>>  F:	Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml
> 
> Whatever about the other patches in this series, this one certainly
> needs an Ack from Emil.

Hi @Emil,

Would you mind adding me as one of the maintainers of this driver?
Within StarFive, I was appointed to maintain this driver.

Best regards,
Hal
