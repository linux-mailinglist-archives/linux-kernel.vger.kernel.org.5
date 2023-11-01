Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284737DDAC4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 02:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377327AbjKAByy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 21:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345095AbjKAByx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 21:54:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E1DF1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 18:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=CVkLC1sx9gTuFay/TuWOx9JFgtPGzbj/HGbezVuslWA=; b=VwHNkv5HgwMTYBDoOPXLUFO8Jx
        qTmOhOSp0nDyEoec9IWws7xVPUw8HpztI39nxnfEd6NoMay2rGxxsHJyTN/EUUKQJtApBRyAvM3Dx
        DyhYuNBZrDAjvDSV5I8PsQ6NddtDewOMQI3jo17ZTpZOQl4BES+0DV3DWNTFdXj4hvlaLvSEszvD7
        T+v+Ut1dEqnosGPJkpw3AQUehxksJI2twqFO4RT0BZbu4tTGqD4aQbV0ZvWRFOoslr+bZ6lsxnnHt
        jRkyCkEkCtjGog1TTAXQ2wp7TiXeVXoeDaUyyhdVrA5m2PptyRUZUn3EKr7C53/JgiTSso8JhqPFo
        SNWafSqQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qy0RR-006Upy-0R;
        Wed, 01 Nov 2023 01:54:45 +0000
Message-ID: <300f32ae-f371-40a1-99e4-71d794e0947a@infradead.org>
Date:   Tue, 31 Oct 2023 18:54:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] mcb: Fix some kernel-doc comments
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, morbidrsa@gmail.com
Cc:     linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20231101014450.78818-1-yang.lee@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231101014450.78818-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/23 18:44, Yang Li wrote:
> Fix some kernel-doc comments to silence the warnings:
> drivers/mcb/mcb-core.c:270: warning: Function parameter or member 'carrier' not described in 'mcb_alloc_bus'
> drivers/mcb/mcb-core.c:336: warning: expecting prototype for mcb_bus_put(). Prototype was for mcb_bus_get() instead
> drivers/mcb/mcb-core.c:463: warning: Function parameter or member 'mem' not described in 'mcb_release_mem'
> drivers/mcb/mcb-core.c:463: warning: Excess function parameter 'dev' description in 'mcb_release_mem'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7105
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/mcb/mcb-core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy
