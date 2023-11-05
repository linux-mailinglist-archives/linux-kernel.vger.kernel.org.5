Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB1C7E15FD
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 20:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjKETLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 14:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKETLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 14:11:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83B1E0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 11:11:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F1D9C433C7;
        Sun,  5 Nov 2023 19:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699211477;
        bh=fj+FVGAWPpO8O4n2zH2qGswvpwohotxhcBOI/kdauVY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FyVuPQXTNhrbM6b1buXlqxjijt0f3WQu4hDFcnkGkk6C95speJxRgwIVZvadxu7eu
         pFHOYDTMnm6pwwL8Uw76DtzjVF9ecKGQ8Hb08qc0F+xpZ9l+nmME+wwxr7aW1DNkwN
         MYP/uubV6iV5/oQoYRRr7CDTUKR9IUsLmtxV6edyE4lR/wdwkuBT0wFrCWr/neh1ci
         zppVp8hFNVXLFakiCgEtfaN95w0dJbXn4U97119lF92QaLfmgMVRjwJ9F5zisHvUvx
         D+fR5pXZ/0NGnah6TmaXTBtO54db+qnenYKyIybqoFQFExaM8RDV+XU39QVoQ/H9ca
         1vcGqKszp2adw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B186C395FC;
        Sun,  5 Nov 2023 19:11:17 +0000 (UTC)
Subject: Re: [GIT PULL] vhost,virtio,vdpa: features, fixes, cleanups
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231105105806-mutt-send-email-mst@kernel.org>
References: <20231105105806-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20231105105806-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 86f6c224c97911b4392cb7b402e6a4ed323a449e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 77fa2fbe87fc605c4bfa87dff87be9bfded0e9a3
Message-Id: <169921147736.31662.3355128222514557498.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Nov 2023 19:11:17 +0000
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        xuanzhuo@linux.alibaba.com, geert+renesas@glider.be,
        kvm@vger.kernel.org, mst@redhat.com, simon.horman@corigine.com,
        netdev@vger.kernel.org, xieyongji@bytedance.com,
        xueshi.hu@smartx.com, pizhenwei@bytedance.com,
        linux-kernel@vger.kernel.org, eperezma@redhat.com,
        leiyang@redhat.com, gregkh@linuxfoundation.org,
        shawn.shao@jaguarmicro.com,
        virtualization@lists.linux-foundation.org, leon@kernel.org
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 5 Nov 2023 10:58:06 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/77fa2fbe87fc605c4bfa87dff87be9bfded0e9a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
