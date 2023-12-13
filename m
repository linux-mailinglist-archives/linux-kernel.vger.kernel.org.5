Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE2E811981
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjLMQcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjLMQcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:32:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D14591
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:32:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0555C433C8;
        Wed, 13 Dec 2023 16:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702485131;
        bh=odZ1MQY6e5KqzUlrj24nd/XYhqc7X1mQzuFErG0nj6I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TPC/l228szv0HrOVhUFnCl2ggjMKWRJ61PGzfrZp15kcPatwJNxZt+HGvsOaXgy/B
         dVLozXjJqtllvypDcwe7VH4RD1jRy5pUmx13SQKoFF982iH1QoEiFGPLTZLZYY6Bfx
         JLJZP6J/g5ozaYfjWpwyh1CGy17NXTKSBhsc/x5Onxhc7ZCw2jUsVL/Z69Tv6XoslH
         YBAYzCNM3Gwflm7a3x9Vuzty1or2Uvz0s6RTV5/N3q1Usyn7Seb6ixd67aTuPttW4O
         bfYBhibwIUs1iuv2bctj9Hz5Fy2MsIQJzXVjW5AOSp7c83n5uHeYi2YVCzZZJbjL8L
         32POkNGB11Nqw==
From:   Mark Brown <broonie@kernel.org>
To:     fancer.lancer@gmail.com, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nandhini.srikandan@intel.com
Cc:     devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com
In-Reply-To: <20231213060836.29203-1-nandhini.srikandan@intel.com>
References: <20231213060836.29203-1-nandhini.srikandan@intel.com>
Subject: Re: [PATCH v1 0/2] Remove Intel Thunder Bay SOC support
Message-Id: <170248512843.27334.1958241029702729417.b4-ty@kernel.org>
Date:   Wed, 13 Dec 2023 16:32:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 14:08:34 +0800, nandhini.srikandan@intel.com wrote:
> This patch set removes Intel Thunder Bay specific code as the product
> got cancelled and there are no end customers.
> 
> Patch 1: Remove Intel Thunder Bay spi dw binding specific code.
> Patch 2: Remove Intel Thunder Bay spi dw binding Documentation.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: dw: Remove Intel Thunder Bay SOC support
      commit: e1fca6957f1966cb6e75cdc354f4bcaed230a454
[2/2] spi: dw: Remove Intel Thunder Bay SOC support
      commit: e1fca6957f1966cb6e75cdc354f4bcaed230a454

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

