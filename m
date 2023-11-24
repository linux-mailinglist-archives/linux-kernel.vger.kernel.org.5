Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2147C7F73A8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbjKXMUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjKXMUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:20:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C22DD43
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 04:20:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FD64C433CA;
        Fri, 24 Nov 2023 12:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700828430;
        bh=nhW0XLHwkT4zYDPg0hKKpnPSiom39xmsOL6MXhz6RLo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RQYCf04cVEPC3Do5F3KYMxvtWiB8NFm6p5T45DMaVhbxfBFnKnYjXPjYhv1XoWMls
         3wfLrf6kjaSo27ceoAp/qGpzj7eGmRK08yFP9l7lsiFuRaXyBIQ89ot3chVBVPV+kt
         lQxenbTOmZeDmuy6YprU7XEk1oQJYXJch+h6ZPADmUpVWgRm+nolZFsvedpYUqpRAX
         dm2pOY87yEM6C5lVQFXX2pwzPqnQRI7gVyeBNfm1d2ZKAiGZwfl3PKPb1g2UWQPVnt
         LjHXlM5deSTKefVEEnHSLDH6oJQXDjapYuCYb5qGOLbP8m3tpscCYuUYIP5O/fLSq/
         uhrKQaCzODQZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 053C1E2A02B;
        Fri, 24 Nov 2023 12:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] Get max rx packet length and solve
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170082843001.28500.952047846301067356.git-patchwork-notify@kernel.org>
Date:   Fri, 24 Nov 2023 12:20:30 +0000
References: <20231122183435.2510656-1-srasheed@marvell.com>
In-Reply-To: <20231122183435.2510656-1-srasheed@marvell.com>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hgani@marvell.com, vimleshk@marvell.com, egallen@redhat.com,
        mschmidt@redhat.com, pabeni@redhat.com, horms@kernel.org,
        kuba@kernel.org, davem@davemloft.net, wizhao@redhat.com,
        konguyen@redhat.com, jesse.brandeburg@intel.com, sumang@marvell.com
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

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 22 Nov 2023 10:34:33 -0800 you wrote:
> Patchsets which resolve observed style issues in control net
> source files, and also implements get mtu control net api
> to fetch max mtu value from firmware
> 
> Changes:
> V2:
>   - Introduced a patch to resolve style issues as mentioned in V1
>   - Removed OCTEP_MAX_MTU macro, as it is redundant.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] octeon_ep: Solve style issues in control net files
    https://git.kernel.org/netdev/net-next/c/e40f4c4e50fc
  - [net-next,v2,2/2] octeon_ep: get max rx packet length from firmware
    https://git.kernel.org/netdev/net-next/c/0a5f8534e398

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


