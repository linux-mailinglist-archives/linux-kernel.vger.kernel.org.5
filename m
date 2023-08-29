Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4A478CC98
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239014AbjH2TAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238983AbjH2TA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:00:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0858D19A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 12:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCC546311E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 19:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48EF3C433C9;
        Tue, 29 Aug 2023 19:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693335624;
        bh=V4juALzediEWIR1K/yW4XNf5fTxbmXpZ+AMUl8JLjyQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UGK5qYOCxn59y+2ojCrYywGU2qLDnxTjE83Gjkeh5Ib+NwendnZqOAeZMORe4IaD/
         6+wzcvr13HD28hqCS1PnlI/0h7ARL9p+5yceNlxFkYm4Bcx9zaHfHWrB98TjhmR3Vg
         Ijpg4tlQsGD9P8u2OS6v/61wE37KVgQs2ssu6cC4iy+3pjKDwUgHW2vKhwRyeOMCCT
         uSmVA4euSpds5pgl3XsbQu7ksl8OzmGvcdRrKqSc3Qr0BGUfye/cjuckGNiOvp+jtK
         kYERoXWm8xSliX3jsw/vemni7awcO3SiK7nkPjuAofxhebVtoQHCTBrS6Lzz7otG6o
         SsJXzT7CYe+wg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 327B3C595D2;
        Tue, 29 Aug 2023 19:00:24 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230829125950.39432-1-pabeni@redhat.com>
References: <20230829125950.39432-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230829125950.39432-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.6
X-PR-Tracked-Commit-Id: c873512ef3a39cc1a605b7a5ff2ad0a33d619aa8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd6c11bc43c496cddfc6cf603b5d45365606dbd5
Message-Id: <169333562420.15412.12056254346182009806.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 19:00:24 +0000
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Aug 2023 14:59:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd6c11bc43c496cddfc6cf603b5d45365606dbd5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
