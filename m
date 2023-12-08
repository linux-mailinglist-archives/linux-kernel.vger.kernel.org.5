Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11573809865
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572889AbjLHBKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572881AbjLHBJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:09:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A867D1709
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:10:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49F09C433C8;
        Fri,  8 Dec 2023 01:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701997805;
        bh=+FdWeHCsxQI5D3Hb4cdTMCTr0/hP3EFVMVP2Wrflmko=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GdTBoNjhJ0fVE1Gsi9JG7j/t/d3CFxxd3hgX5l6X3CQTpIPMf6U4dvbeDu+79Dkp/
         KSQlgstxbK5P9Bj497I50ghnFZG7jAYgGz9y6uM9qWBkGtZjQQJH99dtfaS+SEEu50
         dLDUkkQZaZViEzOObfaNSV3dtLT5B+FEp75DcA6oMlK3vyrRHxdDWe1RBtnvnidFKO
         2yMH6zDu5q06Yw7cZccPMftGdH5mc9AF7yqWHZgH2/jCPZyGtmIjeYBdpIwcMdX8+/
         lt3/36bwwHh+BkMhH2dD5NIO/+4lZu3MuzhBu01gxx4ywK2RtXoeLKrKzGfQoUVjGq
         ZZeZSt2a0/SwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35431DFAAA6;
        Fri,  8 Dec 2023 01:10:05 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.7-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231207192853.448914-1-kuba@kernel.org>
References: <20231207192853.448914-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231207192853.448914-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.7-rc5
X-PR-Tracked-Commit-Id: b0a930e8d90caf66a94fee7a9d0b8472bc3e7561
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e3f5b81de80c98338bcb47c233aebefee5a4801
Message-Id: <170199780520.17399.8154365972166288437.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Dec 2023 01:10:05 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com,
        bpf@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  7 Dec 2023 11:28:53 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.7-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e3f5b81de80c98338bcb47c233aebefee5a4801

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
