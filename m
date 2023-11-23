Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2252D7F670F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 20:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345811AbjKWTWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 14:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjKWTWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 14:22:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C344B10DD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 11:22:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D90FC433C9;
        Thu, 23 Nov 2023 19:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700767339;
        bh=R6XsSadM5I2yXfIdaPIQgY509tpbrMFgDxEb4kwI94I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hxi1O8Iq7Fh36dXc8H+L2W2SmRulDZoZjizjVeTdbcoXqs9uqbTQyuSm5th9QPCXP
         fEbbOc+PveOQ97Qsa7p1jdXyi+R7Rz58Nh6/UrlR0DeujTFMbXUD+qlV9Zs1OtoN8f
         xJXHTOxhgtKwYOf9ZP3CXWQg8KxdPQ5PSzu0jtAdWB5GoNPNVOKAqxoRk9/9IJbmko
         OrSsnRhn2t1QL6+4wCMTHYnG8IzYICnDxW4d1hOj9IVXfWzyQqhkf+FBJ5BkLmbrQM
         +QKJM/7loigbcS8VS7KhSBvDHYRPQw4gTQGC98GDIkWxSiEcgCMUr3r8mynkwzwVAs
         UJyjIQoZJb09A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B2E4EAA95A;
        Thu, 23 Nov 2023 19:22:19 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.7-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231123171825.957077-1-kuba@kernel.org>
References: <20231123171825.957077-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <bpf.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231123171825.957077-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.7-rc3
X-PR-Tracked-Commit-Id: 39f04b1406b23fcc129a67e70d6205d5a7322f38
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3fa86b1a7b4cdc4367acacea16b72e0a200b3d7
Message-Id: <170076733930.13126.8602329933324976229.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Nov 2023 19:22:19 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com,
        bpf@vger.kernel.org
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Nov 2023 09:18:25 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3fa86b1a7b4cdc4367acacea16b72e0a200b3d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
