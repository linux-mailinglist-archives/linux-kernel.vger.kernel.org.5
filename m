Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EDF7B1C82
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjI1MdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjI1MdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:33:13 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBC519B;
        Thu, 28 Sep 2023 05:33:10 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id E73527FFD;
        Thu, 28 Sep 2023 20:33:06 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 28 Sep
 2023 20:33:06 +0800
Received: from [192.168.125.95] (113.72.144.128) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 28 Sep
 2023 20:33:05 +0800
Message-ID: <2c7913e1-79a0-87cc-4a2d-b8a5b6e94c09@starfivetech.com>
Date:   Thu, 28 Sep 2023 20:33:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2] MAINTAINERS: Add Hal as one of the maintainers of
 SFCTEMP HWMON DRIVER
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-hwmon@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230928075249.109459-1-hal.feng@starfivetech.com>
 <dc5e9253-5d82-4def-b6ff-038b29bf99ab@roeck-us.net>
Content-Language: en-US
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <dc5e9253-5d82-4def-b6ff-038b29bf99ab@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.128]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2023 04:43:33 -0700, Guenter Roeck wrote:
> On Thu, Sep 28, 2023 at 03:52:49PM +0800, Hal Feng wrote:
>> As he is the submitter of this driver, add his mail so he can
>> maintain the driver and easily reply in the mailing list.
>> 
>> Acked-by: Emil Renner Berthing <kernel@esmil.dk>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>> 
>> History:
>> v1: https://lore.kernel.org/all/20230718034937.92999-4-hal.feng@starfivetech.com/
> 
> The change log should describe your changes, not just point to earlier
> versions of your patch. Please do not expect maintainers to fetch old
> versions of your patches and compare them manually.
> 
> Did anything change besides the Acked-by: ?

The commit title was reworded in v2.
There are no other changes besides this. Thanks.

Best regards,
Hal

> 
>> 
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b19995690904..2376272bbe20 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19402,6 +19402,7 @@ F:	drivers/net/ethernet/sfc/
>>  
>>  SFCTEMP HWMON DRIVER
>>  M:	Emil Renner Berthing <kernel@esmil.dk>
>> +M:	Hal Feng <hal.feng@starfivetech.com>
>>  L:	linux-hwmon@vger.kernel.org
>>  S:	Maintained
>>  F:	Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml
>> 
>> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
>> -- 
>> 2.38.1
>> 

