Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320247EEB90
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 05:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjKQDu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 22:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQDu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 22:50:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80139D4E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 19:50:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF577C433CA;
        Fri, 17 Nov 2023 03:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700193024;
        bh=Bz+3K/MHbKM0UUanhKp7PB+9oqrK2L5Zjsk4+1NL9Bo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EfNLBcqL+DWJOD1qevRxUkOoeXqIm0ZASOVL5miRebNHEvaDvsp9cbjbOAi1rkDg8
         6iJ8JS6s9kbIhiy/vYTsIjrT8k0kzfTEjOX6D8aI1JzEMXvUvuOIbQTTHy1Ouv5gj5
         umKsbGyU04Vu/tQ+yqtJhg3pBkID+ZpJiHZiXuzAhZxGZIkYT0oe2QQK05fsJTF57P
         75iyYkd4SP6y1DqfBvrDY5aPsVLtjno7ebdCBtXpx+eKpywtlCVCg8cbJKmf7zPVnP
         6zgpy1BFBryufT9O3SO1Zm9E5IjLxYnpXCdpDlPjsU3W2TttvjLtrycPUCK179farv
         Nl0SlOtUPdXCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5F11E1F662;
        Fri, 17 Nov 2023 03:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Add netdev subsystem profile link
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170019302387.26330.13198114627054170018.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Nov 2023 03:50:23 +0000
References: <20231116201147.work.668-kees@kernel.org>
In-Reply-To: <20231116201147.work.668-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 16 Nov 2023 12:11:51 -0800 you wrote:
> The netdev subsystem has had a subsystem process document for a while
> now. Link it appropriately in MAINTAINERS with the P: tag.
> 
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: Add netdev subsystem profile link
    https://git.kernel.org/netdev/net/c/76df934c6d5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


