Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A7E762222
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjGYTUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjGYTUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:20:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2351FD5;
        Tue, 25 Jul 2023 12:20:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A363161880;
        Tue, 25 Jul 2023 19:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3811C433C9;
        Tue, 25 Jul 2023 19:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690312834;
        bh=gzzan1CmkhrLSVgA/hLkbX71JQMQqXzEPDq9VO3AWCg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kxEno9zCw0qouLZXY9RgR80Ma7JOkCRIzqhmfRAS1Uz0cAa0t4UJgm2a595YOijaS
         RpUGcQTgG0H+QV7DCdibP/jOtFv9QZlgFvlwbQ9CTJ8qU4qFBWJT3KPojKj1TijPHR
         Vo2V2QZ3TNgUuxrEA4HD9JmiQXRttWtGaFSPjF2kndwTl2osLup3C9sgMUyaHPSUyp
         K6rrxLzTprbalJBqHPnXLhsB5ABCbv3oy8j6hW+BT9gjO67NfZKJF/vsYWpmY6EE/9
         jTPZ3S/NdVjjYckM21mJ5w3o/mdD08eoptyBg3kHOpfhH43JYDmQf+UZNSZ8TDU0+w
         VeoevsLjnx/LQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230725104956.47806-1-andriy.shevchenko@linux.intel.com>
References: <20230725104956.47806-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] Documentation: core-api: Drop :export: for
 int_log.h
Message-Id: <169031283259.1609546.106488095269313393.b4-ty@kernel.org>
Date:   Tue, 25 Jul 2023 20:20:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 13:49:56 +0300, Andy Shevchenko wrote:
> The :export: keyword makes sense only for C-files, where EXPORT_SYMBOL()
> might appear. Otherwise kernel-doc may not produce anything out of this
> file.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] Documentation: core-api: Drop :export: for int_log.h
      commit: 5bdeb6f5c7b94f653183f08eca8a08022b2efac6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

