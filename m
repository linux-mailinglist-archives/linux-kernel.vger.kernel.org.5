Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558D37532F7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbjGNHSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbjGNHSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:18:32 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CA72D51;
        Fri, 14 Jul 2023 00:18:30 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id AF7978421;
        Fri, 14 Jul 2023 15:18:22 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 14 Jul
 2023 15:18:22 +0800
Received: from [192.168.120.57] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 14 Jul
 2023 15:18:21 +0800
Message-ID: <43ee3d3f-9ac9-f77b-dc4e-c44705f6efb3@starfivetech.com>
Date:   Fri, 14 Jul 2023 15:18:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/3] dt-bindings: spi: add reference file to YAML
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20230713090015.127541-1-william.qiu@starfivetech.com>
 <20230713090015.127541-2-william.qiu@starfivetech.com>
 <3365c703-5e5c-de7e-3ce3-047c9ac560ee@linaro.org>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <3365c703-5e5c-de7e-3ce3-047c9ac560ee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/13 18:12, Krzysztof Kozlowski wrote:
> On 13/07/2023 11:00, William Qiu wrote:
>> Add primecell.yaml as a refereence file to YAML.
> 
> This we see from the diff, but why you are doing it? Please provide
> rationale and answer to "why" in your commits.
> 
> Also typo: reference.
> 
>> 
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> ---
>>  Documentation/devicetree/bindings/spi/spi-pl022.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
>> index 91e540a92faf..5e5a704a766e 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
>> +++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
>> @@ -11,6 +11,7 @@ maintainers:
>>  
>>  allOf:
>>    - $ref: spi-controller.yaml#
>> +  - $ref: /schemas/arm/primecell.yaml#
>>  
>>  # We need a select here so we don't match all nodes with 'arm,primecell'
>>  select:
> 
> Best regards,
> Krzysztof
> 
I will explain it in next version.

Best regards,
William
