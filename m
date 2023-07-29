Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E63D767B5A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 03:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjG2BuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 21:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjG2BuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 21:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B2F2D64
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6CDC6222A
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 01:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4799FC433CD;
        Sat, 29 Jul 2023 01:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690595421;
        bh=LMcp1a1s8qDtBGSPyAtT7+g+htivmWZE2NAPXNW3AzE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Nmcm3ncEXD5O3gyt0kwMCMTwlWsxxEJGGDr3EkfZsGY6DjBngP6qjFPlKxpvvNQlf
         87kyw5GKCcj/Boccxfhbk6bhmyo3lInDurwDSRYCC1PNwlzvCGzqZiYWXz/c6cyyJt
         fq48z2y9kFpO0ZmB2SGRpJswUAK0/xq/zjvIWUio36ZJoE1vtFYuLIWDoHFmAlxXnx
         0QzaL/+dhdpCU17irv2O2nsIZMQu0j18D/LJmVVOdGxqLZNtZuLjBZBpMqmEgrekvL
         OYTSwvIvaqLMVLDquUAIMQgXNvSgH0jbK8jaGc9TxvLVfhDcSuFp92F4EvkI/j6sdw
         WiSRl+pPvZKhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16047E21EC9;
        Sat, 29 Jul 2023 01:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] bonding: 3ad: Remove unused declaration
 bond_3ad_update_lacp_active()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169059542108.13127.13317059978744090243.git-patchwork-notify@kernel.org>
Date:   Sat, 29 Jul 2023 01:50:21 +0000
References: <20230726143816.15280-1-yuehaibing@huawei.com>
In-Reply-To: <20230726143816.15280-1-yuehaibing@huawei.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jon.toppins+linux@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, liuhangbin@gmail.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jul 2023 22:38:16 +0800 you wrote:
> This is not used since commit 3a755cd8b7c6 ("bonding: add new option lacp_active")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: fix patch prefix
> ---
>  include/net/bond_3ad.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [v2,net-next] bonding: 3ad: Remove unused declaration bond_3ad_update_lacp_active()
    https://git.kernel.org/netdev/net-next/c/61c5145317a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


