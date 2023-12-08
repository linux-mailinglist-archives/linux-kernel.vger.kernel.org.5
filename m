Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1507980AD31
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbjLHTiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHTiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:38:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA231720
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 11:38:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB267C433C9;
        Fri,  8 Dec 2023 19:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702064307;
        bh=o/kkmyDEFR0A8zybW0jW+ZY0fX+Y5TDHGh0WHQZZ7k0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=m2xE6nJ+53cN9nk1J42I1rchFQoh9TDlO3+0fn89/umyw3E/ObKaw1WaEhRBmlPdk
         370wFUiifcXjYVrLylCIDxK8g+1XZSE+YHUccK3o8GvxOAh/9X0USb8xArQWbyD/g9
         mChODUdNN9QDSjohKDI13AHTIWyN7BuYbjBARAeIk4wtLGbgYpG+mGRcEnnDuf8qhA
         39zSGWcLqfy4h9N5pP4E6IWKm9YPAbIwNgi6Ubzd4c6HBfE8Ur7L7vpUt1jdlFS0/P
         lUE2T/cKdGcvqto4q/937lW8g6scfYZkPMVg2kC50lOj5xfZWiequ6MripAYg2AEYm
         rQiZgDRyfT4yw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9672DD4F1E;
        Fri,  8 Dec 2023 19:38:27 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.7-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <874jgtyo9u.wl-tiwai@suse.de>
References: <874jgtyo9u.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-sound.vger.kernel.org>
X-PR-Tracked-Message-Id: <874jgtyo9u.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.7-rc5
X-PR-Tracked-Commit-Id: 634e5e1e06f5cdd614a1bc429ecb243a51cc009d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8b68d2fd41c1068554290fdf2c5adc6b03d40ce
Message-Id: <170206430775.311.17101107361265756825.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Dec 2023 19:38:27 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Sound Mailing List <linux-sound@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 08 Dec 2023 11:36:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.7-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8b68d2fd41c1068554290fdf2c5adc6b03d40ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
