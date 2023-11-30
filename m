Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9187FFF91
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377350AbjK3Xjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377315AbjK3Xjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:39:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A908010FF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:39:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AE9FC433C7;
        Thu, 30 Nov 2023 23:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701387583;
        bh=06C2Lx7+yfSbvlgL1dhTE1txCo//HLv4ilk8l0a5G8A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WtsBl10NAqC04N7oDNxRnrktq49Uh3lc3GeevKRO9mXuWb+O5ZavBpHtAsyDmRPc5
         LkqiZSjf6LLWwEJ+VldjvppX8oGJ3WxrAPSnGZORWC6Vtlo7yHZbgWbpI4QNRaPTxo
         dlSjI6sTW9jsQc8l6rnyiU8gns2ZhXtF4/jF+fiEUvgN9gnrcHHx1mcgd0uBQBW6T6
         ArP0gQwZ3aTGaX6+S+106Ktu/ru+5BZs6siVpZ4g1bkeYKN9GipgufZqWh7c1sc8E3
         hrWokSQ96CG2BhFclTGun8nUALXX748g8X+wMSYh2xEK1l5VGk3cnJamwma2cTv2N1
         n03unuwxM/WBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59805C64459;
        Thu, 30 Nov 2023 23:39:43 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.7-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231130125638.726279-1-pabeni@redhat.com>
References: <20231130125638.726279-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231130125638.726279-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.7-rc4
X-PR-Tracked-Commit-Id: 777f245eec8152926b411e3d4f4545310f52cbed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6172a5180fcc65170bfa2d49e55427567860f2a7
Message-Id: <170138758335.26468.17756075344747602504.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Nov 2023 23:39:43 +0000
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 Nov 2023 13:56:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.7-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6172a5180fcc65170bfa2d49e55427567860f2a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
