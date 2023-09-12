Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4D079D429
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbjILO6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236090AbjILO6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:58:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB95CCD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:58:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D200C433C8;
        Tue, 12 Sep 2023 14:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694530724;
        bh=PYAQkJrO1WkKP0/tTTlzK5uxjkDb8XCIVszb8hdked4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=m5Y+QcqcgPdS3iZykO1Uxg4O8yhi1LUg8BK+y4kXxp4k/Q5j5dDC7amELHfVuedQ4
         AD6hEkn4xBqHgv3WLkdpjMBaOc2S1sLVII6njWKYqKjB99hdbMSH5juIZ1OARg3tH3
         m2UnbUD7ssgOykUxOSYjoYCGTWqiqieal6wvzzvln5fNp5sk1aT9CZ/AglU4sINycK
         N0VhCev9SatYQfeYAWQQzdHJv9My/h4QKeij7hnyA+U5EKvgwkkD5GMgV7pe4R9Mec
         pJBFu86elFFp2kPO1SQ44oMr23UTmifTZSorujIQLs6DUR2BePnDXAkp9hvaZ/J1jA
         oWCz/in2eAaPQ==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, Mario Limonciello <mario.limonciello@amd.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Syed.SabaKareem@amd.com, wildjim@kiwinet.org
In-Reply-To: <20230906182257.45736-1-mario.limonciello@amd.com>
References: <20230906182257.45736-1-mario.limonciello@amd.com>
Subject: Re: [PATCH] ASoC: amd: yc: Fix a non-functional mic on Lenovo 82TL
Message-Id: <169453072328.64014.13305753532018696310.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 15:58:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Sep 2023 13:22:57 -0500, Mario Limonciello wrote:
> Lenovo 82TL has DMIC connected like 82V2 does.  Also match
> 82TL.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Fix a non-functional mic on Lenovo 82TL
      commit: cfff2a7794d23b03a3ddedd318bf1df1876c598f

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

