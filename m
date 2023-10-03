Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478F27B6FAF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 19:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240664AbjJCRZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 13:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240671AbjJCRZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:25:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E61A7;
        Tue,  3 Oct 2023 10:25:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1565C433C7;
        Tue,  3 Oct 2023 17:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696353931;
        bh=Wbg68zZ16AqpoAAsTHPWYZoBrh4u8riplJaUdQEKDyE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=izGEoGK5WmursZi+kwy1NRfhXiEDvKo8TUlPCmM7BUIsoM+dnJxbdPFtIFBuwMFcC
         1hJhlqtlaKIrXqoj+7naX+ANKHYg/dZPciu1Si2sIOo2p8JdBL7niPSVjxqTkUnG7v
         trfxme01FB61B5ANxOIRlAOUnauBFlyXaFxkGy6XBZCuHBikBlS7+V4RlYslQM5RFO
         4E+azfYvrA1DcHW/z5jb4sstzn44FM5s4s/Yz5LYB6fqmJxt6KkkUN8RIEQ6AKtPSb
         zMYnO167/9llnZjEV+alZyW5s258GubZ28P7ZuV/Cg2ltEJp6hvl9GFgXFUPladoNJ
         sdE5xiMnw0a0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA8FBE632D0;
        Tue,  3 Oct 2023 17:25:31 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.6-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <82544739f91f3d64c8307205cfddac59365fc137.camel@HansenPartnership.com>
References: <82544739f91f3d64c8307205cfddac59365fc137.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <82544739f91f3d64c8307205cfddac59365fc137.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: b481f644d9174670b385c3a699617052cd2a79d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e62ed3b1c8a397185af53d6b94f04b9ff21ec7d
Message-Id: <169635393181.30954.3582177080656053169.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Oct 2023 17:25:31 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 03 Oct 2023 09:43:56 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e62ed3b1c8a397185af53d6b94f04b9ff21ec7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
