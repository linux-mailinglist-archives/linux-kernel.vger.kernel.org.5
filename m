Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A029E80B5BB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjLIRwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjLIRwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:52:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38A011F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:52:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93297C433C7;
        Sat,  9 Dec 2023 17:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702144346;
        bh=gsQJnkRivnNQaWFxwTJwyXNKadVnLfGIQtassmDXzrc=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=EyahjScw7rUBwBb/Az7C8rjCyGbWBP2vletcQoCYAVX3lZtsSre80mv2GTrMxr8NL
         wprw/YvpHGwLGj/sZiX9SDTz7FVKb5qIotkQ+B8/P/85viFFIP+a1yEfzicL47ah6F
         dzv8ahYF12/m6GQdGJh97D6v15BT3yG3Mdgzj8lOzx3qCZJg38CSKsdiK3OUbLdSh7
         wobRmNhaIHKEpmxsurpyd3X8r0pPnKNjMZtlbFhrMhLPDkaBJO56vjkYBsZHGH7JtU
         PJ6cbj3wg8xwT+uTAWodibo7rXHRwgq1lFRGvmrxQjmspB83REx/HKAPSbVN1DQW6s
         WuPvkLfJtz1Bg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231207221426.3259806-1-andriy.shevchenko@linux.intel.com>
References: <20231207221426.3259806-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/2] spi: pxa2xx: Update documentation
Message-Id: <170214434538.2928550.6458260404490253992.b4-ty@kernel.org>
Date:   Sat, 09 Dec 2023 17:52:25 +0000
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

On Fri, 08 Dec 2023 00:13:38 +0200, Andy Shevchenko wrote:
> A couple of documentation updates.
> 
> Andy Shevchenko (2):
>   spi: pxa2xx: Use inclusive language
>   spi: pxa2xx: Update DMA mapping and using logic in the documentation
> 
> Documentation/spi/pxa2xx.rst | 59 +++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 31 deletions(-)
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

