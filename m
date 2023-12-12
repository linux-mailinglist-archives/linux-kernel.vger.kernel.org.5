Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F70980F648
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377110AbjLLTNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbjLLTNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:13:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA198D60
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:13:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6889FC433C9;
        Tue, 12 Dec 2023 19:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702408418;
        bh=b6+xPEypTzYTk/+aHKM9cnUEeFkXHPQIJcO0FRSD9O0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=f0YjAI/s3miADkyrML78I3zC+rs1Nj5CNWu+HQbg+TP2qHhyh3+015EY/QUs/ggdH
         kkUHEw2GXIkhtuQ2oBQ+nHEXHfbXooOVkcC8suucreHDFT+WneMjgTXq/Q7oUcj0zg
         ReSn1qGfW48VWfh2OsRsYwUEsW0utmZUZYB86WdVyNnIMqWwrY4JUnJcvbs8MHarAo
         Yda1BrjTr0htYBMQHUQmVkTEMT/3GqHbSlVGLkbDR2c/PfKCgmK9USPm4Naxq5I7hE
         xzzwihzdBMPQXNyxWjyOH7q0vWlEKguOFPH+fgy0FIyzaOOV+SiGHPvmyzUECDSS2s
         kiwVkO/ivGJCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55A3FDFC906;
        Tue, 12 Dec 2023 19:13:38 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mscEZygkgAK49pr0Tf89eJAhngE35AUo+Rmt1800m9TnQ@mail.gmail.com>
References: <CAH2r5mscEZygkgAK49pr0Tf89eJAhngE35AUo+Rmt1800m9TnQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mscEZygkgAK49pr0Tf89eJAhngE35AUo+Rmt1800m9TnQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.7-rc5-ksmbd-server-fixes
X-PR-Tracked-Commit-Id: 13736654481198e519059d4a2e2e3b20fa9fdb3e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b8cd4beea4f6c68092736c544a797dcd5e094c5
Message-Id: <170240841834.26992.17245797143389384279.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Dec 2023 19:13:38 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 11 Dec 2023 22:44:32 -0600:

> git://git.samba.org/ksmbd.git tags/6.7-rc5-ksmbd-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b8cd4beea4f6c68092736c544a797dcd5e094c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
