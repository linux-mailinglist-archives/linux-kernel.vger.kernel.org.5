Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136F979911C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344575AbjIHUks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236809AbjIHUkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:40:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6616C9C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 13:40:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F00A4C433C8;
        Fri,  8 Sep 2023 20:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694205643;
        bh=/XOpT10/LX/g4/2GJtyB/zzVlk6oSdoKQo6DyWnDg4s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LhEHRTDF0xWtrLrNIluMxydo7OSHabE2dLa9rzTRD14xRK5k2mYREgGXunu3/+aq9
         yWDOyCWIiERRdfUtmQrsEE6cGKtWJ+W7zdeop2YE3mqQda7ECFA4L2z0w7mgSYGKvI
         Bmfw7l9lxr2Ud5i5fS0MMPZRhRFwa+yuzahlhwJAqszKionadRM5ynWJpE4icqHvq9
         gZMPUtbhRkMtrAEwFr4bo3ROK/oiGyDbr4oHX9ZmU1cnArrEwC4IoGp4tTTCctrnKG
         8Qab7UoHP4Szq9uwu0OfLY/iK86W7rTHm0cCimU7f0Xp4YE3fmsryLBQw0rMP1AJBh
         0h3Gdjs8B02Ig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB0ECE5250B;
        Fri,  8 Sep 2023 20:40:42 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87o7id9jzs.wl-tiwai@suse.de>
References: <87o7id9jzs.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87o7id9jzs.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.6-rc1
X-PR-Tracked-Commit-Id: ecc8b4d0b6e19031733f28537971f8c5088dada2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3d231e44ab827345d24973a621e9364949423a4
Message-Id: <169420564288.32167.5423104882043035033.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Sep 2023 20:40:42 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 08 Sep 2023 09:55:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3d231e44ab827345d24973a621e9364949423a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
