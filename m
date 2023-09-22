Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DFB7ABA10
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 21:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbjIVT2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 15:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjIVT2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 15:28:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A7FAC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 12:28:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D8CC433C8;
        Fri, 22 Sep 2023 19:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695410909;
        bh=PJwZweM/qxn0xzKrOgdVPLEbGE7bz46ZA01+diOI8W8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=J2mQSRfVE5nXJ+OEyvqc9xAUfUN6pshA1cMF3fZ1Kq++BkTJUtrtIgiMjW3X8J0sI
         e/DOPjqFG5gDMXdpnahS83a3MyHwhRp63mP3avwYQ3WOm58NSuRF4VaolL45YIYr05
         fiALNy7KMOWCKPy2rCVSrymSWwbZXa1IEyVPczQRWkr43OYjzJve5LM0CZltgISHD8
         Ns9EGttnIYpqfzHcZ8vUgaOvnBleGZ8iGd5oyCJki760iWXt0xyrR+GrV5NrBibLcb
         3pJhfH+IEkhCRytREhzgJgPXAfgQnxO9UrLkDG5uqEq9KfM8I7ocx2Es4Z/8+dGG1o
         yLlis3PgC9Tvw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230921183313.54112-1-bragathemanick0908@gmail.com>
References: <20230921183313.54112-1-bragathemanick0908@gmail.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: tfa9879: Convert to dtschema
Message-Id: <169541090782.56212.5542845690705376801.b4-ty@kernel.org>
Date:   Fri, 22 Sep 2023 20:28:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 00:03:13 +0530, Bragatheswaran Manickavel wrote:
> Convert the tfa9879 audio CODEC bindings to DT schema
> No error/warning seen when running make dt_binding_check
> 
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> 
> Changes:
> V1 -> V2: Fixed DT syntax errors and doc warning
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: tfa9879: Convert to dtschema
      commit: 39fce972fd7259395663586e59388d702afec30e

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

