Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C437C03D1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbjJJSyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343723AbjJJSyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:54:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719B79E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 11:54:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 015BFC433CA;
        Tue, 10 Oct 2023 18:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696964077;
        bh=HrMve1DDcm0yyD6Sd9+MK2e6Ljcu7gqCyalHkS7Xvn4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vLZe3DgpiGx2+J3CnVED/idqv+ybwc5FTVs8jGoR2v317vMBRZ6QDpHOVRxqj0nQP
         KZImbKEdKjdhN81C1ukPTSggyBYteZvfOJy+TIn7sZy3yrHw+1YDuIL/wktPtn2F0j
         LnJMHzv7itdDahLPJpMPwWPATAIHt7XcKE4VinON62W1dwALy65JmiKEN0x3+7izV6
         Pmo68V4/u0phLl8EO89A3tP3+IgllRpyG6nnap0M4422yebpJGlEbOYxL5fitBqoiE
         5OTKvqH0dB0cQAcjNRDJZ8FY0ZHCtijXr2n4StoKvRBZmEv1n5NeBRpe+tAOPZH3F1
         OkBEkuFXsS7Yw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3651E0009E;
        Tue, 10 Oct 2023 18:54:36 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.6-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8734yjrmxu.wl-tiwai@suse.de>
References: <8734yjrmxu.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8734yjrmxu.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.6-rc6
X-PR-Tracked-Commit-Id: 4a63e68a295187ae3c1cb3fa0c583c96a959714f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 68d187ec14a86542f7828d1c394afaca79a3ad40
Message-Id: <169696407692.29903.14652009646573818161.pr-tracker-bot@kernel.org>
Date:   Tue, 10 Oct 2023 18:54:36 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 10 Oct 2023 08:50:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/68d187ec14a86542f7828d1c394afaca79a3ad40

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
