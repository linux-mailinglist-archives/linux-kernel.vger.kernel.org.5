Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7FD788D75
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 18:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344120AbjHYQwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 12:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344121AbjHYQvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 12:51:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5404B2130;
        Fri, 25 Aug 2023 09:51:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCDEE6634F;
        Fri, 25 Aug 2023 16:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50EB5C433C8;
        Fri, 25 Aug 2023 16:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692982283;
        bh=sT9SNOfcJ33p0wR94jOmytXoxQlblJiM7P1yB0EOrm0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kcaIr/Vjung5vtaDPEgTFgygR8qlyCHLDKJl0taiG417T0PMT8bO2TFNA84Otopqa
         6Qz/BnRnZ7XHtGhI+kySWBxMaIOzkm3sVI4zhlX9hrAch9cHi2R6GM5zZTUUI00RoK
         +MiFFR/ldZqp2DLA6EJaUacpijY4g2bG97ZpJga0Z47eo0A2DxQcmcaRqVH/o6xADo
         hXJePb/YTJslWgSR8M8ttfgmbIhszbTt2L5Phzg0JrTBPohZRDa7wlGi2JsTzJqT9/
         ercDqwtdqKN/1ktjJAtk7U1jyOlPHQqpmQnoyTut20CMY1wt+wlYj5qeMWKBtwpaNn
         +kfriJ1mPYJCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3AB93E33083;
        Fri, 25 Aug 2023 16:51:23 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230825130155.11639-1-brgl@bgdev.pl>
References: <20230825130155.11639-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230825130155.11639-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.5
X-PR-Tracked-Commit-Id: 6e39c1ac688161b4db3617aabbca589b395242bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98c6b8a558d26d3c334986146d9d03ece5f25dec
Message-Id: <169298228323.13860.8717097223556864960.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Aug 2023 16:51:23 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Aug 2023 15:01:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98c6b8a558d26d3c334986146d9d03ece5f25dec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
