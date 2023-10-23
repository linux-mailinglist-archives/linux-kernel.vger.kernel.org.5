Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65C47D3CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjJWRAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjJWRAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:00:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FE1BD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:00:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F741C433C7;
        Mon, 23 Oct 2023 17:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698080442;
        bh=cwuYrWmz8NQ7T9Okph4zwfyJC4sUXhx1gtiMd0FnC+c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gbDmAC603yG/JGudIGGWmwaQ3qRr+5NYajhHUGpMe87TYxmprDJcj69tdGhS4092D
         3QR5oHzaGVlK+rad9pB9bDbf2tWKFnmyt8QqVDq1HQpgf+IyL7fRxAeIsxTwIlPPIq
         ohQDLPqzTjOLIlWnLE3QV5QvV31EBxRzioZaSmAxYggWjR9iRxOvk9UrTNE+eXno8L
         hRr7/bjIXhyZDS2I0lYbmF+32y2/9rMCbGjbOsj2wRb8tntbDEOpBljO2zhd6Jh6AE
         3u7z4gCbSoLoeoD6il/aSCRPvib89By7o3TnKooO7c5/UvWWTUYWlwpZF/VDPL93kA
         y04Vmabgt+Qlg==
From:   Mark Brown <broonie@kernel.org>
To:     outreachy@lists.linux.dev, Gokhan Celik <gokhan.celik@analog.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Gokhan Celik <Gokhan.Celik@analog.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <cover.1698000185.git.gokhan.celik@analog.com>
References: <cover.1698000185.git.gokhan.celik@analog.com>
Subject: Re: [PATCH v4 0/2] Add ADI MAX77503 regulator driver and bindings
Message-Id: <169808044030.106747.3557631443354429092.b4-ty@kernel.org>
Date:   Mon, 23 Oct 2023 18:00:40 +0100
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

On Sun, 22 Oct 2023 21:52:49 +0300, Gokhan Celik wrote:
> Add MAX77503 buck converter driver and devicetree bindings.
> Apply patches in sequence.
> 
> Gokhan Celik (2):
>   regulator: max77503: Add ADI MAX77503 support
>   regulator: dt-bindings: Add ADI MAX77503 support
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: max77503: Add ADI MAX77503 support
      commit: a0c543bdf4ba4f10d21fb2d44a9abc5715184966
[2/2] regulator: dt-bindings: Add ADI MAX77503 support
      commit: ff5f76b820a95957df0420bba4c67b02978e6c52

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

