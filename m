Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF4378E506
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 05:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345964AbjHaDUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 23:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345954AbjHaDUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 23:20:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300DACD6;
        Wed, 30 Aug 2023 20:20:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D38E6B82174;
        Thu, 31 Aug 2023 03:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83877C433C8;
        Thu, 31 Aug 2023 03:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693452003;
        bh=UKQxCr0/aw7ViYVCCYoXP9yAn3hwe9w3Yt9TDokjbvo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KsHSpse9b3957ABYdhTPMvEAPJ0godbGQeSBiQgVewOyQ/t1DFRBprv+F6bVbRWef
         TyPtsCeJREFFn7qM1p9wGobVB0LeTMyua9Uslz/GNCK+J49Oxbu4ZuFeGY3ssJ9Jw8
         RO4d1OYQuot3wmU6KYZPGMUu+rEguEzFp02r8cb/Q6qBKVt1JypfMdyRcsp8UaBSYN
         d/7Q4GK0FRSAIZLMvpP+Mtbmk6UuoqZ02RF7v4WFl2xGEp6saG+0DPvmHsY6xGj7Ex
         LgyllQdRMYBAw80a9jMzFhvuetU2HyuRSryuOhShulM43ocr7EV1MtI2Ys3rpISBaT
         a6KBUYrg+5c1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B3B6C3274C;
        Thu, 31 Aug 2023 03:20:03 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87edjkp8an.fsf@meer.lwn.net>
References: <87edjkp8an.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <87edjkp8an.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.6
X-PR-Tracked-Commit-Id: c63594f2d66690805eb78b75e4b8e8dc9f2672bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd99b9eb4b702563c5ac7d26b632a628f5a832a5
Message-Id: <169345200340.31241.15853816681054794727.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Aug 2023 03:20:03 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 30 Aug 2023 14:46:56 -0600:

> git://git.lwn.net/linux.git tags/docs-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd99b9eb4b702563c5ac7d26b632a628f5a832a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
