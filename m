Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710857EEA55
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 01:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbjKQAa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 19:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjKQAa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 19:30:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E525129
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 16:30:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F4BCC433C9;
        Fri, 17 Nov 2023 00:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700181023;
        bh=Yqv09rGhaUaYgK5vZCOHhlvSmzXMImOrHdpooNV5yc0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=H6Mxve89lopGJIXFMO1graP547/bH5woC6qn+PNOg2sha6QtOgEszdFiXnfN4Qap0
         ItwbHhT9DQc8dKX+7DfHzM3uBibv5eqOrS9mUbsV1tbjaxr2Zbx8OkfVIKHuW0z7GJ
         JKJH6bIF+ERZ5HKafurPRrN34K53BDz1JBAAUk7+ymZyfqN25P9WuzPmKpMuxv2VM9
         BaPy5/wkX4D0AUIpHM9OOjmFBjEQGfuoGNvpsyGTN8ePcHRIVNFSwAZUj0S4oAp15T
         k1u8/zDxL8Iwen6B/Pfe1/tMPLc9ZTgq/f/Zrh5XfaFRrrJeEMtU4cZCiTc8om9Fvd
         wSr0V1HVYoDUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC19AE00090;
        Fri, 17 Nov 2023 00:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rxrpc: Fix some minor issues with bundle tracing
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170018102296.11691.4713872724696133068.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Nov 2023 00:30:22 +0000
References: <3939793.1700068540@warthog.procyon.org.uk>
In-Reply-To: <3939793.1700068540@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, marc.dionne@auristor.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 15 Nov 2023 17:15:40 +0000 you wrote:
> Fix some superficial issues with the tracing of rxrpc_bundle structs,
> including:
> 
>  (1) Set the debug_id when the bundle is allocated rather than when it is
>      set up so that the "NEW" trace line displays the correct bundle ID.
> 
>  (2) Show the refcount when emitting the "FREE" traceline.
> 
> [...]

Here is the summary with links:
  - [net] rxrpc: Fix some minor issues with bundle tracing
    https://git.kernel.org/netdev/net/c/0c3bd086d12d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


