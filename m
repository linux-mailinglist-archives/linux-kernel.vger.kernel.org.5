Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FA77A3218
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 21:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239473AbjIPTAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 15:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239362AbjIPTAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 15:00:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340FDCED
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:00:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0458AC433CD;
        Sat, 16 Sep 2023 19:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694890816;
        bh=NOeQ67uX4ixB86cBeEas003TalOSHd7hERtK6iLAqT0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UORay6gXM3JapuNCVFImRXOuADcl+6YkbO5X0/M3Jelp7PjZdhcieHMnpypXU7iV1
         VDoHK5KVkmlySaQ2isASr6z9KfzqarVcQPZ6uTealKKqv3rDXIkamiXrQNydMnP6en
         JYCZh/6RAuuehA9SryXeM0bevI7nV6DtegSwoh7uw+vwDMUVxdz5Df8eNHm/kedZ95
         86FG0XIKMHijA2Ip2pfZiCaFoZWtmSjr0pAq4yNYZuKBEY12W0s7Z+rVdMG6XKhrSz
         TDZVbzNWPxRU4IX3tES6dDs649SUAp6WwXRITFxXDVq/sJU3419ZdnUAZfofmQKyU+
         nzwURCHAtD7cg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE20AE26882;
        Sat, 16 Sep 2023 19:00:15 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fix for 6.6-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZQWYoJkwI85bJ5tz@kroah.com>
References: <ZQWYoJkwI85bJ5tz@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZQWYoJkwI85bJ5tz@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.6-rc2
X-PR-Tracked-Commit-Id: 139e08188babf7a4c5f0df54b605105852fc347a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 205d0494782ff7062afedf8945c085b49ccada7d
Message-Id: <169489081590.3998.3828327210568194828.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Sep 2023 19:00:15 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 16 Sep 2023 13:59:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.6-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/205d0494782ff7062afedf8945c085b49ccada7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
