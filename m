Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0AF809CFF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbjLHHRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbjLHHRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:17:07 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D241738;
        Thu,  7 Dec 2023 23:17:10 -0800 (PST)
Received: from kwepemd100008.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SmjBT75msz14Lx5;
        Fri,  8 Dec 2023 15:17:05 +0800 (CST)
Received: from [10.67.121.2] (10.67.121.2) by kwepemd100008.china.huawei.com
 (7.221.188.193) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Fri, 8 Dec
 2023 15:17:07 +0800
Message-ID: <6572C2F2.9090202@hisilicon.com>
Date:   Fri, 8 Dec 2023 15:17:06 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Johan Hovold <johan+linaro@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xuwei5@hisilicon.com>
Subject: Re: [PATCH 0/2] arm64: dts: hisilicon: hikey970-pmic: clean up PMIC
 nodes
References: <20231130175635.14251-1-johan+linaro@kernel.org>
In-Reply-To: <20231130175635.14251-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.2]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100008.china.huawei.com (7.221.188.193)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On 2023/12/1 1:56, Johan Hovold wrote:
> When reviewing the various SPMI PMIC bindings, I noticed that several
> examples were incorrect and misleading and could also use some cleanup.
> 
> This series cleans up the hisilicon hikey970 PMIC dtsi which appears to
> have been used as the basis for some of the examples.
> 
> Note that the binding documents "hisilicon,hi6421v600-spmi" while the
> devicetree and driver only uses and recognises "hisilicon,hi6421-spmi".
> I'll leave that as is for now...
> 
> Johan
> 
> 
> Johan Hovold (2):
>   arm64: dts: hisilicon: hikey970-pmic: fix regulator cells properties
>   arm64: dts: hisilicon: hikey970-pmic: clean up SPMI node
> 
>  arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 

Series applied to the HiSilicon arm64 dt tree as the binding part has been applied.
Thanks!

Best Regards,
Wei
