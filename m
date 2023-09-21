Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0DF7AA0AD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjIUUqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjIUUqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:46:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAB7900C9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:50:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3B48C433C9;
        Thu, 21 Sep 2023 19:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695325852;
        bh=E6x7SzGWbNo4DVxdtDEQxsEliE9ytgunUOU+75zgppQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EGmuBVxVTBUKU4Nn+v9hddHoGZV/TmWRxwB1p9pd5CCMsqLV2SuyeURylf9vkJ8B0
         cBLCGhXStWgsP6B4lrJwCOuM+ATssYsm2B2uKtJUNyrI88sN3qYwOwBQ0vbFcXxgvJ
         8Zj4/4W1U9dRsv7Boeh8pKuUTA4dRxfVRGbWaBIOpWEuLHoVtJEv1ppwkA5ruGq201
         L+L45aUj/BOaJ+4eaVdMENdwISZXcaQgiYrTXRdxVbxiYQfkmPGWAH7XCRStndd+5D
         KJPyJl6NoXX0XG+Y+KXX7b1VWFMpmpjoXCh/zliKnpyamFzGkCRLch8UzyiXaFZbK8
         bvvS9akocUuXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9ACCDE11F5C;
        Thu, 21 Sep 2023 19:50:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for 6.6-rc3
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169532585262.6364.13276493763831033599.git-patchwork-notify@kernel.org>
Date:   Thu, 21 Sep 2023 19:50:52 +0000
References: <20230921113117.42035-1-pabeni@redhat.com>
In-Reply-To: <20230921113117.42035-1-pabeni@redhat.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu, 21 Sep 2023 13:31:17 +0200 you wrote:
> Hi Linus!
> 
> The following changes since commit 9fdfb15a3dbf818e06be514f4abbfc071004cbe7:
> 
>   Merge tag 'net-6.6-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-09-14 10:03:34 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for 6.6-rc3
    https://git.kernel.org/netdev/net/c/27bbf45eae9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


