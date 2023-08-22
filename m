Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C97784959
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjHVSVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjHVSVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:21:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A71CD0;
        Tue, 22 Aug 2023 11:21:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D849361877;
        Tue, 22 Aug 2023 18:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45FE0C433C8;
        Tue, 22 Aug 2023 18:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692728498;
        bh=2+VGcMZI5wrBZmpfN2Qdm3WH/HgDymiHNlNdfR45ac4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=f9WhSgtOvkQ6xd5mQZR9hllcxawCjEVOeC362NecEir/b54mTv7nhanF8Xa5i3kLs
         OORUNZ3sQd5Tf9eouDBDEvnZ3GyEyoay+XtyCOW8LyB+XKxa/GOMGAxyFhHfrirEVn
         e+GS8EJR0iyBo/jhh3qp460DEZWKX+RX9GAM/evGUIgJnn/moPPpsrdquRV08x/FXZ
         M0kB1CbvprKQ82GJFJ1ZnvMC/3nyR40YOsCzG6ZQQXu/EOZ8wlOr6J6oQ3VMUVUFOH
         0SfN58LaxU/+2bSQ+TyWWKbb56Zk4IyGYzddEqT05DJINXbBolAYiN6rAf5RQ0Wm+z
         LjV6lFOCDRTow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 318A3C3274B;
        Tue, 22 Aug 2023 18:21:38 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.5, take 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230822174328.GA385825-robh@kernel.org>
References: <20230822174328.GA385825-robh@kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230822174328.GA385825-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.5-2
X-PR-Tracked-Commit-Id: 7882541ca06d51a6c12d687827176c16d5e05f65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89bf6209cad66214d3774dac86b6bbf2aec6a30d
Message-Id: <169272849819.25238.16626576801461288050.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Aug 2023 18:21:38 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 22 Aug 2023 12:43:28 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89bf6209cad66214d3774dac86b6bbf2aec6a30d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
