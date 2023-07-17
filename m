Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04746756AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjGQRel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjGQReZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:34:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C40291
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:34:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 228A1611B4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 17:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10CAFC43391;
        Mon, 17 Jul 2023 17:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689615262;
        bh=zjpi1nmFBRkngC9kx5uSz24LCTF4uH41+2V6jKvsHMc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DlOnmUT3kCu61Ax6lKM/L4+gRXW8BImDVpK0xKK5s6Wq9QcuyzxwNgTeMG2DsetN9
         R985SPgNMPOi/UC+6XItv9cHotMURfRI4IQLf6OAGp/ObrvLnRSa9i5E30Ks237A2/
         jv7qSgeaCtvOSry7KrFXXvLsi8O80AhI9/LATJkvJ/+4FLXZ0KKaEfEWlx+8FesIm/
         VVwm+/+n3F4JWYnPrjeh3EaYI9ePJ5wQEN54vtKlVHHbODZYokwYyJ6TT7+WzxvI+M
         0JZTV8CC8zRuaKRR+bQkEGk2vu0jVSt9ZY9Ub3Rg0PRboeL6cfpOGLZFLMtiWsmYMv
         fsRMUWQIPaTYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED88BE29F39;
        Mon, 17 Jul 2023 17:34:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix spelling in ABI documentation
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168961526196.4078.16285159335200571257.git-patchwork-notify@kernel.org>
Date:   Mon, 17 Jul 2023 17:34:21 +0000
References: <20230710052324.2857-1-rdunlap@infradead.org>
In-Reply-To: <20230710052324.2857-1-rdunlap@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, frank.li@vivo.com,
        linux-f2fs-devel@lists.sourceforge.net, vkon@google.com,
        jaegeuk@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun,  9 Jul 2023 22:23:24 -0700 you wrote:
> Correct spelling problems as identified by codespell.
> 
> Fixes: 9e615dbba41e ("f2fs: add missing description for ipu_policy node")
> Fixes: b2e4a2b300e5 ("f2fs: expose discard related parameters in sysfs")
> Fixes: 846ae671ad36 ("f2fs: expose extension_list sysfs entry")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Chao Yu <chao@kernel.org>
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Cc: Yangtao Li <frank.li@vivo.com>
> Cc: Konstantin Vyshetsky <vkon@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix spelling in ABI documentation
    https://git.kernel.org/jaegeuk/f2fs/c/666de8daceef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


