Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DE37980AC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 04:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241936AbjIHCsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 22:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239353AbjIHCr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 22:47:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0861BE2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 19:47:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BCD8C433C7;
        Fri,  8 Sep 2023 02:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694141275;
        bh=dUuDOZoI7m1VHLYkauov4MfNyEtITYJV+zU6Q6hXNAo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=d3vq+tt911em7TIEDNY8WG54S/fkws4yY36B0WqKTlLYvn4cEyz7dRvKnkgOVvsWc
         XLt52A8XI5dQWoBpGryb7ADeg/lkpbKoCA3nEWSRAx2OkI/AWSl1j3VkDlGJXlwszV
         8yjZoKoFYIoEkaaT/1J772aRWE0VMOfcB2uiAZvf9pHe9EGT0mgWb5ITU1WqtvNAyk
         1kyCMBikVM7/2D6gisH9lYthwxRWMQBWWeJp0JqnBkUUDalieGsdbO8GS3vsIq56ry
         swDEcTKTUfbiWFYkGz+DcY27flPKNXtFhE4V03DZTYsvHWbjPPFaSMuFhpJOxzoibz
         KK40goPMTspxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68A79E22AFB;
        Fri,  8 Sep 2023 02:47:55 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230907220103.3900219-1-kuba@kernel.org>
References: <20230907220103.3900219-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230907220103.3900219-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.6-rc1
X-PR-Tracked-Commit-Id: 1b36955cc048c8ff6ba448dbf4be0e52f59f2963
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 73be7fb14e83d24383f840a22f24d3ed222ca319
Message-Id: <169414127542.11889.2442967335814102525.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Sep 2023 02:47:55 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  7 Sep 2023 15:01:03 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/73be7fb14e83d24383f840a22f24d3ed222ca319

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
