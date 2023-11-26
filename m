Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEF77F94C1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 19:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjKZSDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 13:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjKZSDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 13:03:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51380EB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 10:03:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F19E7C433C7;
        Sun, 26 Nov 2023 18:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701021800;
        bh=Gg5Y8fFkPZFunUuSW0JeQ9r0V4qzjdDkY3C8H17USiQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hqn6AJAZaRTHPIktwMJ4bbX6FV0Da94c8dXmXIPCt7uiCd1QWgEDFkwNdgHr5Qabr
         B2V1QeutPMFGj7bA7jI28bL8yk16mqoa5bIYZnFu3HaWa3Ir7J+JiH4RhDZP10Favp
         OX7Is46Yj0eP8MuWqA5bU5YyDOcVBM8VyEG/SJKnlkvxaCrVD91aeFDM4Pa2ZKyeca
         s4FXKFTO/C9FNOz3hZeLPyFZvM/S15nkgNrEM3Ii1Ml/TRZ+NkBCwnty4r9UfOLUlE
         Sq+btNvGSTTvRKk+hpPKP5NRbiEyHluJjj+tKxi20S7zzz9e9WFgiu7NosAiqjSA2h
         UKwDBdfM2Q6eQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC619EAA958;
        Sun, 26 Nov 2023 18:03:19 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for v6.7-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZWN6qUkUEewrKNOe@p100>
References: <ZWN6qUkUEewrKNOe@p100>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZWN6qUkUEewrKNOe@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.7-rc3
X-PR-Tracked-Commit-Id: 43266838515d30dc0c45d5c7e6e7edacee6cce92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2da77f431ac49b5763b88751a75f70daa46296c
Message-Id: <170102179989.12031.198762284192392864.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Nov 2023 18:03:19 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Nov 2023 18:04:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2da77f431ac49b5763b88751a75f70daa46296c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
