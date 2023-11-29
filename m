Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EEF7FCC77
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 02:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376730AbjK2B7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 20:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK2B7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 20:59:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FAB10E2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 17:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=8glzdTPYgTI0y+U4Mt5JkgK5DlQNn3/9kenL4aSzC2Q=; b=g7/UMnMDYMPQbMuEylC0HwcoPZ
        5PVoHxbeURq/j2DZkokv87c3jKDFwpnYu9TELW2Sik57k3Enn2PACp7NrIByjCDNxdzQop5kQAqXf
        23jPOJIEGMHpsfFeridvDfDpr4cf61PnrkMSooJSQU9n+9Sr3As9MSRGsIeP0RfyTI2+0tIBC/gJa
        iXIeUE2FrYNjq3/X8ys4BSags01ktKKf2nmd79l/F++eNuo/TTCyJLRXRtMnhNUUjqw1U87dEOuYZ
        HpJOGBu93SPwiu/WWooLIS9WOqMFIacd8wJjhJ7ZJlypSa/5oL0142JfFU84AdHMieOTWLeJO0xOW
        O2Y11XJg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r89rL-006o7L-14;
        Wed, 29 Nov 2023 01:59:28 +0000
Message-ID: <57aa904f-ee17-419a-9e4c-f0297da73629@infradead.org>
Date:   Tue, 28 Nov 2023 17:59:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: fix comment typos
Content-Language: en-US
To:     zhongkaihua <zhongkaihua@kylinos.cn>, cw00.choi@samsung.com,
        krzysztof.kozlowski@linaro.org, lee@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     huangwei@kylinos.cn, zhang.chen@cs2c.com.cn,
        k2ci <kernel-bot@kylinos.cn>
References: <20231129015526.3302865-1-zhongkaihua@kylinos.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231129015526.3302865-1-zhongkaihua@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/23 17:55, zhongkaihua wrote:
> From: Kaihua Zhong <zhongkaihua@kylinos.cn>
> 
> Fix four comment typos in mfd pmic header files.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Kaihua Zhong <zhongkaihua@kylinos.cn>


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/linux/mfd/max77693-private.h | 2 +-
>  include/linux/mfd/max77843-private.h | 2 +-
>  include/linux/mfd/si476x-platform.h  | 2 +-
>  include/linux/mfd/tps65910.h         | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 

-- 
~Randy
