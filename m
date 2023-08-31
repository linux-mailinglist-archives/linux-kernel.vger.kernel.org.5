Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5006878F5B7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 00:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347879AbjHaWm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 18:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347822AbjHaWms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:42:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EDDD7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 15:42:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0764B6280C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 22:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDC69C433CD;
        Thu, 31 Aug 2023 22:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693521764;
        bh=BFkjwxRj+nSKRBxr7rtqZHA8zcfp1s1LTZb8rdNR1qI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=D+6rwon7IDYDenZYBtvxfnHjTC6/qX8XUFtsjnKSZIGNrSJOLD4rI5oS0OhvjTKDi
         vPaUU2N/9YQaGrYEWZ5J1GRiDbBX5Pi1kGEToEB8ygQjqme1IL7I71plaOT9DoehmN
         C4UHvqO+ufrKnaC3tvyXESkKBQrlc9TWXv8IIMKEeKy25WvQDo6v7YunpT04BT3w9s
         bE0YQyCM2TD66on0ZtFHy+lV4wE7ShxiEPNd3vB7M14N6JR6RRHxosnZHG7pc7PB12
         k0C3wIAaTIdxFEyJ8hkOuERezOEtijyzUjcX+K0OLa4eOVURl0qgzzZGL8/PonYQvz
         W3nrYTGJor07Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC0D3C595D2;
        Thu, 31 Aug 2023 22:42:44 +0000 (UTC)
Subject: Re: [GIT PULL] jfs updates for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e73dbacc-f2ba-4210-879e-42524a4d6283@oracle.com>
References: <e73dbacc-f2ba-4210-879e-42524a4d6283@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e73dbacc-f2ba-4210-879e-42524a4d6283@oracle.com>
X-PR-Tracked-Remote: git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.6
X-PR-Tracked-Commit-Id: 0225e10972fa809728b8d4c1bd2772b3ec3fdb57
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e5cd6f69735d6294965b20e8d26a3bd68ee726e
Message-Id: <169352176475.24475.921763886436527535.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Aug 2023 22:42:44 +0000
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 31 Aug 2023 10:21:26 -0500:

> git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e5cd6f69735d6294965b20e8d26a3bd68ee726e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
