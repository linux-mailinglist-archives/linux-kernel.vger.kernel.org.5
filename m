Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0409D7E84AA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344849AbjKJUvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbjKJUvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:51:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DAF66005;
        Fri, 10 Nov 2023 10:48:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CEB2C433C7;
        Fri, 10 Nov 2023 18:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699642085;
        bh=3qfKX6VrG+VoTvYxXdQnb45c+J2P4l76pZ2B8pYkpI8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ooUP/eBVKnNyZRlQOHuiExRS6QAaL7R5FSjG8o3A+4FVgn4jWxeh5KFVbZqy4m/UM
         qdCz8osmpST1ILYG/NWP0xF2VuLOtWcFo1+sc0BIQAH0ggZ7qaxk2Sj2oNw1LxaRsk
         XK5xzd1ZQuXSb+0TgPG20kCGy2tiGiLqslHNz68+7Al38aj8mWhPShOHNBxPX6wLMD
         WY49WItLEz7TEY1vNa4QYFomRxqO8ati7B+2sE158VmM7+/Bv8yrvCKXFhntToHyrZ
         UlLIHxDkz3p36v/zaPA1ZTrC+IcVgfp3/Zw3XzTSzzDzmcCJo6x2qRNYgr9ZWUsY8i
         zEmEHoaIJwOUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37D22EAB08C;
        Fri, 10 Nov 2023 18:48:05 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS changes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZUyeqBC1CEFmApgZ@alpha.franken.de>
References: <ZUyeqBC1CEFmApgZ@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUyeqBC1CEFmApgZ@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.7
X-PR-Tracked-Commit-Id: 4b7d3ab445653336db9854eedad812607760c015
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 656d88c3b654c0ccc0ff63aa75101c6c9f0a5300
Message-Id: <169964208522.13214.18392921613361072145.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Nov 2023 18:48:05 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 Nov 2023 09:56:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/656d88c3b654c0ccc0ff63aa75101c6c9f0a5300

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
