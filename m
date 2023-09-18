Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF7C7A491B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241826AbjIRMBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241934AbjIRMBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:01:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA08CDB;
        Mon, 18 Sep 2023 05:00:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1FDDC433C9;
        Mon, 18 Sep 2023 12:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695038423;
        bh=Ni0eR8OTKOtQebhcs2oSdkQO4hfRNZ1h4rEUJWi0vE8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eiiuTscW2dccO8+TpLHSgnSNMxZ0JiqNSAMjd8Wos/kboeacJemeHDVTu5FwFp6rn
         iHRFUM1L2lxUJBB0AKk5moSdADBuijcZ3Q0vr5pnjiF1R4NxmXbCHhcLo8nEfv0hkj
         2J73kOE64DXdvNEcz/TBn4aLHhdTsA2L9szhhAxm1uof1o4KG1ABABg1Fj64RH3oZ/
         vceplLqR6Uf5LzH8Re9erFPqGi0uXqFuge2qcp1iOXqSt7jTtedMIiH5m+orgtLLKs
         Kk/NTlCX8MUZoni2puvw8h6zVgTh5L/xcD9ITzICuScGD78mJK27m2sCP5Q1gnOrIQ
         5TFfpZ7VdF1qQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7B0CE11F41;
        Mon, 18 Sep 2023 12:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] ax25: Update link for linux-ax25.org
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169503842374.7731.4777712739974344012.git-patchwork-notify@kernel.org>
Date:   Mon, 18 Sep 2023 12:00:23 +0000
References: <20230917152938.8231-1-peter@n8pjl.ca>
In-Reply-To: <20230917152938.8231-1-peter@n8pjl.ca>
To:     Peter Lafreniere <peter@n8pjl.ca>
Cc:     linux-hams@vger.kernel.org, thomas@osterried.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ralf@linux-mips.org, linux-doc@vger.kernel.org, corbet@lwn.net
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 17 Sep 2023 15:29:44 +0000 you wrote:
> http://linux-ax25.org has been down for nearly a year. Its official
> replacement is https://linux-ax25.in-berlin.de.
> 
> Update all references to the dead link to its replacement.
> 
> As the three touched files are in different areas of the tree, this is
> being sent with one patch per file.
> 
> [...]

Here is the summary with links:
  - [1/3] Documentation: netdev: fix dead link in ax25.rst
    https://git.kernel.org/netdev/net/c/418f438a2db6
  - [2/3] MAINTAINERS: Update link for linux-ax25.org
    https://git.kernel.org/netdev/net/c/1943f2b0ac5a
  - [3/3] ax25: Kconfig: Update link for linux-ax25.org
    https://git.kernel.org/netdev/net/c/71273c46a348

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


