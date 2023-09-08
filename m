Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCE6798020
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 03:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241495AbjIHBZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 21:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241192AbjIHBZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 21:25:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02571BD7;
        Thu,  7 Sep 2023 18:25:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69937C433C7;
        Fri,  8 Sep 2023 01:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694136333;
        bh=OxJvE463jEIjHJW3P504J4kdN864Z7HuqD4tzqpKN6Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZRtHawVv5jFQMepfKWJw0Z2in3RhVjtM7AD+2+j19Kd/lN2W+XpEIeEj7JOJff+ha
         5RzW8h1MSwmBZha5mccr1tp3ceVQatjd4dR2oaasa7LkwOY4mozZ/azdhspcOzxgIu
         UkNh42HWaw1pJde17BIje8UPZE/H0UVGAph0QmXaGgqnGAXHGdj3pXH2iLz76DoHfR
         p9TrRIuI38ELCc9be7dX/J6vVeUJ/XJNhmQWCCxlSwLL0x10xomSbQCUYi5idKQbd/
         SSWpgbSSxrzA2NEIoBrB/GEzufRn1oqyL2NvgrZblsjpeFbgm9bfzg31p068Wwb8Zr
         pHAVvswjxn+Wg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5591CC4166F;
        Fri,  8 Sep 2023 01:25:33 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.6, take 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230907182624.GA1977731-robh@kernel.org>
References: <20230907182624.GA1977731-robh@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230907182624.GA1977731-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.6-1
X-PR-Tracked-Commit-Id: 591b00cc4fcfcb4532e4b85b5b2e67bbcf4973a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ab35ce202f8ba56d4b0930985426214341638a7
Message-Id: <169413633334.5754.18446694127558281002.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Sep 2023 01:25:33 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 Sep 2023 13:26:24 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.6-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ab35ce202f8ba56d4b0930985426214341638a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
