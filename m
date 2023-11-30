Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473077FFF66
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377278AbjK3XYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377258AbjK3XYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:24:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082A91713
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:24:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AD09C433C9;
        Thu, 30 Nov 2023 23:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701386676;
        bh=nnNzl0Oc4vbvwo2UmGHcLk5NCmOlKj5ga2Oo+dioiVc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uCEFpnlgsmhU9G/2Xu6MchtG4Jj6wxbVdOfRl1MZgC71Q1o81R3qnx+aAjIjKgimE
         pe6khbiOBJj8AKBY9gaHCQpijIAep1IysBoIW08kVjkzkl5tj/27m3Qp//62etmeq3
         Xw4bP7ev4rb/xlGEaYwmtUPxbVks60Cfl/1R9w3cwehI/qvnIiHp5RkLTV1IteEDjW
         63J+ZXu1J0/iTo1rIvHc9PNSSAp2IWVmG9iSCxZlpL1fmN9cRgBcXvh34v/pePLeAH
         3ENWXg39Vv2OwkAT0PRSSTAPUxClfZ6RCIxavADcttyIBEag+05xU/PWS95mllaKL6
         0kcPxE06pNEaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64E6EDFAA86;
        Thu, 30 Nov 2023 23:24:36 +0000 (UTC)
Subject: Re: [GIT PULL] LEDs fixes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231130140246.GK1470173@google.com>
References: <20231130140246.GK1470173@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231130140246.GK1470173@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-fixes-6.7
X-PR-Tracked-Commit-Id: 8f2244c9af245ff72185c0473827125ee6b2d1a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 16864755721d53d7d866cf254905fde32370aa7c
Message-Id: <170138667640.16887.13613603154300153691.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Nov 2023 23:24:36 +0000
To:     Lee Jones <lee@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Takashi Iwai <tiwai@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 Nov 2023 14:02:46 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-fixes-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/16864755721d53d7d866cf254905fde32370aa7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
