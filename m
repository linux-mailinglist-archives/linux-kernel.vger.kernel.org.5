Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06807691BE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjGaJaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjGaJa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:30:26 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EA712D;
        Mon, 31 Jul 2023 02:30:23 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36V9SicD009389;
        Mon, 31 Jul 2023 11:30:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=h/GRgi2ailuju1SMd2b9nm0JKLl8dc58k4ePkEFhp+w=; b=3n
        7T8eyElteFmOSi/jGLVEKOOlZ3SGkA39+BesE42g+lH/yQfMiqolbcmcn15+yuLf
        aeHYYPdqIwFDNVKG1VLZpdXFRyTaHnR2kpfeMTA3io17WRWcErSyDy7EAWrPH/QO
        u2/7dpydVlgF28yaWiHrLBpsKc2qdcVjnhKUOyeqQi193Nuoz5X9N8W/qgwjW2kv
        KsNI3a8TVSPGrWZH+9qm7clDpE06InsbP6/r/Ws+AooHgjblmsSRf3T8hc48mkYp
        Nifuz41R9bvuw0sM2WrG9TXdCGAZ5retA+uPsEZHBqSoA0qaHfVY9LSs2P/xQ74J
        8hsqmIwKrwQnIdxnY96Q==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3s50ng08db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 11:30:06 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6D036100034;
        Mon, 31 Jul 2023 11:30:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6472321D3D0;
        Mon, 31 Jul 2023 11:30:04 +0200 (CEST)
Received: from [10.129.166.114] (10.129.166.114) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 31 Jul
 2023 11:30:03 +0200
Message-ID: <f8ac8d99-f6fa-2073-4610-3ed845e18da9@foss.st.com>
Date:   Mon, 31 Jul 2023 11:30:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] media: dt-bindings: drop unneeded status from examples
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        <linux-tegra@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230725101625.75162-1-krzysztof.kozlowski@linaro.org>
 <e8138fd1-5d1f-8fc3-e29a-547902c2ab18@foss.st.com>
 <30d0689f-5a6a-c593-2a30-1ef2dc37f1af@linaro.org>
Content-Language: en-US
From:   Benjamin Mugnier <benjamin.mugnier@foss.st.com>
In-Reply-To: <30d0689f-5a6a-c593-2a30-1ef2dc37f1af@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.129.166.114]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_03,2023-07-26_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/23 08:33, Krzysztof Kozlowski wrote:
> On 25/07/2023 12:55, Benjamin Mugnier wrote:
>> Hi Krzysztof,
>>
>> Thank you for your patch.
>>
>> For the st-mipid02 :
>> Reviewed-By: Benjamin Mugnier <benjamin.mugnier@foss.st.com>
> 
> I don't think we have half-reviews. There are half-acks, but not reviews.
> 
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L542
> 
> Best regards,
> Krzysztof
> 

I was not aware of this, thanks for pointing it to me.

For the st-mipid02 :
Acked-By: Benjamin Mugnier <benjamin.mugnier@foss.st.com>

-- 
Regards,

Benjamin
