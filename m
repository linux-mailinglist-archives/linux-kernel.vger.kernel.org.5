Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322F77F9F6C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbjK0MUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjK0MUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:20:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F174910F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:20:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93D7AC433C9;
        Mon, 27 Nov 2023 12:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701087625;
        bh=2xL/uJq6qI8TQ3qq2PiEINw1Ueax4X6ay/YZyvpjaWI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tYVnsgfuHt1Z2m4uLjWHgJmiqHaFj0WJ6yLBScYenEScmFpLZxk7nGC8pct1Cn4om
         f8+6yCkpwuv3nyo0Pz5Okc03wFiZbSH5Nbo8DcQvtiJfW1Gmu3QsnH25pQ9m+EOyh+
         oIxhBcyisB41B8n3phJyKyfy+HtjEwbjgSBSsaXa7EErWQrITQsnCUuPZOHJx2sS+d
         T9+V3pDxMWIYVKRFkIDItYG8rbszq47W0FwpSNlHEjQrGbH+KuynX/OZGIyeVmilTS
         OQUAlPwK+cSgQF5iAKoX9i8kePY01KCG/Eu+EBIBXj4vxw6W6hQ6VLkl2rPsA+kufB
         V6HD1jVgXIJfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 786E7E1F66D;
        Mon, 27 Nov 2023 12:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net :mana :Add remaining GDMA stats for MANA to ethtool
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170108762548.32093.15380933168923149331.git-patchwork-notify@kernel.org>
Date:   Mon, 27 Nov 2023 12:20:25 +0000
References: <1700830950-803-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: <1700830950-803-1-git-send-email-shradhagupta@linux.microsoft.com>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        sharmaajay@microsoft.com, leon@kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
        mikelley@microsoft.com, shradhagupta@microsoft.com
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
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 24 Nov 2023 05:02:30 -0800 you wrote:
> Extend performance counter stats in 'ethtool -S <interface>'
> for MANA VF to include all GDMA stat counter.
> 
> Tested-on: Ubuntu22
> Testcases:
> 1. LISA testcase:
> PERF-NETWORK-TCP-THROUGHPUT-MULTICONNECTION-NTTTCP-Synthetic
> 2. LISA testcase:
> PERF-NETWORK-TCP-THROUGHPUT-MULTICONNECTION-NTTTCP-SRIOV
> 
> [...]

Here is the summary with links:
  - net :mana :Add remaining GDMA stats for MANA to ethtool
    https://git.kernel.org/netdev/net-next/c/e1df5202e879

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


