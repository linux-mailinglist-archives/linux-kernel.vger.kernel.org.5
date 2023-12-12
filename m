Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B980A80E621
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbjLLI0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346035AbjLLIFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:05:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C791C2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:05:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF2CC433C8;
        Tue, 12 Dec 2023 08:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702368342;
        bh=gpNj8I/75OB5szd1g/dOW3OTP6BzEjuRG5ADKuihkok=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=nMUszGCH9FX8/9eCqx9A1bdo4CS3slOBK6DdDZykUgYpjfoZ2REWvRyC6nlTKEOb/
         fJDYezW6gy/v7bgrLUkKBIiufO4Lug8v62hEzREmON33GkXmd/ZJ7V3PBUjJtPAq2F
         GIAuKFRpx1UarXZIo70yY0xhjPnmCiUMzggVUrsUK2zlrg9x8iKqKZLL+sqrpfjH3p
         hYwt2DvCqLjqWd4zePq4nqJHCVCUGfviuQwFGuuYqxFPiLZZ+9xiZnOCSx/D+OPkqj
         2JtDP/o1UFJAF8Uc96bXP19O5WCU0auyccrc/g689Mei1iCnQmPWre5pfgkre9EIAN
         hwZbwMbKYKYrQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     shitao <shitao@kylinos.cn>
Cc:     gregory.greenman@intel.com, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] net: Fix spelling typo in comment
References: <20231212071935.3098275-1-shitao@kylinos.cn>
Date:   Tue, 12 Dec 2023 10:05:39 +0200
In-Reply-To: <20231212071935.3098275-1-shitao@kylinos.cn> (shitao@kylinos.cn's
        message of "Tue, 12 Dec 2023 15:19:35 +0800")
Message-ID: <87wmtjonfw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shitao <shitao@kylinos.cn> writes:

> Fix spelling typo in iwl-context-info.h comment.
>
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: shitao <shitao@kylinos.cn>
> ---
>  drivers/net/wireless/intel/iwlwifi/iwl-context-info.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The title should start with "wifi: iwlwifi:". Please read our wiki, link
below.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
