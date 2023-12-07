Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC0E80865D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378689AbjLGLGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjLGLGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:06:52 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C583E9;
        Thu,  7 Dec 2023 03:06:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05C0A12FC;
        Thu,  7 Dec 2023 03:07:45 -0800 (PST)
Received: from [10.57.6.119] (unknown [10.57.6.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FB0A3F762;
        Thu,  7 Dec 2023 03:06:57 -0800 (PST)
Message-ID: <c5c6f169-e021-43c5-a478-21bfbdada554@arm.com>
Date:   Thu, 7 Dec 2023 11:07:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: Add dynamic-power-coefficient to
 rk3399 GPU
To:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, conor+dt@kernel.org, daniel.lezcano@linaro.org
References: <20231127081511.1911706-1-lukasz.luba@arm.com>
Content-Language: en-US
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231127081511.1911706-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/23 08:15, Lukasz Luba wrote:
> Add dynamic-power-coefficient to the GPU node. That will create Energy
> Model for the GPU based on the coefficient and OPP table information.
> It will enable mechanism such as DTMP or IPA to work with the GPU DVFS.
> In similar way the Energy Model for CPUs in rk3399 is created, so both
> are aligned in power scale. The maximum power used from this coefficient
> is 1.5W at 600MHz.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 


Gentle ping. What's the status of this?
