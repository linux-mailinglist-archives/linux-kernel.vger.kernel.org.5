Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A681777A58
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbjHJOTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjHJOTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:19:42 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CA726A9;
        Thu, 10 Aug 2023 07:19:42 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37AEJYFl070956;
        Thu, 10 Aug 2023 09:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691677174;
        bh=bZFgo1Q1iWMFb1mgLk6e/IlLHynwF+vYdXC4cRZedGI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=vytazR/eRukdrHD1cMf52Im97re5q/MAgNGWjblU/rsz1bXWv9l/+PDClst6NAlfb
         iiBc7bqhHU+hdtrz6fnuuBtiDQ5628a+XMznkxUtAxEmSXhknF2B014rJdnT1Xl5cJ
         M5UjFGGFUBv188k0nnzGRegA7pK4WPUK1MkPdL4w=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37AEJYrn082473
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 09:19:34 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 09:19:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 09:19:33 -0500
Received: from [10.249.141.75] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37AEJSs6026804;
        Thu, 10 Aug 2023 09:19:29 -0500
Message-ID: <6ec58e9c-0661-cb97-b133-cdcc40d4e4f0@ti.com>
Date:   Thu, 10 Aug 2023 19:49:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-j7200: Add the supported
 frequencies for A72
To:     Nishanth Menon <nm@ti.com>
CC:     Apurva Nandan <a-nandan@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Keerthy J <j-keerthy@ti.com>,
        <u-kumar1@ti.com>
References: <20230809173905.1844132-1-a-nandan@ti.com>
 <20230809173905.1844132-3-a-nandan@ti.com>
 <20230809190943.unpcbrinyn5ppei7@hydrated>
 <ab69c4df-708f-8fff-a58b-a6531e15627b@ti.com>
 <20230810125327.pq2fxda7dpv2qf7t@seizing>
Content-Language: en-US
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230810125327.pq2fxda7dpv2qf7t@seizing>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/10/2023 6:23 PM, Nishanth Menon wrote:
> On 17:23-20230810, Kumar, Udit wrote:
> [..]
>>>> +		opp1-750000000 {
>>>> +			opp-hz = /bits/ 64 <750000000>;
>>>>    		};
>>>>    	};
>>>> -- 
>>>> 2.34.1
>>>>
>>> [..]
>>> This wont work:
>>>
>>> a) in u-boot's falcon boot mode and puts unrelated responsibility to
>>> bootloader (u-boot is not the only bootloader in the party here).
>>> b) Further, the reason for doing the opp detection in the kernel is
>>> due to the severity of consequence of attempting to run a lower rated
>>> chip at higher frequency - PoH (Power on Hours) or physical damage can
>>> result.
>>> c) Finally, in a virtualized environment: TISCI will get DM (Device
>>> Manager) to arbitrate between the each of the VM's request, but if
>>> the VM's are'nt self sufficient, we will have DM making wrong choices
>>> resulting in (b) condition again.
>>>
>>> This is the reason why drivers/cpufreq/ti-cpufreq.c exists and all SoCs
>>> that have OPPs from TI is handled in the kernel itself.

Thanks to pointing to this driver.

