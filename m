Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C7C80B5BC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjLIRwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjLIRwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:52:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC2D11F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:52:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7491C433C9;
        Sat,  9 Dec 2023 17:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702144347;
        bh=ONsFIGiWbHdnQS2adnSV1qao80egjbH8N4a7p9ZpSXw=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Y+1YhmGbLVIzcDljpsL9WkWNmMe68Sjnge4N0E3K8O5FSCg0vB6ZkbVQTjaO64Q0z
         MMc+TRICXeMDSUDCqu22YinDQB8IXhn+RC9myv3qDGV9VxFkekv/PYzfDeV5SYADpJ
         qm3zBM4EzZKc4s/DtBKJ0oAhQaLK0Dqbe9u3PStXnqBbXzdm5TnztTVBC7B5+DffzR
         YPBaygPNLZumZqxOx2CxkodYeMv9hlTZ/0mNhL3NLyk1XHTsKCCBkf5q1iNS411kL+
         8SA13zK6gS/8zKQBT45hs1FuF7J+rlkfS7jC9ly7OPcqy3xttaOrTGyY8vhoLt6AGn
         seWT/8zxL218Q==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231208170436.3309648-1-andriy.shevchenko@linux.intel.com>
References: <20231208170436.3309648-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/2] spi: pxa2xx: Update documentation
Message-Id: <170214434667.2928550.7302807797153128431.b4-ty@kernel.org>
Date:   Sat, 09 Dec 2023 17:52:26 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Dec 2023 19:02:53 +0200, Andy Shevchenko wrote:
> A couple of documentation updates.
> 
> Since v1:
> - spelled controller fully in patch 1
> - fixed inconsistent indentation in patch 2
> 
> Andy Shevchenko (2):
>   spi: pxa2xx: Use inclusive language
>   spi: pxa2xx: Update DMA mapping and using logic in the documentation
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: pxa2xx: Use inclusive language
      commit: c3aeaf2f0ec8af93189488bda3928a1ac7752388
[2/2] spi: pxa2xx: Update DMA mapping and using logic in the documentation
      commit: 8bc2a3634b87e2235535b5527f83ff529df68b56

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

