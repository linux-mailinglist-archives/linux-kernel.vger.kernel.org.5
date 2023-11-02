Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4FD7DFA0C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377237AbjKBSiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377331AbjKBSiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:38:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A63192
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:38:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 876B2C433CA;
        Thu,  2 Nov 2023 18:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698950285;
        bh=KvHmjsuWuENPdykSnqhc8T1/Nm+ZXLZIqM/GRMEqkho=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qbypTg25aDjPVpHwL2tdfDX8QH3Sa8x4BZLVGHoDuSQwtwPZ8UpXgbtmvyyl5Uv9w
         psPCRH7t+SqcnylpmOiYgn6sBbI8eKVxpnU8YwueGLKVZsDO3j/r6kHDo5ZXXf2Bt3
         GYsOEv5zltm01SQLKhd9YMJ5ODIMZdIr5fFc6gynmdLqXEl0QZt5h+V5FNlf/UFYoq
         Pqg0vf2x37/Y4awL+4VEpEBde46v41bfQbkp6YxoA2dsy0G68gmjrrThEcNodv2oVg
         PM2HCtOvcAqWvd/4wSUVI2kBBINaKAPvMeixrMmFNoVnf9npnQSQe5sfhivW53xzMS
         X4F6XQCW8obeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7440EC4316B;
        Thu,  2 Nov 2023 18:38:05 +0000 (UTC)
Subject: Re: [GIT PULL] jfs updates for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <425ffc38-a35b-45c4-9819-e51464f58450@oracle.com>
References: <425ffc38-a35b-45c4-9819-e51464f58450@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <425ffc38-a35b-45c4-9819-e51464f58450@oracle.com>
X-PR-Tracked-Remote: git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.7
X-PR-Tracked-Commit-Id: a779ed754e52d582b8c0e17959df063108bd0656
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e9806ff8a0f9e6eb193326383a7b88bf30ad0533
Message-Id: <169895028547.19486.9134832611759860162.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Nov 2023 18:38:05 +0000
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Nov 2023 08:22:09 -0500:

> git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e9806ff8a0f9e6eb193326383a7b88bf30ad0533

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
