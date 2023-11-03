Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE6F7E09AF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377899AbjKCTx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 15:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378146AbjKCTxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:53:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB0C1BC;
        Fri,  3 Nov 2023 12:53:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA332C433C8;
        Fri,  3 Nov 2023 19:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699041191;
        bh=gtUw4RPRjMt1Nyb0AWKTy04Y5Gx4hhcBEDtVDpIp5K8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MBfZ76UI0TpVznlRzVsSCaYD0TqdU0cCozfXuPtXvQZr/CJBUVBQwDGTT/bkEfg5U
         3JhIrW0PwAGXTv8MJ3qqUnXWq/bE3ve81T3Cz6YQB7lqKqt0veCxLlpyASC2tB6OAp
         OfdxEkKwtuKDUjUrGDlZPQMYhhJNO2uFfVC1rDLgq9AwM+KqcGsZryZEBS/VT/EN/3
         X+xc+VF7Sj3Tqt5ZGSGqrnPZQ8D69kbyPfVddVvwA85UcESAdMaLYC8osFQsSMGEuM
         rHLcejTBOfViWGD2DkIlt2SbkKAZtGKrLHiOxdNBhXHLYY8BukKBuBEfMJlNL/Cmyz
         6SfFEvsX72npA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7119EAB08A;
        Fri,  3 Nov 2023 19:53:11 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock updates for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231102131354.263678-1-mic@digikod.net>
References: <20231102131354.263678-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231102131354.263678-1-mic@digikod.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.7-rc1
X-PR-Tracked-Commit-Id: f12f8f84509a084399444c4422661345a15cc713
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 136cc1e1f5be75f57f1e0404b94ee1c8792cb07d
Message-Id: <169904119167.17286.18185542030780239189.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Nov 2023 19:53:11 +0000
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        artem.kuzin@huawei.com, yusongping <yusongping@huawei.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  2 Nov 2023 14:13:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/136cc1e1f5be75f57f1e0404b94ee1c8792cb07d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
