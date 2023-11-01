Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18577DDAC5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 02:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377331AbjKAB5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 21:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345105AbjKAB5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 21:57:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC3EED
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 18:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=EgIPcTAPlxyJtJVud039zf/Gp243UGq8Gi+QrKcTMCM=; b=4zr9VwOw/Wo8HxMo1lqqphZAiL
        bk7YNWdJgXdJNnkMJSeG1AcKFEIRgQL47cmZucZdYopFp5yrmuh/L4zfwPTK2wIOwGPl5oLl2gx1/
        6Bcdu/6U0c0kDMLWyfcEgNlDNApOtpHLaeaAQVPAqoEglSKjiFRuQszp05uOJ5LZy7Gm2ytKGQ8mN
        fMBNnzSjS7jdH1kcm/1JyGRG9QJA8O/8t7X5uZV1uIUyWvGp0lx0ru3dWs6kCLlzsjvwFAAx2Qoyj
        7bTbYzizxhtl3Q9Z8Xa+jLB8GbYy8lNa6Y4vofX1onkwjoBWAX4HqToq+t2f+LQ6uXCMVzO98mmOL
        Pte1sFSA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qy0Tj-006Ux3-1e;
        Wed, 01 Nov 2023 01:57:07 +0000
Message-ID: <8989aa9d-dbd1-496c-977b-8dcd3ce1610f@infradead.org>
Date:   Tue, 31 Oct 2023 18:57:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] clocksource: Fix some kernel-doc comments
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, daniel.lezcano@linaro.org,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20231101015220.95186-1-yang.lee@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231101015220.95186-1-yang.lee@linux.alibaba.com>
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



On 10/31/23 18:52, Yang Li wrote:
> Fix some kernel-doc comments to silence the warnings:
> drivers/clocksource/timer-ti-dm.c:193: warning: Function parameter or member 'val' not described in 'dmtimer_write'
> drivers/clocksource/timer-ti-dm.c:193: warning: Excess function parameter 'value' description in 'dmtimer_write'
> drivers/clocksource/timer-ti-dm.c:958: warning: Function parameter or member 'cookie' not described in 'omap_dm_timer_set_int_disable'
> drivers/clocksource/timer-ti-dm.c:958: warning: Excess function parameter 'timer' description in 'omap_dm_timer_set_int_disable'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7106
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/clocksource/timer-ti-dm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy
