Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8BC768794
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 21:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjG3Tng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 15:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjG3Tn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 15:43:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7404410CE
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 12:43:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0359A60D17
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 19:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60DD6C433C8;
        Sun, 30 Jul 2023 19:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690746206;
        bh=eWPzD1N12GKqdvxsBJIn9xJaHBYfMhoi37Gvf0DZp+Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=V7vHQATZQXoQlj4maEwNhGezULZP7rA/0DIawNaazsozLbZ+ke8Eku71Jc8FgjLVD
         /35rnhu6sUmASuRDTOsWDselcSacONlbPl853bTYn3joFCA8X27QigNOKNfCxV8I7H
         hfdjatLA4IkO2gSy1n0KYrKFcapVnTMwLUSwWvkakwMoje6NVUOk4KcBhdeQObmdEy
         IZfTfqDZ1t2OCxc2HYkl7sIGaVHuaXfcKLe3dddms+dHH8BAbhv7kow2lGL1PMufMz
         meLOfYB9xaMoUbAACo3Zys3/2GJJdGHsp+6LipUIJkkh2t6WWqmFqFoMoaswR5ih1H
         4rHZHL0LcwFGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A6BDC595D0;
        Sun, 30 Jul 2023 19:43:26 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230730093049.GBZMYtycNKuAuP1+wB@fat_crate.local>
References: <20230730093049.GBZMYtycNKuAuP1+wB@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230730093049.GBZMYtycNKuAuP1+wB@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.5_rc4
X-PR-Tracked-Commit-Id: fd470a8beed88440b160d690344fbae05a0b9b1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d410b62e45ed9702593fb3ddc45cde3d3f277c9b
Message-Id: <169074620630.25913.3952775147632063891.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Jul 2023 19:43:26 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Jul 2023 11:30:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.5_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d410b62e45ed9702593fb3ddc45cde3d3f277c9b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
