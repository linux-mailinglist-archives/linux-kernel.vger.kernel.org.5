Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262B1760CB4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjGYILi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjGYILf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:11:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422881B5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:11:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A47BD614BF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08853C433C9;
        Tue, 25 Jul 2023 08:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690272693;
        bh=Hsq1BTa1Ec9/kLW6xNjo47BpeAL4q6A/z/L6FcGo7uo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iMcHIcH3D0wstzCnp9RZxEgaYKp3otMecmcbhmGPEvPJADMWfLaNzjAKGl2j2Y8k/
         rY/8rKYj+8F6BCwN9LQmKuwJNZNpLurtzMXOxHkGZgKy5cPkqQN5UeSKhRunAZBii+
         QvqCqgp10Hnm0aocsPQU6siC8ylQYyvA19E2PN4pn5DJ3/PJRYqEXZQLhqmW6NMphA
         /Ivh2Y7I3uhnZ1h8eXJReXbjlm4ThwoltgwgM3LgbxrQW96XS1xWZLSFqXbuIRVcns
         hJmPIfwxZWTEto94RUjP7c9ThLJC0MkcgWsTfH3i7ffD76JoXwh/oxjET9quMJf/6y
         0syx/nQQmoN3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E06A7C4166D;
        Tue, 25 Jul 2023 08:11:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH V4] octeontx2-af: Install TC filter rules in hardware
 based on priority
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169027269291.22574.17481774547860913294.git-patchwork-notify@kernel.org>
Date:   Tue, 25 Jul 2023 08:11:32 +0000
References: <20230721043925.2627806-1-sumang@marvell.com>
In-Reply-To: <20230721043925.2627806-1-sumang@marvell.com>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lcherian@marvell.com,
        jerinj@marvell.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

On Fri, 21 Jul 2023 10:09:25 +0530 you wrote:
> As of today, hardware does not support installing tc filter
> rules based on priority. This patch adds support to install
> the hardware rules based on priority. The final hardware rules
> will not be dependent on rule installation order, it will be strictly
> priority based, same as software.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net-next,V4] octeontx2-af: Install TC filter rules in hardware based on priority
    https://git.kernel.org/netdev/net-next/c/ec87f05402f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


