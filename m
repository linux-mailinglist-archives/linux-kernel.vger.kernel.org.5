Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E13766B83
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbjG1LO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbjG1LOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:14:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8830F2723;
        Fri, 28 Jul 2023 04:14:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26233620CD;
        Fri, 28 Jul 2023 11:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690B9C433C8;
        Fri, 28 Jul 2023 11:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690542893;
        bh=WS0nmvdraHwRzCUZAn+1znFrZP3+1jWKj9lAGH87O1o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=vCV6Vamz2Z+3PEuVoJUo0O5Oos52qqZfLuBps7e/4zzDo5/NSWbWx0ndFx80nzT1r
         pSNFH0M8nirFkAzVZHTvI6T0M8NTAA/sfeWWmF/JJ3XIzGMVz/13rRA8QWef/0GH9z
         s3hneMinEtTZa6iF7V/YJGCKD22oibVNQ5Rpjlw+HiQaYUnEqEvEWqGVUhyCE0Ct15
         dQrB27GPQf8dzxKrbep2TTx1wxG60BDJiUJh7QkWCOuuotUsmyIHIRPnYHLV6zVFOW
         AkKZOWbzvfgbfrOY2G34IF/RYC7vYamySUDQ9LvJ4MoDTnTvcSXkQXXdfyrUbEOdyI
         inaIrG0mMYfDQ==
From:   Lee Jones <lee@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ying Liu <victor.liu@nxp.com>
Cc:     lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
        deller@gmx.de, andy@kernel.org, linus.walleij@linaro.org,
        brgl@bgdev.pl
In-Reply-To: <20230721093342.1532531-1-victor.liu@nxp.com>
References: <20230721093342.1532531-1-victor.liu@nxp.com>
Subject: Re: (subset) [PATCH v4] backlight: gpio_backlight: Drop output
 GPIO direction check for initial power state
Message-Id: <169054289117.346169.12583682764198130810.b4-ty@kernel.org>
Date:   Fri, 28 Jul 2023 12:14:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 09:29:03 +0000, Ying Liu wrote:
> So, let's drop output GPIO direction check and only check GPIO value to set
> the initial power state.
> 
> 

Applied, thanks!

[1/1] backlight: gpio_backlight: Drop output GPIO direction check for initial power state
      commit: fe1328b5b2a087221e31da77e617f4c2b70f3b7f

--
Lee Jones [李琼斯]

