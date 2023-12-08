Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430B9809DC2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573394AbjLHH6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235803AbjLHH56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:57:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62BF81FF3;
        Thu,  7 Dec 2023 23:57:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5398911FB;
        Thu,  7 Dec 2023 23:58:05 -0800 (PST)
Received: from [10.57.3.19] (unknown [10.57.3.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2779F3F5A1;
        Thu,  7 Dec 2023 23:57:18 -0800 (PST)
Message-ID: <adf5cfa3-b38c-42b5-a98d-c8738c36737f@arm.com>
Date:   Fri, 8 Dec 2023 07:58:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: Add dynamic-power-coefficient to
 rk3399 GPU
Content-Language: en-US
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     daniel.lezcano@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231127081511.1911706-1-lukasz.luba@arm.com>
 <170198105573.18516.6264175947902125145.b4-ty@sntech.de>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <170198105573.18516.6264175947902125145.b4-ty@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/23 20:30, Heiko Stuebner wrote:
> On Mon, 27 Nov 2023 08:15:11 +0000, Lukasz Luba wrote:
>> Add dynamic-power-coefficient to the GPU node. That will create Energy
>> Model for the GPU based on the coefficient and OPP table information.
>> It will enable mechanism such as DTMP or IPA to work with the GPU DVFS.
>> In similar way the Energy Model for CPUs in rk3399 is created, so both
>> are aligned in power scale. The maximum power used from this coefficient
>> is 1.5W at 600MHz.
>>
>> [...]
> 
> Applied, thanks!

Thank you Heiko!

> 
> [1/1] arm64: dts: rockchip: Add dynamic-power-coefficient to rk3399 GPU
>        commit: 381d48fbada9b5b39f5a811bb8fe76365d6bdd5c
> 
> Best regards,
