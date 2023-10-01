Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB237B49AC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 23:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbjJAVPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 17:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbjJAVPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 17:15:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE00CE;
        Sun,  1 Oct 2023 14:15:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40B16C433C8;
        Sun,  1 Oct 2023 21:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696194919;
        bh=QPO1+1OVr/oT5EV2wN7AMqhxI3EhE6LePqC9WtxwhGA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=d1Gvb66Sb+DYgvNt9NevoMaDwvTWHQrcGCFo2tMrp9dXRfNZ1xBjbh2eJUqp65Fhb
         RcKj42V6Uei5OlmVqF4zslHsC8APSjG+YOQg3effBh8smkmtCPlE/0GhKw8mKDG26r
         +gs3GZ/YQdLi0SzGnlrH/3oztsklliBLaE9Gws4FqsZLoE+rrUjN0qOha62hDCOiDp
         wqQG4SgsKtwKyaVonSPcbSE0d6pCSw59M7cDG5vzKP/nDOYUeLDXAx3pbiU6P14UXT
         lEXpB6eQ5TiCygewvnxDBe5zT3Fk3HQpIDnW53oRUIkjlwdjDur9RwYtEutApPcsG7
         HkUNgL1HYvG+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21FA6C43170;
        Sun,  1 Oct 2023 21:15:19 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v6.6-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAToVL02t9rApELSbCFfA=PYbgDzyLsJO+J3RV0h0Ry2hA@mail.gmail.com>
References: <CAK7LNAToVL02t9rApELSbCFfA=PYbgDzyLsJO+J3RV0h0Ry2hA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAToVL02t9rApELSbCFfA=PYbgDzyLsJO+J3RV0h0Ry2hA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.6-2
X-PR-Tracked-Commit-Id: 2d7d1bc119a4d7f54cfe0b1be480c34e8c712d06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e81a2dabc3f3faa0d96808708a8dc2025f2bdde3
Message-Id: <169619491913.22414.2256666820104535823.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Oct 2023 21:15:19 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 2 Oct 2023 01:56:16 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e81a2dabc3f3faa0d96808708a8dc2025f2bdde3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
