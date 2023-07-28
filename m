Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8127660E9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjG1Aua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjG1AuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BEB2D5B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F03061F8E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 729BCC43391;
        Fri, 28 Jul 2023 00:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690505422;
        bh=uyE1GuGyotxu5uZ+CiGivf0Z7+Sg9bi4jahpZlLPd1Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=av6nueV+4Wrg70+X53kYQdEPusecMVf66Ikg92jEATh6HK14T6FJEiMBvYtZIywyU
         9WToTHp3+HZU0tECTjwMh1cg+1wMea57zn+FNdpEe0AdeM4YyNua6Y46uxsCgpqch5
         T+2KMK0tsFTTMCn98cp5sfZXggG4pf/x8pXOkfGilT3ctsTpsPvOWnvLAJSXBjAabj
         9hqAAWWGDBmLlkJgndJFLIk7Scm3QxEZqd7j6Wm3MrRpzl2yL3szrHGYIIuWYwne5X
         azI37uVdqsPk1tR1AHCvMMhVmyubOZm6/IIfdUK2Df5OVlCiQhGGt3G6SIFNi2s+O6
         k0T/jSDwbvy+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61CFAC4166F;
        Fri, 28 Jul 2023 00:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Remove unused declaration dev_restart()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169050542239.6763.13063250287982847828.git-patchwork-notify@kernel.org>
Date:   Fri, 28 Jul 2023 00:50:22 +0000
References: <20230726143715.24700-1-yuehaibing@huawei.com>
In-Reply-To: <20230726143715.24700-1-yuehaibing@huawei.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

On Wed, 26 Jul 2023 22:37:15 +0800 you wrote:
> This is not used, so can remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/linux/netdevice.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] net: Remove unused declaration dev_restart()
    https://git.kernel.org/netdev/net-next/c/d0358c1a37db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


