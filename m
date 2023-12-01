Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B418004A4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377735AbjLAHU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjLAHUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:20:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76929193
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:20:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07C30C433CA;
        Fri,  1 Dec 2023 07:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701415227;
        bh=4V8u9ZIIwytvKoDoA3nxmOMiLC0tVk9c5+V/JLtyz8g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SOGBcOl7z2z8nKMlcHgh4M9C7MtZ+q2L07boxgszLvfZxE3enOw7IcJi33niBNW6J
         1q48vvOreW0RyfkPVol67XAwSkaS5usCduOyrqDGbv2949V8614eTgLbJ+4g0UiiWt
         LXvxzudOOUntbT1ZoSqx3oEVFyDhpC3U2nCysAJBAnWij26hvUyRLEfImfFEHzjOdr
         izhtwvcp8tIuMvOqGKMW3i00EoOpleT5STp6KXIUNxBr23zgGx5Dt+ra0yk6d6/1cx
         N1Tss6ovVUz5BvTZy7tBUZhwfRT3fjokGKiETMBAnvmjCa5Bd8d+wHHuCX57mMdGaH
         6cau4Ss28qccA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC7D1E19E31;
        Fri,  1 Dec 2023 07:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] support OCTEON CN98 devices
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170141522689.3845.10892409258943079543.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Dec 2023 07:20:26 +0000
References: <20231129045348.2538843-1-srasheed@marvell.com>
In-Reply-To: <20231129045348.2538843-1-srasheed@marvell.com>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hgani@marvell.com, vimleshk@marvell.com, egallen@redhat.com,
        mschmidt@redhat.com, pabeni@redhat.com, horms@kernel.org,
        kuba@kernel.org, davem@davemloft.net, wizhao@redhat.com,
        konguyen@redhat.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Nov 2023 20:53:46 -0800 you wrote:
> Implement device unload control net API required for CN98
> devices and add support in driver for the same.
> 
> Changes:
> V2:
>   - Changed dev_info print to dev_dbg in device_remove API
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] octeon_ep: implement device unload control net API
    https://git.kernel.org/netdev/net-next/c/b77e23f1b03e
  - [net-next,v2,2/2] octeon_ep: support OCTEON CN98 devices
    https://git.kernel.org/netdev/net-next/c/068b2b649fc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


