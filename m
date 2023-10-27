Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7BD7D8E2A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 07:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345160AbjJ0Fae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 01:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJ0Faa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 01:30:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F0D1A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 22:30:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2292C433C9;
        Fri, 27 Oct 2023 05:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698384627;
        bh=4CWjoHhCr3X2E7xAcEv+eOauN9xR9PQxvGnRuz2M7f8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Rvo5n6JlM9HkL9tiR+YtYBZ8lPs+RHHIi0KI1Vi/29KjTcfOxA0s2CFZr1Kk3Y6Be
         MRR/kaTyZxgB+8oS2X6GtY68YMPIehmu0rLdQq4c0A8W2maXBwEwmTq3iigujAsFy0
         2I+BT31EfZ8YT45VBR4SZAlWRz5T/i2wQA3Tx0Tieou+aqYfzvWtwDyP0SJmITdIWQ
         /E2yN5wQiDkUv4D0ThQzW30pl4NzX19jmE+HWgXQLh7WoZrGTn9dUscIVSJvS8QZq9
         Mp4vedvUz1sP5zQmuY6Xa2IpSt/poUBrNjLdgRBZ6OQU/smRloj1ixTQNLgtnh05dt
         QlCQVeLp9/r4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA816E4CC0F;
        Fri, 27 Oct 2023 05:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] MAINTAINERS: Remove linuxwwan@intel.com mailing list
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169838462775.19664.12297909147407168362.git-patchwork-notify@kernel.org>
Date:   Fri, 27 Oct 2023 05:30:27 +0000
References: <20231025130332.67995-2-bagasdotme@gmail.com>
In-Reply-To: <20231025130332.67995-2-bagasdotme@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
        johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Oct 2023 20:03:32 +0700 you wrote:
> Messages submitted to the ML bounce (address not found error). In
> fact, the ML was mistagged as person maintainer instead of mailing
> list.
> 
> Remove the ML to keep Cc: lists a bit shorter and not to spam
> everyone's inbox with postmaster notifications.
> 
> [...]

Here is the summary with links:
  - [net,v3] MAINTAINERS: Remove linuxwwan@intel.com mailing list
    https://git.kernel.org/netdev/net-next/c/cc54d2e2c58a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


