Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813177CE323
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjJRQoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjJRQof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:44:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57C810F;
        Wed, 18 Oct 2023 09:44:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84C9FC433CA;
        Wed, 18 Oct 2023 16:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697647472;
        bh=/xM/6ayIS5a8A4jTQN59Zi28ju1+cIGvgSVf3oO68GU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OabQnqSLTXJG/SlugJl+RTii/FmF6dsXwi0subg+iR9WXQANtYq986fc75DUqeQ1r
         tAr8Slj2ayDqaHeKdxX9hEIldY/Smpci7d/Vx9VvSis+n+1qII0u6wWbrTvLhgTzbr
         TCsTKkCUQyiAFTIOw8wQeE6leougnPDnPrvb3OidRRWLcJNUEGOlOBAMpDfSmoup3W
         P43QT1glASyiYEPN6J0gWVpW/5+XfM6PH4P9qlSrzyuZWWftF4oGFtBf0AC47lYZ7e
         8lH9k0hfU3UTcSAV/LXIK+6HU4TsJhiooW1rrs90eJEDelpRYtwFVQMAYGWSUn9nS3
         7eixC/BoqIPBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66562C0C40E;
        Wed, 18 Oct 2023 16:44:32 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6-6-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231018142326.03D3AC433C7@smtp.kernel.org>
References: <20231018142326.03D3AC433C7@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231018142326.03D3AC433C7@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6-6-rc4
X-PR-Tracked-Commit-Id: 2ec8b010979036c2fe79a64adb6ecc0bd11e91d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd72f9c7e512da377074d47d990564959b772643
Message-Id: <169764747241.17503.14895923296895687754.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Oct 2023 16:44:32 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 18 Oct 2023 15:23:10 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6-6-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd72f9c7e512da377074d47d990564959b772643

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
