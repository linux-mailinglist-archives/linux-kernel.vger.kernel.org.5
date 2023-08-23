Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF678785C73
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbjHWPru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbjHWPrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:47:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17218E71;
        Wed, 23 Aug 2023 08:47:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92F3E6611F;
        Wed, 23 Aug 2023 15:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1339C433C7;
        Wed, 23 Aug 2023 15:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692805664;
        bh=Bs77JfuupYxXXpub7BEGpoDgAIuxOVaTrJLkr/k/UwE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rPInLOoPUyVc/PlY9xVDXznS0A29TZtAAew0xid5Yf2lTVagsUqkUtoRSrEGs3Nr9
         NlPqJv8E7CCGqPs5ffFg0er+4l+0LiUuS8uSqSxBdSHs9/JWcSp0M9TcGfG/R4lTnY
         utCciBGf+u7Km1BUUKOaK+qUXNvPv592tQmv1wKdcHiGv1V8vJUceArw6l8yCdzLTH
         JdgHdjy1eoX0a1fuyJALStRBY3nBr3M6eQ8+2Bhv/Zg2DhLhAFluH+h1SYVNmeeq7E
         hg2DvBhSmW9sFxJq9TYjg2xTvqJsvPARSRO1JiuclpEpYhXS6w/kme3+zDcG0SAXXA
         CI5tSyltxcJAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB19EC395C5;
        Wed, 23 Aug 2023 15:47:44 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.5-5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1526d93d-c4bb-579b-daea-f3581d8a6b71@redhat.com>
References: <1526d93d-c4bb-579b-daea-f3581d8a6b71@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1526d93d-c4bb-579b-daea-f3581d8a6b71@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.5-5
X-PR-Tracked-Commit-Id: 0848cab765c634597636810bf76d0934003cce28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5e505a99ca748583dbe558b691be1b26f05d678
Message-Id: <169280566475.18048.3071957555221852795.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Aug 2023 15:47:44 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Aug 2023 17:21:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.5-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5e505a99ca748583dbe558b691be1b26f05d678

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
