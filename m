Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAA280DFF2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345424AbjLLATZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjLLATX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:19:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F83A2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:19:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9598DC433C8;
        Tue, 12 Dec 2023 00:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702340369;
        bh=SZSje40HwYyKrUZgQ516yasD50Jors8YfDhYE+4NQL0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CXPBgkvQw+QkIhyttnSzHdhSNTpzk0EDWg8Wj4R+h1Hc1ghD8JQRkXoKEC/t3SuYw
         Y0tI9g3Pp2zsskCeNrzhFJ0XzSs+1nYwNVZmDmGjgeuo+d0QpsVwd4AhARDIMMSaBZ
         gfI1SG4rM1XNwKopcccvfr5oUswWIC5owH5D58/qIVLDoCcYAxA49DjmnDwLr8DhlG
         rpYp49qjEtSMpt6Gjv3rae59u8fLLWO9BN65dypJLgRICQbXQWiro2sptzEtEyK7hf
         aaNU0cbhqPVOXVyIPGnobwiGtmipwbgKgNIgrj7uTKuOcdIC/WBdbVXNT7x4wHbP1Q
         gN/lJBYKWjqjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84030DFC908;
        Tue, 12 Dec 2023 00:19:29 +0000 (UTC)
Subject: Re: [GIT PULL] More bcachefs fixes for 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231210235718.svy4bjxqqrtgkgoc@moria.home.lan>
References: <20231210235718.svy4bjxqqrtgkgoc@moria.home.lan>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231210235718.svy4bjxqqrtgkgoc@moria.home.lan>
X-PR-Tracked-Remote: https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-12-10
X-PR-Tracked-Commit-Id: a66ff26b0f31189e413a87065c25949c359e4bef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26aff849438cebcd05f1a647390c4aa700d5c0f1
Message-Id: <170234036953.14986.4145817613405847373.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Dec 2023 00:19:29 +0000
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Dec 2023 18:57:18 -0500:

> https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-12-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26aff849438cebcd05f1a647390c4aa700d5c0f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
