Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81367C820D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjJMJa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjJMJa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:30:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6080CC0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:30:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EADFAC433C7;
        Fri, 13 Oct 2023 09:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697189424;
        bh=zfKLiUU/AufCJHwWSWrzPG7oidZX9KQ3FzwTiUS/QeQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ESFd132eq0rgvM1vQqVC1SPnM6aEpKXWoBHDvCGj/tSGkIeohsRVbh4OVBmgNR0oo
         dJiYncP0ndiyM9JTsWjfYQ+gu2jDMtWbMgu3MDoABkfdiJg6tW7EoVaSXZNKNpo5Xg
         UvdCRRJNGaS8Xc7SfO+Nr9SskHnNyYkHYcP1J96lpLpfPpz6WjV1HOE+ksvDTNIzph
         G+rd66Xbx93ggz3oY0oIhxJpMukDIu5qclR8+NARJFmjqaRC90CnlBBmyddzbNSz5r
         UxhKR08dNbmm9wAtIDN/v0QThdqI71d12lcHIvL24RmnDXHL1nYhI99RQSWsZXSsYo
         snarzUSSufkdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7684C73FEA;
        Fri, 13 Oct 2023 09:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/1] Add software timestamp capabilities to xen-netback device
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169718942381.12102.14938354463321505614.git-patchwork-notify@kernel.org>
Date:   Fri, 13 Oct 2023 09:30:23 +0000
References: <20231010142630.984585-1-luca.fancellu@arm.com>
In-Reply-To: <20231010142630.984585-1-luca.fancellu@arm.com>
To:     Luca Fancellu <luca.fancellu@arm.com>
Cc:     linux-kernel@vger.kernel.org, wei.liu@kernel.org, paul@xen.org,
        xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
        rahul.singh@arm.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 10 Oct 2023 15:26:29 +0100 you wrote:
> Hi all,
> 
> during some experiment using PTP (ptp4l) between a Dom0 domain and a DomU guest,
> I noticed that the virtual interface brought up by the toolstack was not able
> to be used as ptp4l interface on the Dom0 side, a brief investigation on the
> drivers revealed that the backend driver doesn't have the SW timestamp
> capabilities, so in order to provide them, I'm sending this patch.
> 
> [...]

Here is the summary with links:
  - [1/1] xen-netback: add software timestamp capabilities
    https://git.kernel.org/netdev/net-next/c/0b38d2ec2282

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


