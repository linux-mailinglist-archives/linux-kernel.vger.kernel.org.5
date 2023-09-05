Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE08792FB7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbjIEUOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243804AbjIEUOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:14:32 -0400
X-Greylist: delayed 331 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:14:10 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079A7D2;
        Tue,  5 Sep 2023 13:14:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF902C4AF6E;
        Tue,  5 Sep 2023 19:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693942951;
        bh=V/t6Ky3OrWESerKdtZ4gOtVFzzD022ADaHuMbgJuAW8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EXQaj7MuMlrDfe13Z4sEqTY1qvcL/WgKJ6ZCAu/bjEsClCPCYx5GX/ryiKw0/0sAO
         pRXNh5g7YZSUehRCkJRK42T/4RD070wG1cZwa7Ikm1N4Xoo52CAuvA2OqRvdWUlmOf
         2IcOyzifVf0xuuTo4NYNlaGtdT/G180WvIvSt17L/1J3ovJhIDDFvlW8JfLJJR0sio
         epjnEvVm8Jw4TunlpLNjXi1h+RM7E57dDvQ6LET6RAxu2GqCMiHdM4ZU0IX/feX+L4
         bGnsLglmZvSXz36kzYaT5B1O0+qyYlAg35LqYEHcJiNggUE+Qoh6EW3rY7DBYuFUOl
         OgPudrJhQCtSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BDB41C04E24;
        Tue,  5 Sep 2023 19:42:31 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC updates for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPYuGlUw9K2PcShj@antec>
References: <ZPYuGlUw9K2PcShj@antec>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPYuGlUw9K2PcShj@antec>
X-PR-Tracked-Remote: https://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: c289330331eb93bc6a3c68b9119ccd7d4285a4a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3dceb8a9a931675d5d19453306c6c76228f2b575
Message-Id: <169394295176.11207.13117621298264707145.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Sep 2023 19:42:31 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 Sep 2023 20:20:58 +0100:

> https://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3dceb8a9a931675d5d19453306c6c76228f2b575

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
