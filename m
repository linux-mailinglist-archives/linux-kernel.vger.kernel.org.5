Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84D67F2915
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjKUJk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjKUJk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:40:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A4ECB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:40:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFF62C433C7;
        Tue, 21 Nov 2023 09:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700559623;
        bh=GKaCEsuN2a26DWqLwo7f7sJIvXyNSbixPwgr7S2T4oQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KukXidsWExih6YhB33+yRukb6Bb79ecm3ZWnata59gdf+38j1It0/VBZApn/YYlii
         jiEk7iemmTDEuWBazjo9w0QWVKqk2fitcUfdqsAncFc10VfWOzXHgUaV1C7UXsKEtt
         c40sv8s657jktZH3GIqQRX6bezDyERC8v1xdBHewbMFSA4P9iWkmfoX3VuX3ofdzP9
         oMFi9j+5SXpNGnhxv7b5KnOAidSZyW8CB7s88Au/NY3arVsh/MBCFkeDAE51pWkwms
         1NL6pKqp6B/tf+wfHj+lFnyN9xDg30TvjguPxhARjP4c6+o5nSOI9uGaEmlp3YyLf/
         5Hrqme9YexaTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 951B1EAA955;
        Tue, 21 Nov 2023 09:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] octeon_ep: support Octeon CN10K devices
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170055962360.22415.12175732590141368949.git-patchwork-notify@kernel.org>
Date:   Tue, 21 Nov 2023 09:40:23 +0000
References: <20231117103817.2468176-1-srasheed@marvell.com>
In-Reply-To: <20231117103817.2468176-1-srasheed@marvell.com>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hgani@marvell.com, vimleshk@marvell.com, egallen@redhat.com,
        mschmidt@redhat.com, pabeni@redhat.com, horms@kernel.org,
        kuba@kernel.org, davem@davemloft.net, wizhao@redhat.com,
        konguyen@redhat.com, edumazet@google.com, corbet@lwn.net,
        vburru@marvell.com, sedara@marvell.com
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

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 17 Nov 2023 02:38:10 -0800 you wrote:
> Add PCI Endpoint NIC support for Octeon CN10K devices.
> CN10K devices are part of Octeon 10 family products with
> similar PCI NIC characteristics. These include:
> - CN10KA
> - CNF10KA
> - CNF10KB
> - CN10KB
> 
> [...]

Here is the summary with links:
  - [net-next,v1] octeon_ep: support Octeon CN10K devices
    https://git.kernel.org/netdev/net-next/c/0807dc76f3bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


