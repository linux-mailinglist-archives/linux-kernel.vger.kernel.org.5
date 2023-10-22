Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A137D22AE
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 12:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjJVKke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 06:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjJVKk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 06:40:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA836126;
        Sun, 22 Oct 2023 03:40:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D51BFC433CA;
        Sun, 22 Oct 2023 10:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697971223;
        bh=uwhNf8Xsz9iBhpFZMXMiQZZAT5BjZv0iz7G3cmV13T0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TWrH9dae2769fwo7H9U5cjDK6+wKIRLw82c8g4195paCZ+J2rUx4BDbOMi9VtC4Jt
         m/YtEU6RvBCvGWpG0ohA8XvOC49dp9QsF24Rp3DLrCGKcNQbnkeT+3n4NPyFohhJJk
         ainixz6Y+QVsaTW3ud6bjGo/24/VOZdAqcB/a+9ZdmkfWD4N8OCKuG+orjeWIrINnd
         YNcP4frKHf/ldjINQim5WycSDxzWq/YUOe1fGQVfk1mu15iHPAkT8f93O1xtjHlRHk
         qj3cPss49MWAe+Oj4+xp4QzNgPnWZgzVka0jYHMLkaC6izktSug5+V0mviq2bC06j+
         mRKQ0emHsmnzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7FC7C04DD9;
        Sun, 22 Oct 2023 10:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: chelsio: cxgb4: add an error code check in
 t4_load_phy_fw
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169797122375.373.14524048379646362591.git-patchwork-notify@kernel.org>
Date:   Sun, 22 Oct 2023 10:40:23 +0000
References: <20231020092758.211170-1-suhui@nfschina.com>
In-Reply-To: <20231020092758.211170-1-suhui@nfschina.com>
To:     Su Hui <suhui@nfschina.com>
Cc:     rajur@chelsio.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 20 Oct 2023 17:27:59 +0800 you wrote:
> t4_set_params_timeout() can return -EINVAL if failed, add check
> for this.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/net/ethernet/chelsio/cxgb4/t4_hw.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - net: chelsio: cxgb4: add an error code check in t4_load_phy_fw
    https://git.kernel.org/netdev/net/c/9f771493da93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


